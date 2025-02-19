for i in $(seq 1 1000)
do
    make sim SIM_DATA_SEED=$RANDOM
    diff simul_data/in.log simul_data/out.log -q
    if [ $? -ne 0 ]
    then
        echo "ERROR!"
        break
    fi
done
