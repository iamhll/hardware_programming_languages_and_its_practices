#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run compilation, check, simulation and coverage collection
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
# SHELL
	SHELL = /bin/bash

# ENV_CSTR_DIR_PRJ
	ENV_CSTR_DIR_PRJ = ../../..

# EDA_CSTR_CFG_SIM
	ifeq      ($(EDA_CSTR_TOOL), cds)
	EDA_CSTR_CFG_SIM = +access+r             \
	                   +nospecify            \
	                   +ncseq_udp_delay+1    \
	                   +nctop+$(SIM_CSTR_TOP)
	else ifeq ($(EDA_CSTR_TOOL), syn)
	EDA_CSTR_CFG_SIM = -full64              \
	                   -debug_access+all    \
	                   +nospecify           \
	                   $(SIM_CSTR_TOP)
	else
	EDA_CSTR_CFG_SIM = -s $(SIM_CSTR_TOP)
	endif

# EDA_CSTR_CFG_DEF
	EDA_CSTR_CFG_DEF  = +define+SIM_EVAL_TOP=$(SIM_CSTR_TOP)                      \
	                    +define+SIM_CSTR_TOP=\"$(SIM_CSTR_TOP)\"                  \
	                    +define+DUT_EVAL_TOP=$(DUT_CSTR_TOP)                      \
	                    +define+DUT_CSTR_TOP=\"$(DUT_CSTR_TOP)\"                  \
	                    +define+SIM_KNOB_DBG=$(SIM_KNOB_DBG)                      \
	                    +define+SIM_CSTR_LEVEL_STOP=\"$(SIM_CSTR_LEVEL_STOP)\"    \
	                    +define+SIM_DATA_SEED=$(SIM_DATA_SEED)
	ifeq      ($(EDA_CSTR_TOOL), cds)
	EDA_CSTR_CFG_DEF += +define+SIM_KNOB_WAVEFORM_SHM=$(SIM_KNOB_WAVEFORM)          \
	                    +define+SIM_DATA_WAVEFORM_TIME=$(SIM_DATA_WAVEFORM_TIME)    \
	                    +define+SIM_CSTR_WAVEFORM_LEVEL=\"$(SIM_CSTR_WAVEFORM_LEVEL)\"
	else ifeq ($(EDA_CSTR_TOOL), syn)
	EDA_CSTR_CFG_DEF += +define+SIM_KNOB_WAVEFORM_FSDB=$(SIM_KNOB_WAVEFORM)    \
	                    +define+SIM_DATA_WAVEFORM_TIME=$(SIM_DATA_WAVEFORM_TIME)
	else
	EDA_CSTR_CFG_DEF += +define+SIM_KNOB_WAVEFORM_VCD=$(SIM_KNOB_WAVEFORM)    \
	                    +define+SIM_DATA_WAVEFORM_TIME=$(SIM_DATA_WAVEFORM_TIME)
	endif

# EDA_CSTR_CFG_LST
	EDA_CSTR_CFG_LST = -f tmp_inc.f    \
	                   -f tmp_lft.f

# EDA_CSTR_CFG_LOG
	EDA_CSTR_CFG_LOG = $(EDA_CSTR_LOG)

# EDA_CSTR_LOG
	EDA_CSTR_LOG     = $(SIM_CSTR_DIR_SIMUL)/run.log
	ifeq ($(EDA_CSTR_TOOL), cds)
	EDA_CSTR_LOG_COM = $(SIM_CSTR_DIR_SIMUL)/com_ncverilog.log
	EDA_CSTR_LOG_CHK =
	EDA_CSTR_LOG_SIM = $(SIM_CSTR_DIR_SIMUL)/sim_ncverilog.log
	EDA_CSTR_LOG_COV = $(SIM_CSTR_DIR_SIMUL)/cov_ncverilog.log
	else ifeq ($(EDA_CSTR_TOOL), syn)
	EDA_CSTR_LOG_COM = $(SIM_CSTR_DIR_SIMUL)/com_vlogan.log
	EDA_CSTR_LOG_CHK = $(SIM_CSTR_DIR_SIMUL)/chk_verdi.log
	EDA_CSTR_LOG_SIM = $(SIM_CSTR_DIR_SIMUL)/sim_vcs.log
	EDA_CSTR_LOG_COV =
	else
	EDA_CSTR_LOG_COM = $(SIM_CSTR_DIR_SIMUL)/com_iverilog.log
	EDA_CSTR_LOG_CHK =
	EDA_CSTR_LOG_SIM = $(SIM_CSTR_DIR_SIMUL)/sim_iverilog.log
	EDA_CSTR_LOG_COV =
	endif

# SIM_CSTR_TOP, SIM_CSTR_LST
	SIM_CSTR_TOP = sim_$(DUT_CSTR_TOP)
	SIM_CSTR_LST = sim_$(DUT_CSTR_TOP).f

# SIM_CSTR_DIR_SIMUL
	SIM_CSTR_DIR_SIMUL = simul_data


#*** USAGE *********************************************************************
default:
	@	echo "TARGETS                                                                                                       "
	@	echo "  Single Targets                                                                                              "
	@	echo "    com_view         [EDA_CSTR_TOOL=<string>]              elaborate and view elaboration results             "
	@	echo "    chk_view         [EDA_CSTR_TOOL=<string>]              check and view check results                       "
	@	echo "    sim              [EDA_CSTR_TOOL=<string>]              simulate                                           "
	@	echo "                     [SIM_KNOB_DBG=<bool>]                                                                    "
	@	echo "                     [SIM_CSTR_LEVEL_STOP=<string>]                                                           "
	@	echo "                     [SIM_DATA_SEED=<int>]                                                                    "
	@	echo "                     [SIM_KNOB_WAVEFORM=<bool>]                                                               "
	@	echo "                     [SIM_DATA_WAVEFORM_TIME=<int>]                                                           "
	@	echo "                     [SIM_CSTR_WAVEFORM_LEVEL=<string>]                                                       "
	@	echo "    sim_view         [EDA_CSTR_TOOL=<string>]              view simulation results (waveform)                 "
	@	echo "    cov              [COV_CSTR_TOP=<string>]               collect coverage                                   "
	@	echo "    cov_view                                               view coverage results                              "
	@	echo "                                                                                                              "
	@	echo "  Regression Targets                                                                                          "
	@	echo "    sim_regr         [ENV_FLAG_SHOW_CFG=<bool>]            do simulation regression                           "
	@	echo "                     [ENV_FLAG_BACKUP=<bool>]                                                                 "
	@	echo "                     [ENV_NUMB_JOB=<int>]                                                                     "
	@	echo "                     [EDA_CSTR_TOOL=<string>]                                                                 "
	@	echo "                     [T_V_CSTR_DIR=<string>]                                                                  "
	@	echo "                     [T_V_CSTR_PATTERN=<string>]                                                              "
	@	echo "                     [SIM_KNOB_DBG=<bool>]                                                                    "
	@	echo "                     [SIM_CSTR_LEVEL_STOP=<string>]                                                           "
	@	echo "                     [SIM_DATA_SEED=<int>]                                                                    "
	@	echo "                     [SIM_KNOB_WAVEFORM=<bool>]                                                               "
	@	echo "                     [SIM_DATA_WAVEFORM_TIME=<int>]                                                           "
	@	echo "                     [SIM_CSTR_WAVEFORM_LEVEL=<string>]                                                       "
	@	echo "    sim_regr_view    [EDA_CSTR_TOOL=<string>]              view simulation regression results                 "
	@	echo "    cov_regr         [ENV_NUMB_JOB=<int>]                  do coverage regression                             "
	@	echo "                     [T_V_CSTR_DIR=<string>]                                                                  "
	@	echo "                     [T_V_CSTR_PATTERN=<string>]                                                              "
	@	echo "                     [SIM_KNOB_DBG=<bool>]                                                                    "
	@	echo "                     [SIM_DATA_SEED=<int>]                                                                    "
	@	echo "                     [COV_CSTR_TOP=<string>]                                                                  "
	@	echo "    cov_regr_view                                          view coverage regression results                   "
	@	echo "                                                                                                              "
	@	echo "  General Targets                                                                                             "
	@	echo "    cfg_view                                               view configuration results                         "
	@	echo "    clean                                                  clean temperary files                              "
	@	echo "    clean_all                                              clean all generated files                          "
	@	echo "                                                                                                              "
	@	echo "PARAMETERS                                                                                                    "
	@	echo "  ENV_FLAG_SHOW_CFG          (0|1)                         (disable|enable) configuration show                "
	@	echo "  ENV_FLAG_BACKUP            (0|1)                         (disable|enable) regression results  backup        "
	@	echo "  ENV_NUMB_JOB               %d                            number of jobs running parallelly                  "
	@	echo "  EDA_CSTR_TOOL              (syn|cds|ivr)                 (synopsys|cadence|Icarus) EDA tool                 "
	@	echo "  T_V_CSTR_DIR               %s                            directory of the interested test vectors           "
	@	echo "  T_V_CSTR_PATTERN           %s                            pattern of the interested test vectors             "
	@	echo "  COV_CSTR_TOP               %s                            module to do coverage collection                   "
	@	echo "  SIM_KNOB_DBG               (0|1)                         (disable|enable) debug codes                       "
	@	echo "  SIM_CSTR_LEVEL_STOP        (none|current|all)            stop (none|current|all) case(s) when error reported"
	@	echo "  SIM_DATA_SEED              %d                            random seed                                        "
	@	echo "  SIM_KNOB_WAVEFORM          (0|1)                         (disable|enable) waveform dump                     "
	@	echo "  SIM_DATA_WAVEFORM_TIME     %d                            time to dump shm                                   "
	@	echo "  SIM_CSTR_WAVEFORM_LEVEL    [ASTF]                        dump level of shm                                  "
	@	echo "                                                                                                              "
	@	echo "NOTES                                                                                                         "
	@	echo "  EDA_CSTR_TOOL=cds is not supported by chk_view                                                              "
	@	echo "  EDA_CSTR_TOOL=syn is not supported by cov, cov_view, cov_regr and cov_regr_view for now                     "
	@	echo "  EDA_CSTR_TOOL=ivs is not supported by chk_view, cov, cov_view, cov_regr and cov_regr_view for now           "


#*** MAIN BODY *****************************************************************
#--- SINGLE TASKS ----------------------
com_view: clean uniq_file_list create_simul_directory
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) com_view_cds           ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) com_view_syn           ;\
		else                                \
		    $(MAKE) com_view_ivs           ;\
		fi

chk_view: clean uniq_file_list create_simul_directory
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) chk_view_cds           ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) com_view_syn           ;\
		else                                \
		    $(MAKE) chk_view_ivs           ;\
		fi

sim: uniq_file_list create_simul_directory
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) sim_cds                ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) sim_syn                ;\
		else                                \
		    $(MAKE) sim_ivs                ;\
		fi

sim_view:
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) sim_view_cds           ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) sim_view_syn           ;\
		else                                \
		    $(MAKE) sim_view_ivs           ;\
		fi

cov: uniq_file_list create_simul_directory
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) cov_cds                ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) cov_syn                ;\
		else                                \
		    $(MAKE) cov_ivs                ;\
		fi

cov_view:
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) cov_view_cds           ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) cov_view_syn           ;\
		else                                \
		    $(MAKE) cov_view_ivs           ;\
		fi


#--- REGRESSION TASKS ------------------
sim_regr: clean_all
	@	chmod a+x ../script/regression.sh
	@	../script/regression.sh $(ENV_FLAG_SHOW_CFG)          \
		                        $(ENV_FLAG_BACKUP)            \
		                        $(ENV_NUMB_JOB)               \
		                        $(EDA_CSTR_TOOL)              \
		                        "$(T_V_CSTR_DIR)"             \
		                        "$(T_V_CSTR_PATTERN)"         \
		                        $(SIM_KNOB_DBG)               \
		                        $(SIM_CSTR_LEVEL_STOP)        \
		                        $(SIM_DATA_SEED)              \
		                        $(SIM_KNOB_WAVEFORM)          \
		                        $(SIM_DATA_WAVEFORM_TIME)     \
		                        $(SIM_CSTR_WAVEFORM_LEVEL)    \
		                        0                             \
		                        $(COV_CSTR_TOP)               \
		                        | tee sim_regr.log

sim_regr_view:
	@	cat error.log

cov_regr: clean_all
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) cov_regr_cds           ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) cov_regr_syn           ;\
		else                                \
		    $(MAKE) cov_regr_ivs           ;\
		fi

cov_regr_view:
	@	if   [ $(EDA_CSTR_TOOL) == cds ]   ;\
		then                                \
		    $(MAKE) cov_regr_view_cds      ;\
		elif [ $(EDA_CSTR_TOOL) == syn ]   ;\
		then                                \
		    $(MAKE) cov_regr_view_syn      ;\
		else                                \
		    $(MAKE) cov_regr_view_ivs      ;\
		fi


#--- GENERAL TASKS ---------------------
cfg_view:
	@	echo "GLOBAL PARAMETER"
	@	echo "   ENV_FLAG_SHOW_CFG       :    $(ENV_FLAG_SHOW_CFG)"
	@	echo "   ENV_FLAG_BACKUP         :    $(ENV_FLAG_BACKUP)"
	@	echo "   ENV_NUMB_JOB            :    $(ENV_NUMB_JOB)"
	@	echo "   EDA_CSTR_TOOL           :    $(EDA_CSTR_TOOL)"
	@	echo "   T_V_CSTR_DIR            :    $(T_V_CSTR_DIR)"
	@	echo "   T_V_CSTR_PATTERN        :    $(T_V_CSTR_PATTERN)"
	@	echo "   SIM_KNOB_DBG            :    $(SIM_KNOB_DBG)"
	@	echo "   SIM_CSTR_LEVEL_STOP     :    $(SIM_CSTR_LEVEL_STOP)"
	@	echo "   SIM_DATA_SEED           :    $(SIM_DATA_SEED)"
	@	echo "   SIM_KNOB_WAVEFORM       :    $(SIM_KNOB_WAVEFORM)"
	@	echo "   SIM_DATA_WAVEFORM_TIME  :    $(SIM_DATA_WAVEFORM_TIME)"
	@	echo "   SIM_CSTR_WAVEFORM_LEVEL :    $(SIM_CSTR_WAVEFORM_LEVEL)"
	@	echo "   COV_CSTR_TOP            :    $(COV_CSTR_TOP)"
	@	echo "   DUT_CSTR_TOP            :    $(DUT_CSTR_TOP)"
	@	echo "   DUT_CSTR_INC            :    $(DUT_CSTR_INC)"
	@	echo "   DUT_CSTR_LIB            :    $(DUT_CSTR_LIB)"
	@	echo "   DUT_CSTR_SRC            :    $(DUT_CSTR_SRC)"
	@	echo ""
	@	echo "LOCAL PARAMETER"
	@	echo "   ENV_CSTR_DIR_PRJ        :    $(ENV_CSTR_DIR_PRJ)"
	@	echo "   EDA_CSTR_CFG_LST        :    $(EDA_CSTR_CFG_LST)"
	@	echo "   SIM_CSTR_DIR_SIMUL      :    $(SIM_CSTR_DIR_SIMUL)"
	@	echo ""
	@	echo "DERIVED PARAMETER"
	@	echo "   EDA_CSTR_CFG_SIM        :    $(EDA_CSTR_CFG_SIM)"
	@	echo "   EDA_CSTR_CFG_DEF        :    $(EDA_CSTR_CFG_DEF)"
	@	echo "   EDA_CSTR_CFG_LOG        :    $(EDA_CSTR_CFG_LOG)"
	@	echo "   EDA_CSTR_LOG            :    $(EDA_CSTR_LOG)"
	@	echo "   EDA_CSTR_LOG_COM        :    $(EDA_CSTR_LOG_COM)"
	@	echo "   EDA_CSTR_LOG_CHK        :    $(EDA_CSTR_LOG_CHK)"
	@	echo "   EDA_CSTR_LOG_SIM        :    $(EDA_CSTR_LOG_SIM)"
	@	echo "   EDA_CSTR_LOG_COV        :    $(EDA_CSTR_LOG_COV)"
	@	echo "   SIM_CSTR_TOP            :    $(SIM_CSTR_TOP)"
	@	echo "   SIM_CSTR_LST            :    $(SIM_CSTR_LST)"

clean:
	@	rm -rf ./64/
	@	rm -rf ./a.out
	@	rm -rf ./AN.DB
	@	rm -rf ./cov_work
	@	rm -rf ./csrc
	@	rm -rf ./imc.key
	@	rm -rf ./imc.log
	@	rm -rf ./INCA_libs
	@	rm -rf ./mdv.log
	@	rm -rf ./novas.conf
	@	rm -rf ./novas_dump.log
	@	rm -rf ./novas.rc
	@	rm -rf ./simv
	@	rm -rf ./simv.daidir
	@	rm -rf ./.simvision
	@	rm -rf ./tmp.f
	@	rm -rf ./tmp_inc.f
	@	rm -rf ./tmp_lft.f
	@	rm -rf ./tmp_cmd.f
	@	rm -rf ./ucli.key
	@	rm -rf ./verdiLog

clean_all: clean
	@	rm -rf ./cov_regr.log
	@	rm -rf ./sim_regr.log
	@	rm -rf ./error.log
	@	rm -rf ./$(SIM_CSTR_DIR_SIMUL)
	@	rm -rf ./$(SIM_CSTR_DIR_SIMUL)_regr


#--- TOOL TASKS ------------------------
create_simul_directory:
	@	mkdir -p $(SIM_CSTR_DIR_SIMUL)

uniq_file_list:
	@	echo "-f $(SIM_CSTR_LST)" >  tmp.f
	@	echo "-f $(DUT_CSTR_INC)" >> tmp.f
	@	echo "-f $(DUT_CSTR_LIB)" >> tmp.f
	@	echo "-f $(DUT_CSTR_SRC)" >> tmp.f
	@	chmod a+x ../script/uniqFileList.pl
	@	../script/uniqFileList.pl tmp.f tmp_inc.f "INC"
	@	../script/uniqFileList.pl tmp.f tmp_lft.f "LFT"

com_view_cds:
	@	echo '----------------------------------------'
	@	echo '- RUNNING                              -'
	@	echo '----------------------------------------'
	@-	ncverilog                                     \
		+elaborate                                    \
		$(EDA_CSTR_CFG_SIM)                           \
		$(EDA_CSTR_CFG_DEF)                           \
		$(EDA_CSTR_CFG_LST)                           \
		$(EDA_CSTR_CFG_LOG)

com_view_syn:
	@	echo '----------------------------------------'
	@	echo '- RUNNING                              -'
	@	echo '----------------------------------------'
	@-	vlogan                                        \
		$(EDA_CSTR_CFG_SIM)                           \
		$(EDA_CSTR_CFG_DEF)                           \
		$(EDA_CSTR_CFG_LST)                           \
		$(EDA_CSTR_CFG_LOG)
	@	echo '----------------------------------------' | tee    $(EDA_CSTR_LOG_COM)
	@	echo '- WARNINGS                             -' | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_COM)
	@	# TODO: update according to vlogan's annotation.
	@	cat $(EDA_CSTR_LOG)                           \
		    | grep    '*W'                            \
		    | grep -v 'MRSTAR'                        \
		    | grep -v 'RECOME'                          | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '- ERRORS                               -' | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_COM)
	@	# TODO: update according to vlogan's annotation.
	@	cat $(EDA_CSTR_LOG)                           \
		    | grep    '*E'                              | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------'       >> $(EDA_CSTR_LOG_COM)
	@	echo '- FULL LOGS                            -'       >> $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------'       >> $(EDA_CSTR_LOG_COM)
	@	cat $(EDA_CSTR_LOG)                                   >> $(EDA_CSTR_LOG_COM)

com_view_ivs:
	@	echo '----------------------------------------'
	@	echo '- RUNNING                              -'
	@	echo '----------------------------------------'
	@	echo $(EDA_CSTR_CFG_DEF) > tmp_cmd.f
	@-	iverilog -v                                   \
		$(EDA_CSTR_CFG_SIM)                           \
		-c tmp_cmd.f                                  \
		$(EDA_CSTR_CFG_LST)                           \
		2>&1 | tee $(EDA_CSTR_CFG_LOG)
	@	echo '----------------------------------------' | tee    $(EDA_CSTR_LOG_COM)
	@	echo '- WARNINGS                             -' | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_COM)
	@	cat $(EDA_CSTR_LOG)                           \
		    | grep    'warning'                         | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '- ERRORS                               -' | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_COM)
	@	cat $(EDA_CSTR_LOG)                           \
		    | grep    'error'                           | tee -a $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------'       >> $(EDA_CSTR_LOG_COM)
	@	echo '- FULL LOGS                            -'       >> $(EDA_CSTR_LOG_COM)
	@	echo '----------------------------------------'       >> $(EDA_CSTR_LOG_COM)
	@	cat $(EDA_CSTR_LOG)                                   >> $(EDA_CSTR_LOG_COM)

chk_view_cds:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=cds is not supported by make chk_view"
	@	exit 1

chk_view_syn:
	@	echo '----------------------------------------'
	@	echo '- RUNNING                              -'
	@	echo '----------------------------------------'
	@	echo "please wait..."
	@	verdi -sx                                     \
		      -nogui                                  \
		      $(EDA_CSTR_CFG_DEF)                     \
		      $(EDA_CSTR_CFG_LST)                     \
		> /dev/null
	@	cp verdiLog/compiler.log $(EDA_CSTR_LOG)
	@	cat $(EDA_CSTR_LOG)
	@	echo '----------------------------------------' | tee    $(EDA_CSTR_LOG_CHK)
	@	echo '- WARNINGS                             -' | tee -a $(EDA_CSTR_LOG_CHK)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_CHK)
	@-	cat $(EDA_CSTR_LOG)                           \
		    | grep    '*Warning*' -A 1                \
		    | grep -v 'Unknown argument -sx'            | tee -a $(EDA_CSTR_LOG_CHK)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_CHK)
	@	echo '- ERRORS                               -' | tee -a $(EDA_CSTR_LOG_CHK)
	@	echo '----------------------------------------' | tee -a $(EDA_CSTR_LOG_CHK)
	@-	cat $(EDA_CSTR_LOG)                           \
		    | grep    '*Error*'   -A 1                \
		    | grep -v 'redefined'                       | tee -a $(EDA_CSTR_LOG_CHK)
	@	echo '----------------------------------------'       >> $(EDA_CSTR_LOG_CHK)
	@	echo '- FULL LOGS                            -'       >> $(EDA_CSTR_LOG_CHK)
	@	echo '----------------------------------------'       >> $(EDA_CSTR_LOG_CHK)
	@	cat $(EDA_CSTR_LOG)                                   >> $(EDA_CSTR_LOG_CHK)

chk_view_ivs:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=ivs is not supported by make chk_view"
	@	exit 1

sim_cds:
	@-	ncverilog              \
		+elaborate             \
		$(EDA_CSTR_CFG_SIM)    \
		$(EDA_CSTR_CFG_DEF)    \
		$(EDA_CSTR_CFG_LST)    \
		$(EDA_CSTR_CFG_LOG)    \
	> /dev/null
	@-	ncverilog              \
		$(EDA_CSTR_CFG_SIM)    \
		$(EDA_CSTR_CFG_DEF)    \
		$(EDA_CSTR_CFG_LST)    \
		$(EDA_CSTR_CFG_LOG)
	@	cat $(EDA_CSTR_LOG)    > $(EDA_CSTR_LOG_SIM)

sim_syn:
	@	vlogan                 \
		$(EDA_CSTR_CFG_DEF)    \
		$(EDA_CSTR_CFG_LST)    \
		$(EDA_CSTR_CFG_LOG)
	@	vcs                    \
		-R                     \
		$(EDA_CSTR_CFG_SIM)    \
		$(EDA_CSTR_CFG_LOG)
	@	cat $(EDA_CSTR_LOG)    > $(EDA_CSTR_LOG_SIM)

sim_ivs:
	@-	echo $(EDA_CSTR_CFG_DEF) > tmp_cmd.f
	@-	iverilog               \
		$(EDA_CSTR_CFG_SIM)    \
		-c tmp_cmd.f           \
		$(EDA_CSTR_CFG_LST)    \
	> /dev/null
	@-	./a.out | tee $(EDA_CSTR_LOG)
	@	cat $(EDA_CSTR_LOG)    > $(EDA_CSTR_LOG_SIM)

sim_view_cds:
	@	simvision -64bit    \
		          -waves    \
		          $(SIM_CSTR_DIR_SIMUL)/waveform.shm/waveform.trn &
	@	echo "please wait..."
	@	sleep 10

sim_view_syn:
	@	verdi -sx     \
		      -ssf    \
		      $(SIM_CSTR_DIR_SIMUL)/waveform.fsdb &
	@	echo "please wait..."
	@	sleep 10

sim_view_ivs:
	@	gtkwave $(SIM_CSTR_DIR_SIMUL)/waveform.vcd &
	@	echo "please wait..."
	@	sleep 10

cov_cds:
	@	ncverilog                              \
		$(EDA_CSTR_CFG_SIM)                    \
		$(EDA_CSTR_CFG_DEF)                    \
		$(EDA_CSTR_CFG_LST)                    \
		$(EDA_CSTR_CFG_LOG)                    \
		+nccovdut+$(COV_CSTR_TOP)              \
		+nccoverage+all                        \
		+nccovworkdir+$(SIM_CSTR_DIR_SIMUL)    \
		-covoverwrite

cov_syn:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=syn is not supported by make cov"
	@	exit 1

cov_ivs:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=ivs is not supported by make cov"
	@	exit 1

cov_view_cds:
	@	imc -gui -load $(SIM_CSTR_DIR_SIMUL)/scope/test &
	@	echo "please wait..."
	@	sleep 10

cov_view_syn:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=syn is not supported by make cov_view"
	@	exit 1

cov_view_ivs:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=ivs is not supported by make cov_view"
	@	exit 1

cov_regr_cds:
	@	chmod a+x ../script/regression.sh
	@	../script/regression.sh $(ENV_FLAG_SHOW_CFG)          \
		                        1                             \
		                        $(ENV_NUMB_JOB)               \
		                        $(EDA_CSTR_TOOL)              \
		                        "$(T_V_CSTR_DIR)"             \
		                        "$(T_V_CSTR_PATTERN)"         \
		                        $(SIM_KNOB_DBG)               \
		                        global                        \
		                        $(SIM_DATA_SEED)              \
		                        0                             \
		                        $(SIM_DATA_WAVEFORM_TIME)     \
		                        $(SIM_CSTR_WAVEFORM_LEVEL)    \
		                        1                             \
		                        $(COV_CSTR_TOP)               \
		                        | tee cov_regr.log

cov_regr_syn:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=syn is not supported by make cov_regr"
	@	exit 1

cov_regr_ivs:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=ivs is not supported by make cov_regr"
	@	exit 1

cov_regr_view_cds:
	@	rm -rf cov_work
	@	imc -execcmd "merge simul_data_regr*/*/*/* -out merge"
	@	imc -gui -load cov_work/scope/merge &
	@	echo "please wait..."
	@	sleep 10

cov_regr_view_syn:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=syn is not supported by make cov_regr_view"
	@	exit 1

cov_regr_view_ivs:
	@	echo "[error from makefile.mk] EDA_CSTR_TOOL=ivs is not supported by make cov_regr_view"
	@	exit 1


#--- TEST TARGETs ----------------------
tst_all:
	@	make cfg_view
	@	make com_view      EDA_CSTR_TOOL=cds
	@	make sim           EDA_CSTR_TOOL=cds SIM_KNOB_WAVEFORM=1
	@	make sim_view      EDA_CSTR_TOOL=cds
	@	make cov           EDA_CSTR_TOOL=cds
	@	make cov_view      EDA_CSTR_TOOL=cds
	@	make sim_regr      EDA_CSTR_TOOL=cds T_V_CSTR_DIR="../../../reference_model/xkcalc/dump_calc_add_knl"
	@	make sim_regr_view EDA_CSTR_TOOL=cds
	@	make cov_regr      EDA_CSTR_TOOL=cds T_V_CSTR_DIR="../../../reference_model/xkcalc/dump_calc_add_knl" T_V_CSTR_PATTERN="*Correct"
	@	make cov_regr_view EDA_CSTR_TOOL=cds
	@	make com_view      EDA_CSTR_TOOL=syn
	@	make chk_view      EDA_CSTR_TOOL=syn
	@	make sim           EDA_CSTR_TOOL=syn SIM_KNOB_WAVEFORM=1
	@	make sim_view      EDA_CSTR_TOOL=syn
	@	make sim_regr      EDA_CSTR_TOOL=syn T_V_CSTR_DIR="../../../reference_model/xkcalc/dump_calc_add_knl"
	@	make sim_regr_view EDA_CSTR_TOOL=syn
	@	make com_view      EDA_CSTR_TOOL=ivs
	@	make sim           EDA_CSTR_TOOL=ivs SIM_KNOB_WAVEFORM=1
	@	make sim_view      EDA_CSTR_TOOL=ivs
	@	make sim_regr      EDA_CSTR_TOOL=ivs T_V_CSTR_DIR="../../../reference_model/xkcalc/dump_calc_add_knl"
	@	make sim_regr_view EDA_CSTR_TOOL=ivs
