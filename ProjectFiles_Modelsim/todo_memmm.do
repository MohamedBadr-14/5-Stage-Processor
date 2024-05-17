force -freeze sim:/data_memory/Clk 0 0, 1 {500 ps} -r {1 ns}
force -freeze sim:/data_memory/Rst 1 0
force -freeze sim:/data_memory/Mem_Write 1 0
force -freeze sim:/data_memory/Address 00000800 0
force -freeze sim:/data_memory/Data 01234567 0
force -freeze sim:/data_memory/Mem_Read 0 0
force -freeze sim:/data_memory/Push_Pop 0 0
force -freeze sim:/data_memory/SP_Enable 0 0
run
force -freeze sim:/data_memory/Rst 0 0
force -freeze sim:/data_memory/Mem_Write 0 0
force -freeze sim:/data_memory/Mem_Read 1 0
