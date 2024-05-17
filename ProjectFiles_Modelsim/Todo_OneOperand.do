vsim work.pipeline_integration
add wave -position end  sim:/pipeline_integration/clk
add wave -position end  sim:/pipeline_integration/reset
add wave -position end  sim:/pipeline_integration/INPORT
add wave -position end  sim:/pipeline_integration/OUTPORT
add wave -position end  sim:/pipeline_integration/Exception_out
add wave -position end  sim:/pipeline_integration/PC_Address
add wave -position end  sim:/pipeline_integration/IC_Instruction
add wave -position end  /pipeline_integration/Reg_File/Registers
add wave -position end  sim:/pipeline_integration/Operand1
add wave -position end  sim:/pipeline_integration/Operand2
add wave -position end  sim:/pipeline_integration/ALU_Res1
add wave -position end  sim:/pipeline_integration/MEM_WB_Res1_Out
add wave -position end  sim:/pipeline_integration/MEM_WB_RegDst_Out
add wave -position end  sim:/pipeline_integration/MEM_WB_RegWrite1_Out
add wave -position end  sim:/pipeline_integration/CCR

mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(0)
mem load -filltype value -filldata 0000100100000100 -fillradix binary /pipeline_integration/IC/inst_array(1)
mem load -filltype value -filldata 0001100100000100 -fillradix binary /pipeline_integration/IC/inst_array(2)
mem load -filltype value -filldata 0011000000100000 -fillradix binary /pipeline_integration/IC/inst_array(3)
mem load -filltype value -filldata 0011000001000000 -fillradix binary /pipeline_integration/IC/inst_array(4)
mem load -filltype value -filldata 0000101000001000 -fillradix binary /pipeline_integration/IC/inst_array(5)
mem load -filltype value -filldata 0001100100000100 -fillradix binary /pipeline_integration/IC/inst_array(6)	
mem load -filltype value -filldata 0010100100000000 -fillradix binary /pipeline_integration/IC/inst_array(7)	
mem load -filltype value -filldata 0010101000000000 -fillradix binary /pipeline_integration/IC/inst_array(8)	
mem load -filltype value -filldata 0010001000001000 -fillradix binary /pipeline_integration/IC/inst_array(9)
mem load -filltype value -filldata 0001001000001000 -fillradix binary /pipeline_integration/IC/inst_array(10)
mem load -filltype value -filldata 0010101000000000 -fillradix binary /pipeline_integration/IC/inst_array(11)


force -freeze sim:/pipeline_integration/clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/INPORT 00000000 0
run

force -freeze sim:/pipeline_integration/reset 0 0
run
run
run

force -freeze sim:/pipeline_integration/INPORT 00000005 0
run

force -freeze sim:/pipeline_integration/INPORT 00000010 0
run

force -freeze sim:/pipeline_integration/INPORT 00000000 0
