#!/bin/python3

import serial
import time

class uart:
    def __init__(self, port, baudrate, bytesize, parity, stopbits):
        self.SerialPort = serial.Serial(port)

        self.SerialPort.baudrate = baudrate  # set Baud rate to 9600
        self.SerialPort.bytesize = bytesize     # Number of data bits = 8
        self.SerialPort.parity   = parity    # No parity
        self.SerialPort.stopbits = stopbits     # Number of Stop bits = 1
        
        self.SerialPort.timeout  = 0.05

        print('\nStatus -> ', self.SerialPort)
        

    def Close(self):
        self.SerialPort.close()

    def ReadWord(self, address): # Read 32 bit hex word from memory
        RXWord = ""
        self.SerialPort.reset_input_buffer()
        
        # Try read until 8 bytes response is received 
        while len(RXWord) < 8:
            self.SerialPort.write(b'R' + bytes(dec2hex(address, 4), 'UTF-8')) # Convert int address to hex and send read request
        
            RXWord = ""
            
            #time.sleep(self.SerialPort.timeout) # Wait read timeout
            
            for i in range(8): # Read all hex values from RX and concat
                RXHex = self.SerialPort.read()
                RXWord = RXWord + str(RXHex, 'UTF-8')
            
        # self.SerialPort.reset_input_buffer()
        return RXWord 
    
    def ReadMemory(self, address, datacount): # Read multiple hex words from memory
        mem = []
        current_address = address
        
        for _ in range(datacount):
            # Read each word from the memory using ReadWord and append to mem
            word = self.ReadWord(current_address)
            mem.append(word)
            
            # Increment the address for the next word (assuming word size is 1 here)
            current_address += 1
        
        return mem
        
    def WriteWord(self, address, data): # Write 32 bit hex word into memory
        RXWord = self.ReadWord(address) # Set address pointer
        
        while RXWord != data:
            self.SerialPort.write(b'W' + bytes(data, 'UTF-8')) # Send write request
            RXWord = self.ReadWord(address) # Write check
        
    def WriteInt(self, address, data): # Write integer value into memory
        RXWord = self.ReadWord(address) # Set address pointer
        
        while RXWord != data:
            self.SerialPort.write(b'W' + bytes(dec2hex(data, 8), 'UTF-8')) # Convert int data to hex and send write request
            RXWord = self.ReadWord(address) # Write check          
                    
    def WriteMemory(self, startAddr, mem): # Write multiple hex words into memory and read back to check
        waddr = startAddr
        
        for data in mem:
            self.WriteWord(waddr, data)
            waddr = waddr + 1
            
    def WriteMemFromFile(self, filename): # Write all program memory from a mem file
        with open(filename, 'r') as file:
            lines = file.readlines()

        start_address = None
        memory_data = []

        for line in lines:
            line = line.strip()

            # Check if the line contains a memory start address marked by "@"
            if line.startswith('@'):
                if start_address is not None:
                    # Write the previous memory block to the target address
                    self.WriteMemory(start_address, memory_data)
                
                # Get the new start address, removing the '@' symbol
                start_address = int(line[1:])
                memory_data = []
            else:
                # Split the data line into individual words
                memory_data.extend(line.split())
        
        # Write any remaining data
        if start_address is not None:
            self.WriteMemory(start_address, memory_data)
                
    def CheckMemFromFile(self, filename):
        mismatch_count = 0  # To count mismatches
        
        with open(filename, 'r') as file:
            lines = file.readlines()

        start_address = None
        expected_memory = []

        for line in lines:
            line = line.strip()

            # Check if the line contains a memory start address marked by "@"
            if line.startswith('@'):
                if start_address is not None:
                    # Read the memory from the actual system using ReadMemory
                    actual_memory = self.ReadMemory(start_address, len(expected_memory))
                    
                    # Compare the actual memory data with the expected data
                    for i, (expected, actual) in enumerate(zip(expected_memory, actual_memory)):
                        if expected != actual:
                            print(f"Mismatch at address {start_address+i}! Expected: {expected}, Actual: {actual}")
                            mismatch_count += 1

                # Get the new start address, removing the '@' symbol and converting to integer
                start_address = int(line[1:])
                expected_memory = []
            else:
                # Split the data line into individual words
                expected_memory.extend(line.split())
        
        # Check the last block of memory
        if start_address is not None:
            actual_memory = self.ReadMemory(start_address, len(expected_memory))
            
            for i, (expected, actual) in enumerate(zip(expected_memory, actual_memory)):
                if expected != actual:
                    print(f"Mismatch at address {start_address+i}! Expected: {expected}, Actual: {actual}")
                    mismatch_count += 1

        # Return False if any mismatches were found, otherwise return True
        return mismatch_count == 0

def dec2hex(dec, width): # Convert decimal to hex
    return hex(dec).split('x')[-1].upper().zfill(width)
