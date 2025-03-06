#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : perform regression run on xkcalc
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
#--- GLOBAL ----------------------------
CSTR_TAG     ?= Test
CSTR_FLG_BLD ?=
CSTR_FLG_RUN ?=


#--- LOCAL -----------------------------
CSTR_DIR_PRJ = ../../..
CSTR_DUT     = xkcalc
CSTR_DUT_MOD = $(shell echo $(CSTR_DUT) | sed -e "s/\b\(.\)/\u\1/g")


#--- DERIVED ---------------------------
CSTR_SESSION = session$(CSTR_TAG)


#*** USAGE *********************************************************************
default:
	@	echo "TARGETS                                                                        "
	@	echo "  Special Targets                                                              "
	@	echo "    run    [CSTR_TAG=<string>]        create a session and run regression in it"
	@	echo "           [CSTR_FLG_BLD=<string>]                                             "
	@	echo "           [CSTR_FLG_RUN=<string>]                                             "
	@	echo "                                                                               "
	@	echo "  General Targets                                                              "
	@	echo "    clean                             clean temperary files                    "
	@	echo "    clean_all                         clean all generated files                "
	@	echo "                                                                               "
	@	echo "PARAMETERS                                                                     "
	@	echo "  CSTR_TAG        %s                  the session tag                          "
	@	echo "  CSTR_FLG_BLD    %s                  building parameters                      "
	@	echo "  CSTR_FLG_RUN    %s                  running parameters                       "


#*** MAIN BODY *****************************************************************
#--- NORMAL TARGETS --------------------
run: create
	@	cd $(CSTR_SESSION)    ;\
		    ./run$(CSTR_DUT_MOD).sh "$(CSTR_FLG_RUN)"


#--- TOOL TARGETS ----------------------
clean:
	@	cd $(CSTR_DIR_PRJ)/build/linux/$(CSTR_DUT)    ;\
		rm -rf CMake*                                 ;\
		rm -rf cmake*                                 ;\
		rm -rf Makefile                               ;\
		rm -rf $(CSTR_DUT)

clean_all: clean
	@	rm -rf session*

update:
	@	cd $(CSTR_DIR_PRJ)/build/linux/$(CSTR_DUT)    ;\
		./build.sh $(CSTR_FLG_BLD)
	@	cd $(CSTR_DIR_PRJ)/build/linux/$(CSTR_DUT)    ;\
		make

create: update
	@	mkdir -p  $(CSTR_SESSION)
	@	rm    -rf $(CSTR_SESSION)/*
	@	cp run$(CSTR_DUT_MOD).sh                                  $(CSTR_SESSION)
	@	cp $(CSTR_DIR_PRJ)/build/linux/$(CSTR_DUT)/$(CSTR_DUT)    $(CSTR_SESSION)/$(CSTR_DUT)
	@	cp $(CSTR_DUT).cfg                                        $(CSTR_SESSION)

stop:
	@-	killall -9 $(CSTR_DUT)
