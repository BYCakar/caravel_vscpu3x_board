import os
import time
import argparse
import codecs
import select
import sys
import testutils

def uart_console(serial_port):
    """Run a line-buffered console on a POSIX terminal until ~. or EOF."""
    print("UART console open. Press Enter to send text followed by a NUL byte (without CR/LF).")
    print("Type ~. on a line by itself and press Enter to exit (or press Ctrl+C).")
    decoder = codecs.getincrementaldecoder('utf-8')(errors='replace')
    pending = b''
    try:
        while True:
            readable, _, _ = select.select([serial_port, sys.stdin], [], [])
            if serial_port in readable:
                data = serial_port.read(serial_port.in_waiting or 1)
                sys.stdout.write(decoder.decode(data))
                sys.stdout.flush()
            if sys.stdin in readable:
                data = os.read(sys.stdin.fileno(), 4096)
                if not data:
                    break
                pending += data
                while b'\n' in pending:
                    line, pending = pending.split(b'\n', 1)
                    line = line.replace(b'\r', b'')
                    if line == b'~.':
                        return
                    serial_port.write(line + b'\0')
                    serial_port.flush()
    except KeyboardInterrupt:
        pass
    finally:
        sys.stdout.write(decoder.decode(b'', final=True))
        print("\nUART console closed.")


def main(test_name, uart_instance, memclear, enable_uart=False):
    error_count = 0

    # Define processors and memory sizes
    processors = {
        'cm': {'name': 'codemaker', 'memory_size': 2048},
        'ct': {'name': 'control tower', 'memory_size': 2560},
        'a0': {'name': 'agent 0', 'memory_size': 1536}
    }
    
    # Iterate over processors
    for proc, info in processors.items():
        mem_file = f"../{test_name}/{test_name}_{proc}.mem"
        
        # Check if the .mem file exists
        if os.path.exists(mem_file):
            # Prompt for readiness
            input(f"Please press enter if {info['name']} is ready to program")

            # Zero memory before programming
            if memclear:
                uart_instance.WriteMemory(0, ['00000000'] * info['memory_size'])
            
            # Program memory from file
            uart_instance.WriteMemFromFile(mem_file)
            
    if enable_uart:
        input("All programs are loaded. Enable operating mode for codemaker, "
              "then press Enter to open the UART console.")
        uart_console(uart_instance.SerialPort)
        print("Please return to programming mode before reading memory.")
    else:
        print("All programs are loaded. Please exit program mode and run your code.")
        time.sleep(2)

    for proc, info in processors.items():
        chk_file = f"../{test_name}/{test_name}_{proc}_chk.mem"
        
        # Check if the .chk.mem file exists
        if os.path.exists(chk_file):
            # Prompt for readiness
            input(f"Please press enter if the program has run and {info['name']} is ready to read")

            # Check memory using CheckMemFromFile
            result = uart_instance.CheckMemFromFile(chk_file)
            if not result:
                print(f"Test FAILED for {info['name']}")
                error_count += 1


    # If all checks passed or no chk files exist
    if error_count == 0:
        print("Test SUCCEEDED")
    else:
        print("Test FAILED")

if __name__ == "__main__":

    # Argument parser setup
    parser = argparse.ArgumentParser(description="Run tests on processors.")
    parser.add_argument('test_name', type=str, help="The name of the test, e.g. bubble_sort.")
    parser.add_argument('uart_device', type=str, help="Path to UART device, e.g. /dev/ttyUSB0.")
    parser.add_argument('-nomemclear', action='store_false', help="Disable memory zeroing before programming.", default=True)
    parser.add_argument('-uart', action='store_true',
                        help="Open the codemaker UART console in operating mode; ~. then Enter exits.")
    
    # Parse arguments
    args = parser.parse_args()
    
    uart_baudrate = 57600 # Please edit this part if you have different baud rate

    uart_instance = testutils.uart(args.uart_device, uart_baudrate, 8, 'N', 1)
    try:
        main(args.test_name, uart_instance, args.nomemclear, args.uart)
    finally:
        uart_instance.Close()
