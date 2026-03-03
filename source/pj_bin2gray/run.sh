CSTR_USAGE="[information from $0] usage: ./run.sh [-S <DATA_WD>]"

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

gcc bin2gray.c -o bin2gray.o
./bin2gray.o $S
iverilog bin2gray.v tb_bin2gray.v -o tb_bin2gray.o
./tb_bin2gray.o

#gtkwave waveform.vcd

#rm *.o *.txt *.vcd
