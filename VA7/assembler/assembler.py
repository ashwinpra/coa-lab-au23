import sys
import re
import json

REGDICT = {}
INSTRUCTION_DICT = {}
OUTPUT_FILE = open("output", "w")

def two_comp(num,nbits):
    '''
    gives nbit long two complement representation of number
    '''
    if num>=0:
        return f"{num:0{nbits}b}"
    else:
        return f"{((1<<nbits)+num):0{nbits}b}"
    

def spit_line(line):
    '''
    returns a list of the words in the line
    '''
    opcode = INSTRUCTION_DICT[line[0]][0]
    opc = int(opcode,2)

    # R-type arithmetic instructions
    if opc == 0:
        if line[0] in ["NOT", "SLA", "SRA", "SRL"]:
            # of the form OP Rd, Rt
            if len(line) != 3:
                print(f"error in line {line}")
            else:
                if line[0] == "NOT":
                    # Rd = NOT Rs
                    rd = f"{REGDICT[line[1]]:05b}"
                    rs = f"{0:05b}"
                    rt = f"{REGDICT[line[2]]:05b}"
                    shamt = f"{0:05b}"
                    funct=f"{INSTRUCTION_DICT[line[0]][5]}"
                    print(f"{opcode}_{rs}_{rt}_{rd}_{shamt}_{funct}", file = OUTPUT_FILE )
                else: 
                    # Rd = Rs op Rt 
                    # so Rt will also be Rd
                    rd = f"{REGDICT[line[1]]:05b}"
                    rs = f"{REGDICT[line[2]]:05b}"
                    rt = f"{REGDICT[line[1]]:05b}"
                    shamt = f"{0:05b}"
                    funct=f"{INSTRUCTION_DICT[line[0]][5]}"
                    print(f"{opcode}_{rs}_{rt}_{rd}_{shamt}_{funct}", file = OUTPUT_FILE )

        else: 
            if len(line) != 4: 
                print(f"error in line {line}")
                return
            else:
                rd = f"{REGDICT[line[1]]:05b}"
                rs = f"{REGDICT[line[2]]:05b}"
                rt = f"{REGDICT[line[3]]:05b}"
                shamt = f"{0:05b}"
                funct=f"{INSTRUCTION_DICT[line[0]][5]}"
                print(f"{opcode}_{rs}_{rt}_{rd}_{shamt}_{funct}", file = OUTPUT_FILE )

    # I-type arithmetic instructions

    # ADDI, SUBI, ANDI, ORI, XRI
    elif opc > 0 and opc < 6:
        if len(line) != 4:
            return
        else:
            rs = f"{REGDICT[line[2]]:05b}"
            rt = f"{REGDICT[line[1]]:05b}"
            imm = f"{int(line[3]):016b}" 
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # NOTI, SLAI, SRLI, SRAI
    elif opc >= 6 and opc < 10:
        if len(line) != 3:
            print(f"error in line {line}")
            return
        else:
            rs = f"{REGDICT[line[1]]:05b}"
            rt = f"{REGDICT[line[1]]:05b}"
            imm = f"{int(line[2]):016b}" 
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # BR                
    elif opc == 10:
        if len(line) != 2:
            print(f"error in line {line}")
            return
        else:
            rs = f"{0:05b}"
            rt = f"{0:05b}"
            imm = f"{int(line[1]):016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # BMI, BPL, BZ
    elif opc > 10 and opc < 14:
        if len(line) != 3:
            print(f"error in line {line}")
            return
        else:
            rs = f"{REGDICT[line[1]]:05b}"
            rt = f"{0:05b}"
            imm = f"{int(line[2]):016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # LD, ST, LDSP, STSP
    elif opc >= 14 and opc < 18:
        if len(line) != 4:
            print(f"error in line {line} 7")
            return
        else:
            rt = f"{REGDICT[line[1]]:05b}"
            rs = f"{REGDICT[line[2]]:05b}"
            imm = f"{int(line[3]):016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # MOVE 
    elif opc == 18:
        if len(line) != 3:
            print(f"error in line {line} 8")
            return
        else:
            rt = f"{REGDICT[line[1]]:05b}"
            rs = f"{REGDICT[line[2]]:05b}"
            imm = f"{0:016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # PUSH
    elif opc == 19:
        if len(line) != 2:
            print(f"error in line {line}")
            return
        else:
            rs = f"{REGDICT[line[1]]:05b}"
            rt = f"{0:05b}"
            imm = f"{0:016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # POP
    elif opc == 20:
        if len(line) != 2:
            print(f"error in line {line}")
            return
        else:
            rs = f"{REGDICT[line[1]]:05b}"
            rt = f"{0:05b}"
            imm = f"{0:016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # CALL 
    elif opc == 21:
        if len(line) != 2:
            print(f"error in line {line}")
            return
        else:
            rs = f"{0:05b}"
            rt = f"{0:05b}"
            imm = f"{int(line[1]):016b}"
            print(f"{opcode}_{rs}_{rt}_{imm}", file = OUTPUT_FILE )

    # HALT, NOP, RET
    elif opc > 21 and opc < 25:
        if len(line) != 1:
            print(f"error in line {line}")
            return
        else:
            imm = f"{0:016b}"
            print(f"{opcode}_{imm}", file = OUTPUT_FILE )

    return


def bin_comm(string):
    string = re.sub(re.compile("/'''.*?\'''", re.DOTALL), "", string)
    string = re.sub(re.compile("#.*?\n"), "", string)
    return string


def process(filename):
    print(f"{0:032b}", file = OUTPUT_FILE)
    with open(filename, 'r') as f:
        lines = f.readlines()
        for line in lines:
            line.strip()
            line = bin_comm(line)
            
            line = line.replace(',',' ').replace(')',' ').replace('(',' ').split()
            if len(line):
                spit_line(line)
    print(f"{0:032b}", file = OUTPUT_FILE)

if __name__ == '__main__':
    with open('instructions.json', 'r') as f:
        INSTRUCTION_DICT = json.load(f)
    with open('registers.json', 'r') as f:
        REGDICT = json.load(f)
    process(sys.argv[1])




