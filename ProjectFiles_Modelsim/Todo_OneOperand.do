vsim work.pipeline_integration
add wave -position end  sim:/pipeline_integration/clk
add wave -position end  sim:/pipeline_integration/INPORT
add wave -position end  sim:/pipeline_integration/OUTPORT
add wave -position end  /pipeline_integration/Reg_File/Registers
add wave -position end  sim:/pipeline_integration/PC_Val
add wave -position end  sim:/pipeline_integration/IC_Instruction
add wave -position end  sim:/pipeline_integration/Stack_Pointer
add wave -position end  sim:/pipeline_integration/CCR
add wave -position end  sim:/pipeline_integration/reset
add wave -position end  sim:/pipeline_integration/Interrupt
add wave -position end  sim:/pipeline_integration/Exception_out
add wave -position end  /pipeline_integration/Data_Mem/data_array

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

# Extra NOPs
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(12)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(13)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(14)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(15)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(16)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(17)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(18)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(19)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(20)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(21)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(22)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(23)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(24)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(25)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(26)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(27)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(28)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(29)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(30)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(31)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(32)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(33)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(34)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(35)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(36)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(37)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(38)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /pipeline_integration/IC/inst_array(39)



force -freeze sim:/pipeline_integration/clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/INPORT 00000000 0
force -freeze sim:/pipeline_integration/interrupt 0 0
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
