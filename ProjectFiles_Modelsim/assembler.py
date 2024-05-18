import re

def adjust_instruction(instruction):
    opcode = instruction[0]
    if opcode == 'nop':
        instruction.append('0')
        instruction.append('0')
        instruction.append('0')
    elif opcode == 'mov':
        instruction.append('0')
        instruction[1], instruction[2], instruction[3] = instruction[2], instruction[3], instruction[1]

    elif opcode == 'not' or opcode == 'neg' or opcode == 'inc' or opcode == 'dec': #not rdst
        instruction.append('0')
        instruction.append('0')
        instruction[1], instruction[2], instruction[3] = '0', '0', instruction[1] #to be tested badrrrrr

    elif opcode == 'ldd': #LDD Rdst, EA(Rsrc1)
         tmp = instruction[2]
         parts = tmp.split('(')
         imm = parts[0]
         rval = parts[1].rstrip(')')
         instruction.append(instruction[1])
         instruction.append(instruction[1])
         instruction [1], instruction [2], instruction[3], instruction[4] = rval, instruction[1], '0', imm 

    elif opcode == 'swap': #swap rdst,rsr1 rsr1 -> rsr1 , rdrt,0
        instruction.append('0')
        instruction[1], instruction[2], instruction[3] = instruction[2], instruction[1], instruction[2]

    elif opcode == 'add' or opcode == 'sub' or opcode == 'and' or opcode == 'or' or opcode == 'xor' : #add rdst , rsrc1 , rsrc2
         instruction[1], instruction[2], instruction[3] = instruction[2], instruction[3], instruction[1]

    elif opcode == 'addi' or opcode == 'subi': #SUBI Rdst, Rsrc1, Imm
         instruction.append(instruction[1])
         instruction [1], instruction [2], instruction[3], instruction[4] = instruction[2], '0', instruction[1], instruction[3]

    elif opcode == 'ldm': #LDM Rdst, Imm
         instruction.append(instruction[1])
         instruction.append(instruction[1])
         instruction [1], instruction [2], instruction[3], instruction[4] = '0', instruction[1], '0', instruction[2]
    elif  opcode == 'jz' or opcode == 'jmp' or opcode == 'call': #CALL Rdst
         instruction.append(instruction[1])
         instruction.append(instruction[1])
         instruction[1] , instruction[2] , instruction[3] = '0' , instruction[1] , '0'

    elif opcode == 'std': #STD Rsrc1, EA(Rsrc2)
         tmp = instruction[2]
         parts = tmp.split('(')
         imm = parts[0]
         rval = parts[1].rstrip(')')
         instruction.append(instruction[1])
         instruction.append(instruction[1])
         instruction [1], instruction [2], instruction[3], instruction[4] =  rval, instruction [1],'0',imm 


    elif  opcode == 'ret' or opcode == 'rti':
         instruction.append('0')
         instruction.append('0')   
         instruction.append('0')  
              
    elif opcode == 'out' or opcode == 'in':
        instruction.append(instruction[1])
        instruction.append('0')
    elif opcode == 'push' or opcode == 'protect' or opcode == 'free':
         instruction.append('0')
         instruction.append('0')
    elif opcode == 'pop': #pop rdst
        instruction.append('0')
        instruction.append('0')
        instruction [1], instruction [2], instruction[3] =  '0', instruction [1],'0'
    elif opcode == 'cmp':
        instruction.append('0')
    return instruction

def main():

    instruction_map = {
    'nop': '00000',
    'not': '00001',
    'neg': '00010',
    'inc': '00011',
    'dec': '00100',
    'out': '00101',
    'in': '00110',
    'mov': '00111',
    'swap': '01000',
    'add': '01001',
    'addi': '01010',
    'sub': '01011',
    'subi': '01100',
    'and': '01101',
    'or': '01110',
    'xor': '01111',
    'cmp': '10000',
    'ldm': '10001',
    'push': '10010',
    'pop': '10011',
    'ldd': '10100',
    'std': '10101',
    'protect': '10110',
    'free': '10111',
    'jz': '11000',
    'jmp': '11001',
    'call': '11010',
    'ret': '11011',
    'rti': '11100',
}
    memory = ['0'*16 for _ in range (4096)]

    with open("code.txt", "r") as file:

        instructions = file.readlines()
    file.close()
    print("FIRSTTTTT")
    print(instructions)

    instructions = [re.sub(r"\s*#.*", "", inst).replace(",", " ").split() for inst in instructions]
    instructions = [inst for inst in instructions if any(item.strip() for item in inst)]
    print("SECONDD")
    print (instructions)
    instructions = [[word.lower() for word in inst] for inst in instructions]
    print("THIRDD")
    print(instructions)

    instructions = [[word if i == 0 else word.replace('r', '') for i, word in enumerate(inst)] for inst in instructions]
    print("FORTHHHH")
    print(instructions)

    instructions = [inst if inst[0] == '.org' else adjust_instruction(inst) for inst in instructions]
    print("FIFTHHH")
    print(instructions)


    instructions =  [
    [instruction_map[word] if i == 0 else format(int(word, 16), '03b') + '00' if i==3 else format(int(word, 16), '016b') if i == 4 else format(int(word, 16), '03b') for i, word in enumerate(inst)] 

    if inst[0] != '.org' and len(inst) > 1 
    else [format(int(inst[0], 16), '016b')] if len(inst) == 1 and inst[0] not in ['ret', 'rti', 'nop'] 
    else inst 
    for inst in instructions
    ]
    print("SIXTHHH")
    print(instructions)

    ListOfInstructions = []
    for inst in instructions:
        if len(inst) > 4:
            ListOfInstructions.append(''.join(inst[:4]))
            ListOfInstructions.append(inst[4])
        else:
            ListOfInstructions.append(''.join(inst))

    currentIndex = 0
    for row in range(len(ListOfInstructions)):
        if '.org' in ListOfInstructions[row]:

            currentIndex = int(ListOfInstructions[row].replace('.org', ''), 16)
            print("Current Index")
            print(currentIndex)
        else:
            memory[currentIndex] = ListOfInstructions[row]
            currentIndex += 1

    with open('memout.mem', 'w') as f:
        f.write('\n'.join(memory))
    f.close()




if __name__ == "__main__":
    main()
