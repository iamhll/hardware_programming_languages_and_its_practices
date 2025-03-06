#-------------------------------------------------------------------------------
    #
    #  Filename       : makefile.mk
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run quartus
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
# ENV_CSTR_DIR_PRJ
	ENV_CSTR_DIR_PRJ = ../../..


#*** USAGE *********************************************************************
default:
	@	echo "MAKE TARGETS                                               "
	@	echo "  Special Targets                                          "
	@	echo "    create                   create quartus project files  "
	@	echo "    syn_view                 view synthesis results (brief)"
	@	echo "                                                           "
	@	echo "  General Targets                                          "
	@	echo "    cfg_view                 view configuration results    "
	@	echo "    clean                    clean temperary files         "
	@	echo "    clean_all                clean all generated files     "
	@	echo "                                                           "
	@	echo "PARAMETERS                                                 "
	@	echo "  DATA_PRD_CLK    %f         clock period                  "


#*** MAIN BODY *****************************************************************
#--- SPECIAL TASKS ---------------------
create:
	@	cat $(CSTR_INC) $(CSTR_LIB) $(CSTR_RTL) > tmp.f
	@	../script/lst2qxf.pl tmp.f $(CSTR_TOP)
	@	rm tmp.f
	@	sed -i "s#\$$ENV_CSTR_DIR_PRJ#$(ENV_CSTR_DIR_PRJ)#" $(CSTR_TOP).qsf
	@	sed -i "s/\(\s*set DATA_PRD_CLK\s\+\)\S*/\1$(DATA_PRD_CLK)/" setCst.tcl

syn_view:
	@	echo '-----------------------------------'
	@	echo '- WARNINGS                        -'
	@	echo '-----------------------------------'
	@-	cat output_files/*.rpt                   \
		    | egrep "^\s*(Critical )?Warning"    \
		    | grep -v  10036                     \
		    | grep -v  10037                     \
		    | grep -v  10230                     \
		    | grep -v  10270                     \
		    | grep -v  10335                     \
		    | grep -v  10762                     \
		    | grep -v  10764                     \
		    | grep -v  10905                     \
		    | grep -v  12677                     \
		    | grep -v  13024                     \
		    | grep -v  13410                     \
		    | grep -v  13469                     \
		    | grep -v  14284                     \
		    | grep -v  14285                     \
		    | grep -v  14320                     \
		    | grep -v  15610                     \
		    | grep -v  15714                     \
		    | grep -v  16067                     \
		    | grep -v  16068                     \
		    | grep -v  16069                     \
		    | grep -v  16227                     \
		    | grep -v  16228                     \
		    | grep -v  16235                     \
		    | grep -v  17951                     \
		    | grep -v  18655                     \
		    | grep -v  21074                     \
		    | grep -v 276020                     \
		    | grep -v 276027                     \
		| tee /dev/null
	@	echo '-----------------------------------'
	@	echo '- ERRORS                          -'
	@	echo '-----------------------------------'
	@-	cat output_files/*.rpt     \
		    | egrep "^\s*Error"    \
		| tee /dev/null

#  10036: Verilog HDL or VHDL warning at ???: object "???" assigned a value but never read
#  10037: Verilog HDL or VHDL warning at ???: conditional expression evaluates to a constant
#  10230: Verilog HDL assignment warning at ???: truncated value with size ??? to match size of target ???
#  10270: Verilog HDL Case Statement warning at ???: incomplete case statement has no default case item
#  10335: Unrecognized synthesis attribute "???" at ???
#  10762: Verilog HDL Case Statement warning at ???: can't check case statement for completeness because the case expression has too many possible states
#  10764: Verilog HDL warning at ???: converting signed shift amount to unsigned
#  10905: Generated the EDA functional simulation netlist because it is the only supported netlist type for this device
#  12677: No exact pin location assignment(s) for ??? pins of ??? total pins. For the list of pins please refer to the I/O Assignment Warnings table in the fitter report
#  13024: Output pins are stuck at VCC or GND
#  13410: Pin "???" is stuck at VCC
#  13469: Verilog HDL assignment warning at ???: truncated value with size ??? to match size of target ???
#  14284: Synthesized away the following node(s):
#  14285: Synthesized away the following RAM node(s):
#  14320: Synthesized away node "???"
#  15610: No output dependent on input pin "???"
#  15714: Some pins have incomplete I/O assignments. Refer to the I/O Assignment Warnings report for details
#  16067: ??? out of ??? DSP blocks in the design are not fully utilizing recommended internal DSP register banks. Design performance may be limited. To take full advantage of device resources, you should either enable the register banks directly (if using WYSIWYG entry) or provide additional registers in your design that the Quartus register packing optimization algorithm can convert to internal DSP register banks
#  16068: ??? DSP blocks are unregistered - they use none of the recommended internal DSP register banks. Intel advises using all the recommended internal DSP register banks for high performance designs
#  16069: ??? DSP blocks are partially registered - they use some, but not all of the recommended internal DSP register banks. Intel advises using all the recommended internal DSP register banks for high performance designs
#  16227: One or more registers failed to be packed into a DSP bank due to no programmable inverts in the DSP block
#  16228: One or more registers failed to be packed into a DSP bank due to VCC inputs
#  16235: One or more output registers failed to be packed into a DSP bank due to DSP block outputs fanning out to instances that are not registers
#  17951: There are ??? unused RX channels in the design. If you intend to use any of these channels in the future, you must add the assignment 'set_instance_assignment -name PRESERVE_UNUSED_XCVR_CHANNEL ON -to <pin_name>' in your QSF file. This assignment will preserve the performance of specified channels over time. Note that unused channel preservation only works if the design uses or instantiates atleast 1 transceiver channel
#  18655: There are ??? unused TX channels in the design. If you intend to use any of these channels in the future, you must add the assignment 'set_instance_assignment -name PRESERVE_UNUSED_XCVR_CHANNEL ON -to <pin_name>' in your QSF file. This assignment will preserve the performance of specified channels over time. Note that unused channel preservation only works if the design uses or instantiates atleast 1 transceiver channel
#  21074: Design contains ??? input pin(s) that do not drive logic
# 276020: Inferred RAM node "???"
# 276027: Inferred dual-clock RAM node "???"


#--- GENERAL TASKS ---------------------
cfg_view:
	@	echo "CSTR_TOP     :    $(CSTR_TOP)"
	@	echo "CSTR_INC     :    $(CSTR_INC)"
	@	echo "CSTR_LIB     :    $(CSTR_LIB)"
	@	echo "CSTR_RTL     :    $(CSTR_RTL)"
	@	echo "DATA_PRD_CLK :    $(DATA_PRD_CLK)"

clean:
	@	rm -rf ./db
	@	rm -rf ./incremental_db
	@	rm -rf ./simulation
	@	rm -rf ./$(CSTR_TOP).*

clean_all: clean
	@	rm -rf ./output_files
