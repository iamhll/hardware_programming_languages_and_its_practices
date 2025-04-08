.EXPORT_ALL_VARIABLES:
ENV_FLAG_SHOW_CFG          ?= 0
ENV_FLAG_BACKUP            ?= 0
ENV_NUMB_JOB               ?= 8

EDA_CSTR_TOOL              ?= ivs

T_V_CSTR_DIR               ?= check_data
T_V_CSTR_PATTERN           ?= "\*"

SIM_KNOB_DBG               ?= 0
SIM_CSTR_LEVEL_STOP        ?= current
SIM_DATA_SEED              ?= 0
SIM_KNOB_WAVEFORM          ?= 0
SIM_DATA_WAVEFORM_TIME     ?= 0
SIM_CSTR_WAVEFORM_LEVEL    ?= ASTF

COV_CSTR_TOP               ?= $(DUT_CSTR_TOP)

DUT_CSTR_TOP               ?= divide_pipeline
DUT_CSTR_INC               ?= none
DUT_CSTR_LIB               ?= none
DUT_CSTR_SRC               ?= none

include ../script/makefile.mk
