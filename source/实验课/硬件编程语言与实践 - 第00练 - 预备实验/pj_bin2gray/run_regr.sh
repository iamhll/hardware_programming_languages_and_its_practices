for i in $(seq 2 32)
do
    echo "DATA_WD $i"
    ./run.sh -S $i
done
