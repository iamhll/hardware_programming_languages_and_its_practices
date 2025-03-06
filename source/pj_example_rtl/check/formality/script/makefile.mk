#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run formality
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
# SHELL
	SHELL = /bin/bash

# ENV_CSTR_DIR_PRJ
# !!! "../../.." does not work.
	ENV_CSTR_DIR_PRJ = $(shell cd ../../..; pwd)

# CSTR_DIR
	CSTR_DIR = session
	CSTR_LOG = log/chk.log


#*** USAGE *********************************************************************
default:
	@	echo "TARGETS                                                   "
	@	echo "  Special Targets                                         "
	@	echo "    chk    [NUMB_CORE=<int>]    run check                 "
	@	echo "                                                          "
	@	echo "  General Targets                                         "
	@	echo "    cfg_view                    view configuration results"
	@	echo "    clean                       clean temperary files     "
	@	echo "    clean_all                   clean all generated files "
	@	echo "                                                          "
	@	echo "PARAMETERS                                                "
	@	echo "  NUMB_CORE    [1, 16]          CPU core occupied         "


#*** MAIN BODY *****************************************************************
#--- SPECIAL TASKS ---------------------
chk: create
	@	cd $(CSTR_DIR)            ;\
		    fm_shell -f top.tcl    \
		    | tee -i $(CSTR_LOG)


#--- GENERAL TASKS ---------------------
cfg_view:
	@	echo "GLOBAL PARAMETER"
	@	echo "  CSTR_TOP         :    $(CSTR_TOP)"
	@	echo "  CSTR_INC         :    $(CSTR_INC)"
	@	echo "  CSTR_RTL         :    $(CSTR_RTL)"
	@	echo "  NUMB_CORE        :    $(NUMB_CORE)"
	@	echo ""
	@	echo "LOCAL PARAMETER"
	@	echo "  ENV_CSTR_DIR_PRJ :    $(ENV_CSTR_DIR_PRJ)"
	@	echo "  CSTR_LOG         :    $(CSTR_LOG)"
	@	echo "  CSTR_LOG_SYN     :    $(CSTR_LOG_SYN)"

clean:
	@	rm -rf ./$(CSTR_DIR)/FM_WORK*
	@	rm -rf ./$(CSTR_DIR)/fm*
	@	rm -rf ./$(CSTR_DIR)/formality*

clean_all: clean
	@	rm -rf ./$(CSTR_DIR)


#--- TOOL TASKS ------------------------
create:
	@	# directory
	@	mkdir -p $(CSTR_DIR)
	@	mkdir -p $(CSTR_DIR)/log
	@	mkdir -p $(CSTR_DIR)/rpt
	@	# tcls
	@	cp ../script/top.tcl                                   $(CSTR_DIR)
	@	sed -i "s/\(\s*set CSTR_TOP\s\+\)\S*/\1$(CSTR_TOP)/"   $(CSTR_DIR)/top.tcl
	@	sed -i "s/\(\s*set NUMB_CORE\s\+\)\S*/\1$(NUMB_CORE)/" $(CSTR_DIR)/top.tcl
	@	chmod a+x ../script/lst2Tcl.pl
	@	../script/lst2Tcl.pl $(CSTR_INC)                       $(CSTR_DIR)/srcInc.tcl "INC"
	@	../script/lst2Tcl.pl $(CSTR_RTL)                       $(CSTR_DIR)/srcRtl.tcl "RTL"
	@	sed -i "s#\$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#"    $(CSTR_DIR)/srcInc.tcl
	@	sed -i "s#\$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#"    $(CSTR_DIR)/srcRtl.tcl
