vsim work.pipeline_integration
add wave -position end  sim:/pipeline_integration/clk
add wave -position end  sim:/pipeline_integration/reset
add wave -position end  sim:/pipeline_integration/INPORT
add wave -position end  sim:/pipeline_integration/OUTPORT
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

mem load -filltype value -filldata 0101001000001000 -fillradix binary /pipeline_integration/IC/inst_array(0)
mem load -filltype value -filldata 1111111111111111 -fillradix binary /pipeline_integration/IC/inst_array(1)
mem load -filltype value -filldata 0110011000011000 -fillradix binary /pipeline_integration/IC/inst_array(2)
mem load -filltype value -filldata 0000000000000011 -fillradix binary /pipeline_integration/IC/inst_array(3)

force -freeze sim:/pipeline_integration/clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/INPORT 00000000 0
run

force -freeze sim:/pipeline_integration/reset 0 0
