#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run vivado
    #
#-------------------------------------------------------------------------------

#*** USAGE *********************************************************************
default:
	@ clear
	@ echo "MAKE TARGETS:                                      "
	@ echo "    create      create a vivado project and open it"
	@ echo "    clean       clean all files                    "
	@ echo "                                                   "
	@ echo "CONTENTS IN CONFIGURATION MAKEFILE:                "
	@ cat makefile | sed "s/\(.*\)/    \1/"


#*** MAIN BODY *****************************************************************
create: clean
	cp ../vv_script/top.tcl .
	sed -i 's#$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#g' top.tcl
	sed -i 's#$$SYN_TOP#$(SYN_TOP)#g' top.tcl
	sed -i 's#$$SYN_TAR#$(SYN_TAR)#g' top.tcl
	sed -i 's#$$SIM_TOP#$(SIM_TOP)#g' top.tcl
	sed -i 's#$$STP_LVL#$(STP_LVL)#g' top.tcl
	sed -i 's#$$SEED#$(SEED)#g'       top.tcl
	setenv XILINXD_LICENSE_FILE /home/Xilinx/vivado_general.lic    ;\
	source /home/Xilinx/Vivado/2017.4/settings64.csh               ;\
	vivado -mode gui -source top.tcl > /dev/null &
	sleep 60
	mkdir -p $(SYN_TOP).sim/sim_1/behav/xsim/check_data
	ln -f $(ENV_CSTR_DIR_PRJ)/sim/rtl_$(SYN_TOP)/check_data/* $(SYN_TOP).sim/sim_1/behav/xsim/check_data
	mkdir -p $(SYN_TOP).sim/sim_1/synth/func/xsim/check_data
	ln -f $(ENV_CSTR_DIR_PRJ)/sim/rtl_$(SYN_TOP)/check_data/* $(SYN_TOP).sim/sim_1/synth/func/xsim/check_data

clean:
	- rm -rf ./top.tcl
	- rm -rf ./vivado*
	- rm -rf ./$(SYN_TOP).cache
	- rm -rf ./$(SYN_TOP).hw
	- rm -rf ./$(SYN_TOP).ip_user_files
	- rm -rf ./$(SYN_TOP).sim
	- rm -rf ./$(SYN_TOP).runs
	- rm -rf ./$(SYN_TOP).xpr
	- rm -rf ./.Xil
