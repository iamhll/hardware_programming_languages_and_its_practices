#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run spyglass
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


#*** USAGE *********************************************************************
default:
	@	echo "TARGETS                                                                                 "
	@	echo "  Special Targets                                                                       "
	@	echo "    com                                      run compilation                            "
	@	echo "    chk                                      run check                                  "
	@	echo "    chk_view    [CSTR_LEVEL_WAIVE=<type>]    view warning and error information         "
	@	echo "                                                                                        "
	@	echo "  General Targets                                                                       "
	@	echo "    cfg_view                                 view configuration results                 "
	@	echo "    clean                                    remove project files                       "
	@	echo "    clean_all                                remove all files                           "
	@	echo "                                                                                        "
	@	echo "PARAMETER                                                                               "
	@	echo "  CSTR_LEVEL_WAIVE    none                   waive none              warnings and errors"
	@	echo "                      rule                   waive rule specified    warnings and errors"
	@	echo "                      comments               waive comment specified warnings and errors"
	@	echo "                      both                   waive both              warnings and errors"


#*** MAIN BODY *****************************************************************
#--- SPECIAL TASKS ---------------------
com: clean_all create
	@	sed -i "s/if {1}/if {0}/" $(CSTR_DIR)/top.tcl
	@	cd $(CSTR_DIR)    ;\
		    spyglass -tcl top.tcl &
	@	sleep 10

chk: clean_all create
	@	sed -i "s/if {0}/if {1}/" $(CSTR_DIR)/top.tcl
	@	cd $(CSTR_DIR)    ;\
		    spyglass -tcl top.tcl &
	@	sleep 10

chk_view:
	@	chmod a+x ../script/analyzeReport.pl
	@	../script/analyzeReport.pl rule.lst $(CSTR_DIR)/rpt/analyze.log $(CSTR_LEVEL_WAIVE)
	@	cat $(CSTR_DIR)/rpt/analyze.log


#--- GENERAL TASKS ---------------------
clean:
	@	rm -rf ./$(CSTR_DIR)/spyglass*

clean_all: clean
	@	rm -rf ./$(CSTR_DIR)


#--- TOOL TASKS ------------------------
cfg_view:
	@	echo "GLOBAL PARAMETER"
	@	echo "  CSTR_TOP         :    $(CSTR_TOP)"
	@	echo "  CSTR_INC         :    $(CSTR_INC)"
	@	echo "  CSTR_LIB         :    $(CSTR_LIB)"
	@	echo "  CSTR_RTL         :    $(CSTR_RTL)"
	@	echo "  CSTR_LEVEL_WAIVE :    $(CSTR_LEVEL_WAIVE)"
	@	echo ""
	@	echo "LOCAL PARAMETER"
	@	echo "  ENV_CSTR_DIR_PRJ :    $(ENV_CSTR_DIR_PRJ)"
	@	echo "  CSTR_DIR         :    $(CSTR_DIR)"

create:
	@	# directory
	@	mkdir -p $(CSTR_DIR)
	@	mkdir -p $(CSTR_DIR)/rpt
	@	# tcls
	@	chmod a+x ../script/lst2Tcl.pl
	@	cat $(CSTR_RTL) $(CSTR_LIB) $(CSTR_INC) > tmp.f
	@	../script/lst2Tcl.pl tmp.f rule.lst                 $(CSTR_DIR)/top.tcl $(CSTR_TOP)
	@	rm tmp.f
	@	sed -i "s#\$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#" $(CSTR_DIR)/top.tcl
	@	cp setCst.sgdc                                      $(CSTR_DIR)
