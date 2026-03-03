CSTR_USAGE="[information from $0] usage: ./run.sh [-S <DATA_WD>]"

S=32
while getopts ":S:" opt
do
    case $opt in
    S)
        S=$OPTARG
    ;;
    ?)
        echo "[error from $0] wrong parameter [$*]!" >& 2;
        echo $CSTR_USAGE >& 2
        exit 1
    ;;
    esac
done

iverilog gray2bin.v bin2gray.v tb_gray2bin.v -DTEST_DATA_WD=$S -o tb_gray2bin.o
./tb_gray2bin.o

#gtkwave waveform.vcd

#rm *.o *.txt *.vcd
