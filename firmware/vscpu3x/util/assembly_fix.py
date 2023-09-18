#!/bin/python3

opcodes_v1 = {"ADD" : 0, "ADDi" : 1, "NAND" : 2, "NANDi" : 3, "SRL" : 4, "SRLi" : 5, "LT" : 6, "LTi" : 7, "CP" : 8, "CPi" : 9, "CPI" : 10, "CPIi" : 11, "BZJ" : 12, "BZJi" : 13, "MUL" : 14, "MULi" : 15}

asm_file = "knightrider/knightrider.asm"
mem_file = "knightrider/knightrider.mem"

asm = open(asm_file, "r")
mem = open(mem_file, "w")

asm_lines = asm.readlines() # Read asm file

mem.write('00000000\n') # Insert first dummy line

for line in asm_lines:
	line = line[0:line.find("//")] # Trim the comment lines

	if len(line) != 0: # Now decode the remaining lines
		line = line.split(':')[1][1:]
		line = line.split() # Split opcode and register values

		if len(line) == 1: # Is this line a value
			mem.write(hex(int(line[0]))[2:].upper().zfill(8) + '\n') # Write the value as a hexadecimal 
		elif len(line) == 3: # Is this line an instruction
			# Decode the instruction
			opcode = opcodes_v1[line[0]]
			r1 = int(line[2])
			r2 = int(line[1])
			
			r1 += 1 # R1 will increase anyway
			
			if opcode % 2 == 0 or opcode == 11:
				r2 += 1 # R2 will increase if it is not an immediate instruction or CPI instruction

			# Merge instruction parameters
			opcode = bin(opcode)[2:].zfill(4)
			r1 = bin(r1)[2:].zfill(14)
			r2 = bin(r2)[2:].zfill(14)
			
			instr_word = str(opcode) + str(r2) + str(r1)
			instr_word = hex(int(instr_word, 2))[2:].zfill(8).upper()

			mem.write(instr_word + '\n') # Write the instruction as hexadecimal

mem.close()
