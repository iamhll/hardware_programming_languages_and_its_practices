iverilog divide.v tb_divide.v -o tb_divide.o
./tb_divide.o

#gtkwave waveform.vcd

#rm *.o *.txt *.vcd
