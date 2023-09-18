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

    '''def WriteBurst(self, startAddr, mem): # Write multiple hex words into memory
        self.SerialPort.write(b'R' + bytes(dec2hex(startAddr, 4), 'UTF-8')) # Set start address
        for i in range(8): # Read all hex values from RX and concat
            RXHex = self.SerialPort.read()
            
        for data in mem:
            self.SerialPort.write(b'W' + bytes(data, 'UTF-8')) # Send write request
            time.sleep(0.050)'''
                    
    def WriteMemory(self, startAddr, mem): # Write multiple hex words into memory and read back to check
        waddr = startAddr
        
        for data in mem:
            self.WriteWord(waddr, data)
            waddr = waddr + 1
            
        '''self.WriteBurst(0, mem) # Write memory data
        
        error = 0
        raddr = 0
        
        for checkData in mem: # Read memory data back
            rdata = self.ReadWord(raddr)
            
            if rdata != checkData: # Is there any mismatch?
                print("Data read from memory at the address " + str(raddr) + " = 0x" + rdata + ". The written data is = 0x" + checkData)
                error = 1
                
            raddr = raddr + 1
            time.sleep(0.050)

        # Let user know if memory write failed or not
        if error == 0: 
            print("Memory write SUCCEEDED!")
        else:
            print("There are data mismatches. Memory write FAILED!")
            
        return error'''

def dec2hex(dec, width): # Convert decimal to hex
    return hex(dec).split('x')[-1].upper().zfill(width)
