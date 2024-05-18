vsim work.pipeline_integration
add wave -position end  sim:/pipeline_integration/Memory_Address
add wave -position end  sim:/pipeline_integration/Memory_Out
add wave -position end  sim:/pipeline_integration/clk
add wave -position end  sim:/pipeline_integration/reset
add wave -position end  sim:/pipeline_integration/INPORT
add wave -position end  sim:/pipeline_integration/PC_Address
add wave -position end  sim:/pipeline_integration/IC_Instruction
add wave -position end  /pipeline_integration/Reg_File/Registers
add wave -position end  /pipeline_integration/PSR/PF_array
add wave -position end  sim:/pipeline_integration/Operand1
add wave -position end  sim:/pipeline_integration/Operand2
add wave -position end  sim:/pipeline_integration/ALU_Res1
add wave -position end  sim:/pipeline_integration/ALU_Res2
add wave -position end  sim:/pipeline_integration/Memory_Data
add wave -position end  sim:/pipeline_integration/Memory_Address
add wave -position end  /pipeline_integration/PSR/Write_enable
add wave -position end  /pipeline_integration/PSR/Res1
add wave -position end  /pipeline_integration/PSR/Write_enable
add wave -position end  /pipeline_integration/PSR/Protect_Free
add wave -position end  /pipeline_integration/PSR/isProtected
add wave -position end  sim:/pipeline_integration/EX_MEM_Dst_10_8_Out
add wave -position end  sim:/pipeline_integration/RegDst_MUX_Out
add wave -position end  sim:/pipeline_integration/Prot_Reg_isProtected
add wave -position end  sim:/pipeline_integration/MemWrite_Final
add wave -position end  sim:/pipeline_integration/Memory_Out_Range
add wave -position end  /pipeline_integration/Data_Mem/data_array


# free not protected
#IN R1            #R1 = 211
#FREE R1          #P[211] = 0

# Protect then Free
#IN R1            #R1 = 211 
#PROTECT R1       #P[211]=1
#ADD R5, R4, R3   #R5=1E
#FREE R1          #P[211]=0
#STD R5, 0(R1)    #M[211]=1E

# Exceptions
#IN R2            #R2 = 100 
#PROTECT R2       #P[100]=1
#STD R1, 0(R2)    # PROTECTED EXCEPTION

mem load -filltype value -filldata 0011000100100000 -fillradix binary /pipeline_integration/IC/inst_array(0)
mem load -filltype value -filldata 1011100100000000 -fillradix binary /pipeline_integration/IC/inst_array(1)
mem load -filltype value -filldata 0011000100100000 -fillradix binary /pipeline_integration/IC/inst_array(2)
mem load -filltype value -filldata 1011000100000000 -fillradix binary /pipeline_integration/IC/inst_array(3)
mem load -filltype value -filldata 0011001101100000 -fillradix binary /pipeline_integration/IC/inst_array(4)
mem load -filltype value -filldata 0011010010000000 -fillradix binary /pipeline_integration/IC/inst_array(5)
mem load -filltype value -filldata 0100110001110100 -fillradix binary /pipeline_integration/IC/inst_array(6)
mem load -filltype value -filldata 1011100100000000 -fillradix binary /pipeline_integration/IC/inst_array(7)
mem load -filltype value -filldata 1010100110100000 -fillradix binary /pipeline_integration/IC/inst_array(8)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(9)
mem load -filltype value -filldata 0011001001000000 -fillradix binary /pipeline_integration/IC/inst_array(10)
mem load -filltype value -filldata 1011001000000000 -fillradix binary /pipeline_integration/IC/inst_array(11)
mem load -filltype value -filldata 1010101000100000 -fillradix binary /pipeline_integration/IC/inst_array(12)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(13)


force -freeze sim:/pipeline_integration/clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/INPORT 00000000 0
run

force -freeze sim:/pipeline_integration/reset 0 0

force -freeze sim:/pipeline_integration/INPORT 00000211 0
#run

#force -freeze sim:/pipeline_integration/INPORT 00000000 0
#run

#force -freeze sim:/pipeline_integration/INPORT 00000211 0
#run

#force -freeze sim:/pipeline_integration/INPORT 00000000 0
#run

#force -freeze sim:/pipeline_integration/INPORT 00000019 0
#run
#force -freeze sim:/pipeline_integration/INPORT 00000005 0
#run

#force -freeze sim:/pipeline_integration/INPORT 00000000 0
#run
#run
#run
#run

#force -freeze sim:/pipeline_integration/INPORT 00000100 0
#run

#force -freeze sim:/pipeline_integration/INPORT 00000000 0
#run
#run
#run
