gcc adder.c -o adder.o
./adder.o
iverilog adder.v tb_adder.v -o tb_adder.o
./tb_adder.o

#gtkwave waveform.vcd

#rm *.o *.txt *.vcd
