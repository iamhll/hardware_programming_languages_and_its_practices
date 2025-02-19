#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run design compiler
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
# SHELL
	SHELL = /bin/bash

# ENV_CSTR_DIR_PRJ
# !!! "../../.." does not work.
	ENV_CSTR_DIR_PRJ = $(shell cd ../../..; pwd)

# CSTR_DIR
	CSTR_DIR     = $(CSTR_TAG)_$(DATA_PRD_CLK)
	CSTR_LOG     = log/run.log
	CSTR_LOG_SYN = log/syn.log


#*** USAGE *********************************************************************
default:
	@	echo "TARGETS                                                                 "
	@	echo "  Special Targets                                                       "
	@	echo "    syn         [CSTR_TAG=<string>]       run synthesis                 "
	@	echo "                [NUMB_CORE=<int>]                                       "
	@	echo "                [DATA_PRD_CLK=<float>]                                  "
	@	echo "    syn_view    [CSTR_TAG=<string>]       view synthesis results (brief)"
	@	echo "                [DATA_PRD_CLK=<float>]                                  "
	@	echo "                                                                        "
	@	echo "  General Targets                                                       "
	@	echo "    cfg_view                              view configuration results    "
	@	echo "    clean                                 clean temperary files         "
	@	echo "    clean_all                             clean all generated files     "
	@	echo "                                                                        "
	@	echo "PARAMETERS                                                              "
	@	echo "  CSTR_TAG        %s                      session tag                   "
	@	echo "  NUMB_CORE       [1, 16]                 CPU core occupied             "
	@	echo "  DATA_PRD_CLK    %f                      clock period                  "


#*** MAIN BODY *****************************************************************
#--- NORMAL TASKS ----------------------
syn: create
	@	cd $(CSTR_DIR)                 ;\
		    dc_shell-xg-t -f top.tcl    \
		    | tee -i $(CSTR_LOG)

syn_view:
	@	echo '----------------------------------------'
	@	echo '- STATUS                               -'
	@	echo '----------------------------------------'
	@-	cat $(CSTR_DIR)/$(CSTR_LOG)                     \
		    | grep 'Beginning'
	@	echo '----------------------------------------' | tee    $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '- WARNINGS                             -' | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '----------------------------------------' | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@-	cat $(CSTR_DIR)/$(CSTR_LOG)                     \
		    | grep 'Warning'                            \
		    | grep -v 'LBR-1'                           \
		    | grep -v 'LINK-5'                          \
		    | grep -v 'PWR-428'                         \
		    | grep -v 'OPT-133'                         \
		    | grep -v 'OPT-301'                         \
		    | grep -v 'TIM-134'                         \
		    | grep -v 'TIM-179'                         \
		    | grep -v 'UID-341'                         \
		    | grep -v 'UID-348'                         \
		    | grep -v 'VER-314'                         \
		    | grep -v 'VER-318'                         | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	chmod a+x ../script/check_VER-318.pl
	@	../script/check_VER-318.pl                      \
		$(CSTR_DIR)/$(CSTR_LOG)                         | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '----------------------------------------' | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '- ERRORS                               -' | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '----------------------------------------' | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@-	cat $(CSTR_DIR)/$(CSTR_LOG)                     \
		    | grep    'Error'                           \
		    | grep -v '$$display'                       | tee -a $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '----------------------------------------'       >> $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '- FULL LOGS                            -'       >> $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	echo '----------------------------------------'       >> $(CSTR_DIR)/$(CSTR_LOG_SYN)
	@	cat $(CSTR_DIR)/$(CSTR_LOG)                           >> $(CSTR_DIR)/$(CSTR_LOG_SYN)

# LBR  - 1  : Cannot find the design '???' in the library '???'.
# LINK - 5  : Unable to resolve reference '???' in '???'.
# PWR  - 428: Design has unannotated black box outputs.
# OPT  - 133: The value of variable 'compile_preserve_subdesign_interfaces' has been changed to true because '-no_boundary_optimization' is used.
# OPT  - 301: The design named ??? has ??? out of ??? cells marked size-only, which may limit optimization.
# TIM  - 134: Design '???' contains ??? high-fanout nets. A fanout number of 1000 will be used for delay calculations involving these nets.
# TIM  - 719: 'group_path' constraint made a reference 'to ???' which no longer exists.
# UID  - 341: Design '???' has '???' unresolved references. For more detailed information, use the "link" command.
# UID  - 348: Creating virtual clock named '???' with no sources.
# VER  - 314: Starting with the 2000.11-1 release, the Presto Verilog reader treats Verilog 'integer' types as signed; synthesized result may not match earlier versions of HDL Compiler.
# VER  - 318: ???:???: (un)signed to (un)signed part selection/assignment occurs.


#--- GENERAL TASKS ---------------------
cfg_view:
	@	echo "GLOBAL PARAMETER"
	@	echo "CSTR_TAG         :    $(CSTR_TAG)"
	@	echo "CSTR_TOP         :    $(CSTR_TOP)"
	@	echo "CSTR_INC         :    $(CSTR_INC)"
	@	echo "CSTR_RTL         :    $(CSTR_RTL)"
	@	echo "NUMB_CORE        :    $(NUMB_CORE)"
	@	echo "DATA_PRD_CLK     :    $(DATA_PRD_CLK)"
	@	echo ""
	@	echo "LOCAL PARAMETER"
	@	echo "ENV_CSTR_DIR_PRJ :    $(ENV_CSTR_DIR_PRJ)"
	@	echo "CSTR_LOG         :    $(CSTR_LOG)"
	@	echo "CSTR_LOG_SYN     :    $(CSTR_LOG_SYN)"
	@	echo ""
	@	echo "DERIVED PARAMETER"
	@	echo "CSTR_DIR         :    $(CSTR_DIR)"

clean:
	@	rm -rf ./$(CSTR_DIR)/work
	@	rm -rf ./$(CSTR_DIR)/alib-52

clean_all: clean
	@	rm -rf ./$(CSTR_DIR)


#--- TOOL TASKS ------------------------
create:
	@	# directory
	@	mkdir -p $(CSTR_DIR)
	@	mkdir -p $(CSTR_DIR)/log
	@	mkdir -p $(CSTR_DIR)/rlt
	@	mkdir -p $(CSTR_DIR)/rpt
	@	mkdir -p $(CSTR_DIR)/work
	@	# tcls
	@	cp ../script/top.tcl                                          $(CSTR_DIR)
	@	sed -i "s/\(\s*set CSTR_TOP\s\+\)\S*/\1$(CSTR_TOP)/"          $(CSTR_DIR)/top.tcl
	@	sed -i "s/\(\s*set NUMB_CORE\s\+\)\S*/\1$(NUMB_CORE)/"        $(CSTR_DIR)/top.tcl
	@	cp setCst.tcl                                                 $(CSTR_DIR)
	@	cp setPth.tcl                                                 $(CSTR_DIR)
	@	sed -i "s/\(\s*set DATA_PRD_CLK \s\+\)\S*/\1$(DATA_PRD_CLK)/" $(CSTR_DIR)/setCst.tcl
	@	chmod a+x ../script/lst2Tcl.pl
	@	../script/lst2Tcl.pl $(CSTR_INC)                              $(CSTR_DIR)/setInc.tcl "INC"
	@	../script/lst2Tcl.pl $(CSTR_RTL)                              $(CSTR_DIR)/setRtl.tcl "RTL"
	@	sed -i "s#\$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#"           $(CSTR_DIR)/setInc.tcl
	@	sed -i "s#\$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#"           $(CSTR_DIR)/setRtl.tcl
