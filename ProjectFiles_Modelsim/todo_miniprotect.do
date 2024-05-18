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

mem load -filltype value -filldata 0011000100100000 -fillradix binary /pipeline_integration/IC/inst_array(0)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(1)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(2)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(3)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(4)
mem load -filltype value -filldata 1011000100000000 -fillradix binary /pipeline_integration/IC/inst_array(5)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(6)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(7)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(8)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(9)
mem load -filltype value -filldata 1011100100000000 -fillradix binary /pipeline_integration/IC/inst_array(10)


force -freeze sim:/pipeline_integration/clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/INPORT 00000000 0
run

force -freeze sim:/pipeline_integration/reset 0 0

force -freeze sim:/pipeline_integration/INPORT 00000211 0
run

force -freeze sim:/pipeline_integration/INPORT 00000000 0
