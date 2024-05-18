vsim -gui work.pipeline_integration
# End time: 12:48:41 on May 18,2024, Elapsed time: 0:08:33
# Errors: 0, Warnings: 27
# vsim -gui work.pipeline_integration 
# Start time: 12:48:41 on May 18,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.pipeline_integration(pipeline_integration_arch)
# Loading work.program_counter(pc_arch)
# Loading work.pc_circuit(behavioral)
# Loading work.mux_2x1_generic(arch1)
# Loading work.handle_int(behavioral)
# Loading work.hazard_detection_unit(arch1)
# Loading work.instruction_memory(ic_arch)
# Loading work.sign_extender(arch1)
# Loading work.if_id_pipe_reg(arch1)
# Loading work.branching_decode(behavior)
# Loading work.predictor(a_my_dff)
# Loading work.my_dff(a_my_dff)
# Loading work.controller(arch1)
# Loading work.register_file(arch1)
# Loading work.id_ex_pipe_reg(arch1)
# Loading work.alu_controller(arch1)
# Loading work.forwarding_unit(arch1)
# Loading work.mux_8x1_generic(arch1)
# Loading work.alu(alu_arch)
# Loading work.aluparta(aluparta_arch)
# Loading work.sixteenbitadder(sixteenbitadder_arch)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# Loading work.select_adder(a_my_adder)
# Loading work.alupartb(alupartb_arch)
# Loading work.my_dff_reset0(a_my_dff)
# Loading work.ex_mem_pipe_reg(arch1)
# Loading work.sp_circuit(arch1)
# Loading work.interrupt_handler(behavioral)
# Loading work.mux_4x1_generic(arch1)
# Loading work.data_memory(data_memory_arch)
# Loading work.protectstatusregister(protectstatusregister_arch)
# Loading work.mem_wb_pipe_reg(arch1)
# ** Warning: (vsim-8683) Uninitialized out port /pipeline_integration/A_L_U/partb/Cout has no driver.
# This port will contribute value (U) to the signal network.

mem load -i C:/Users/moham/Desktop/ARCHI/project/5-Stage-Processor/ProjectFiles_Modelsim/memout.mem -format binary -startaddress 0 -endaddress 4095 /pipeline_integration/IC/inst_array


add wave -position end  sim:/pipeline_integration/clk
add wave -position end  sim:/pipeline_integration/reset
add wave -position end  sim:/pipeline_integration/interrupt
add wave -position end  sim:/pipeline_integration/PC_Address
add wave -position end  sim:/pipeline_integration/Enable_Pipline
add wave -position end  sim:/pipeline_integration/WB_Ctrl_Signal
add wave -position end  sim:/pipeline_integration/ID_EX_DST_10_8_Out
add wave -position end  sim:/pipeline_integration/RegDst_MUX_Out
add wave -position end  sim:/pipeline_integration/IC_Instruction
add wave -position end  /pipeline_integration/Reg_File/Registers
add wave -position end  sim:/pipeline_integration/Rdst_Val
add wave -position end  sim:/pipeline_integration/PC_Val
add wave -position end  sim:/pipeline_integration/PC_Plus_One
add wave -position end  sim:/pipeline_integration/Branch_Prediction
add wave -position end  sim:/pipeline_integration/CCR
add wave -position end  sim:/pipeline_integration/Should_Not_Branch
add wave -position end  sim:/pipeline_integration/Should_Branch
add wave -position end  sim:/pipeline_integration/IF_ID_Inst_Out
add wave -position end  sim:/pipeline_integration/Memory_Out
add wave -position end  sim:/pipeline_integration/INPORT



force -freeze sim:/pipeline_integration/clk 0 0, 1 {100 ps} -r {200 ps}
force -freeze sim:/pipeline_integration/reset 1 0
force -freeze sim:/pipeline_integration/interrupt 0 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/PSR
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/Reg_File
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/Reg_File
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/IC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/IC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/IC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /pipeline_integration/PC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 3  Instance: /pipeline_integration/IC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 3  Instance: /pipeline_integration/IC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 3  Instance: /pipeline_integration/IC
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 3  Instance: /pipeline_integration/PSR



force -freeze sim:/pipeline_integration/reset 0 0




force -freeze sim:/pipeline_integration/INPORT 'h30 0
run
run
force -freeze sim:/pipeline_integration/INPORT 'h50 0
run
run
force -freeze sim:/pipeline_integration/INPORT 'h100 0
run
run
force -freeze sim:/pipeline_integration/INPORT 'h500 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -2 is not in bounds of subtype NATURAL.
#    Time: 3300 ps  Iteration: 5  Instance: /pipeline_integration/PSR
force -freeze sim:/pipeline_integration/INPORT 'h60 0
run
run
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -2 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 9  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -2 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 10  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -4 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 11  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -8 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 12  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -16 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 13  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -256 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 15  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -4096 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 16  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -65536 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 17  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -1048576 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 18  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -16777216 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 19  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -268435456 is not in bounds of subtype NATURAL.
#    Time: 3500 ps  Iteration: 20  Instance: /pipeline_integration/PSR
run
run

run
run
run
run
run
force -freeze sim:/pipeline_integration/INPORT 'h70 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -2 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 9  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -2 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 10  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -4 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 11  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -8 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 12  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -16 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 13  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -256 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 15  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -4096 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 16  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -65536 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 17  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -1048576 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 18  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -16777216 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 19  Instance: /pipeline_integration/PSR
# ** Warning: (vsim-151) NUMERIC_STD.TO_INTEGER: Value -268435456 is not in bounds of subtype NATURAL.
#    Time: 6100 ps  Iteration: 20  Instance: /pipeline_integration/PSR
run