vsim work.pipeline_integration
add wave -position end  sim:/pipeline_integration/clk
add wave -position end  /pipeline_integration/Reg_File/Registers
add wave -position end  sim:/pipeline_integration/EX_MEM_MeM_In_Adrs_Out 
add wave -position end  sim:/pipeline_integration/EX_MEM_MeM_Data_Out 
add wave -position end  sim:/pipeline_integration/Memory_Data
add wave -position end  sim:/pipeline_integration/Memory_Address
add wave -position end  sim:/pipeline_integration/MemWrite_Final 
add wave -position end  sim:/pipeline_integration/Stack_Pointer
add wave -position end  /pipeline_integration/Data_Mem/data_array


mem load -filltype value -filldata 0011000100100000 -fillradix binary /pipeline_integration/IC/inst_array(0)
mem load -filltype value -filldata 0011001001000000 -fillradix binary /pipeline_integration/IC/inst_array(1)
mem load -filltype value -filldata 0011001101100000 -fillradix binary /pipeline_integration/IC/inst_array(2)
mem load -filltype value -filldata 0011010010000000 -fillradix binary /pipeline_integration/IC/inst_array(3)
mem load -filltype value -filldata 0011010110100000 -fillradix binary /pipeline_integration/IC/inst_array(4)
mem load -filltype value -filldata 1010110101000000 -fillradix binary /pipeline_integration/IC/inst_array(5)
mem load -filltype value -filldata 0000001000000000 -fillradix binary /pipeline_integration/IC/inst_array(6)
mem load -filltype value -filldata 1010110100100000 -fillradix binary /pipeline_integration/IC/inst_array(7)
mem load -filltype value -filldata 0000001000000001 -fillradix binary /pipeline_integration/IC/inst_array(8)
mem load -filltype value -filldata 1010010101100000 -fillradix binary /pipeline_integration/IC/inst_array(9)
mem load -filltype value -filldata 0000001000000001 -fillradix binary /pipeline_integration/IC/inst_array(10)
mem load -filltype value -filldata 1010010110000000 -fillradix binary /pipeline_integration/IC/inst_array(11)
mem load -filltype value -filldata 0000001000000000 -fillradix binary /pipeline_integration/IC/inst_array(12)
mem load -filltype value -filldata 0100110001110100 -fillradix binary /pipeline_integration/IC/inst_array(13)

force -freeze sim:/pipeline_integration/clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/INPORT 00000000 0
run

force -freeze sim:/pipeline_integration/reset 0 0

force -freeze sim:/pipeline_integration/INPORT 00000019 0
run

force -freeze sim:/pipeline_integration/INPORT 00000005 0
run

force -freeze sim:/pipeline_integration/INPORT FFFFFFFF 0
run

force -freeze sim:/pipeline_integration/INPORT FFFFF320 0
run

force -freeze sim:/pipeline_integration/INPORT 00000010 0
run
