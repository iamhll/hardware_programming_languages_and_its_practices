cd ..

./run.sh
echo "you will get default yuv (1ade311a00d7eb83bd683a80e9678dee)"
echo "***********************************************************"
echo ""

./run.sh -R "--fltFlgProc 1 --fltDatCoe_0_1 -1 --fltDatCoe_1_0 -1 --fltDatCoe_1_1 5 --fltDatCoe_1_2 -1  --fltDatCoe_2_1 -1"
echo "you will get filtered yuv (2d53b9b6f4592e8b59eb3cae9f689079)"
echo "************************************************************"
echo ""

./run.sh -R "--fltFlgProc 1 --fltDatCoe_0_0 0.1 --fltDatCoe_0_1 0.1 --fltDatCoe_0_2 0.1 --fltDatCoe_1_0 0.1 --fltDatCoe_1_1 0.2 --fltDatCoe_1_2 0.1 --fltDatCoe_2_0 0.1 --fltDatCoe_2_1 0.1 --fltDatCoe_2_2 0.1"
echo "you will get filtered yuv (88ef56131f551f47dfa6c4aaf4b8c52a)"
echo "************************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_0 1"
echo "you will get \"osded\" yuv (ca5ce09481508cff7497d1e30895148b)"
echo "***********************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_1 1"
echo "you will get \"osded\" yuv (2b2831a83c8f7c055789ef8e3c9319a1)"
echo "***********************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_2 1"
echo "you will get \"osded\" yuv (f0bec17f41af347b432c5ed3a512b25f)"
echo "***********************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_3 1"
echo "you will get \"osded\" yuv (06cf8e2cc973ff535f2652da5ff17cbe)"
echo "***********************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_4 1"
echo "you will get \"osded\" yuv (a3e1ebccc616f371665378871da64107)"
echo "***********************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_0 1 --osdDatScl_0_0 2 --osdDatScl_0_1 3"
echo "you will get \"osded\" yuv (04ed64b5998d83098cb05b5883318114)"
echo "***********************************************************"
echo ""

./run.sh -R "--osdFlgProc 1 --osdFlg_0 1 --osdFlg_1 1 --osdFlg_2 1 --osdFlg_3 1 --osdFlg_4 1"
echo "you will get \"osded\" yuv (8f56d1c8df99514eeceb44ebf8294eaa)"
echo "***********************************************************"
echo ""

cd - > /dev/null
