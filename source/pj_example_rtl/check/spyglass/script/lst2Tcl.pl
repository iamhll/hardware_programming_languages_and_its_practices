#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : lst2Tcl.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : convert file lists to spyglass tcls
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use strict;
    use POSIX;


#*** VARIABLES *****************************************************************
    my $CSTR_SRC_DESIGN = $ARGV[0];
    my $CSTR_SRC_RULE   = $ARGV[1];
    my $CSTR_DST        = $ARGV[2];
    my $CSTR_TOP        = $ARGV[3];
    my %strInc;
    my %strRtl;


#*** SUB FUNCTION **************************************************************
#--- GET INCLUDE -----------------------
    sub getStrInc {
        # log
        my $fptOut = $_[0];
        my $strInp = $_[1];
        #print "processing $strInp\n";

        # main loop
        open my $fptInp, "< $strInp";
        while (<$fptInp>) {
            chomp;
            s#\$ENV_CSTR_DIR_PRJ#$ENV{ENV_CSTR_DIR_PRJ}#;
            # memory model
            if (/gf_22/) {
            }
            if (/gf_28/) {
            }
            if (/hl_40/) {
            }
            # include
            elsif (/\+incdir\+\s*(.*)/) {
                if (!exists($strInc{$1})) {
                    print $fptOut "$1 ";
                    $strInc{$1} = 1;
                }
            }
            # -f
            elsif (/^\s*-f\s*(.*)$/) {
                getStrInc($fptOut, $1);
            }
        }
        close $fptInp;
    }


#--- GET RTL ---------------------------
    sub getStrRtl {
        # log
        my $fptOut = $_[0];
        my $strInp = $_[1];
        #print "processing $strInp\n";

        # main loop
        open my $fptInp, "< $strInp";
        while (<$fptInp>) {
            chomp;
            s#\$ENV_CSTR_DIR_PRJ#$ENV{ENV_CSTR_DIR_PRJ}#;
            # comments
            if (/^\s*\/\//) {
            }
            # -f
            elsif (/^\s*-f\s*(.*)$/) {
                getStrRtl($fptOut, $1);
            }
            # include
            elsif (/incdir/) {
            }
            # blank line
            elsif (/^\s*$/) {
            }
            # memory model
            elsif (/gf_22/) {
            }
            elsif (/gf_28/) {
            }
            elsif (/hl_40/) {
            }
            # design file
            else {
                if (!exists($strRtl{$_})) {
                    print $fptOut "    read_file -type verilog $_\n";
                    $strRtl{$_} = 1;
                }
            }
        }
        close $fptInp;
    }


#*** MAIN BODY *****************************************************************
#--- OPEN FILE -------------------------
    open my $fptOut, ">$CSTR_DST";
    print $fptOut "\n";


#--- RTL -------------------------------
    print $fptOut "#*** RTL & SDC *****************************************************************\n";
    print $fptOut "    # RTL\n";
    getStrRtl($fptOut, $CSTR_SRC_DESIGN);
    print $fptOut "\n";
    print $fptOut "    # SDC\n";
    print $fptOut "    read_file -type sgdc setCst.sgdc\n";


#-- INCLUDE ----------------------------
    open F_I, "<$CSTR_SRC_DESIGN";
    print $fptOut "\n";
    print $fptOut "\n";
    print $fptOut "#*** COMMON OPTION *************************************************************\n";
    print $fptOut "    set_option language_mode mixed\n";
    print $fptOut "    set_option designread_disable_flatten no\n";
    print $fptOut "    set_option incdir {";
    getStrInc($fptOut, $CSTR_SRC_DESIGN);
    print $fptOut "}\n";


#--- TARGET ----------------------------
    open F_I, "<$CSTR_SRC_RULE";
    print $fptOut "    set_option stop *behave*\n";
    print $fptOut "    set_option top $CSTR_TOP\n";
    #print $fptOut "    set_option mthresh 8192\n";
    #print $fptOut "    set_option enableV05 yes\n";
    #print $fptOut "    set_option define_cell_sim_depth 12\n";
    print $fptOut "    current_methodology \$SPYGLASS_HOME/GuideWare/latest/block/rtl_handoff\n";
    print $fptOut "    define_view   -name my_view\n";
    print $fptOut "    define_report -name my_report -view my_view\n";
    print $fptOut "\n";
    print $fptOut "\n";
    print $fptOut "#*** TARGET ********************************************************************\n";
    print $fptOut "    # read\n";
    print $fptOut "    current_goal Design_Read -top $CSTR_TOP\n";
    print $fptOut "    link_design -force\n";
    print $fptOut "\n";
    print $fptOut "    # check\n";
    print $fptOut "    if {1} {\n";
    while (<F_I>) {
        chomp;
        if (/\s*#\s*(\S*)/) {
            print $fptOut "        # bypass [$_]\n";
            next;
        }
        if (/^\s*$/) {
            next;
        }
        if (/(\S*)/) {
            my $cur_goal = $1;
            print $fptOut "        # $cur_goal\n";
            print $fptOut "        current_goal $cur_goal -top $CSTR_TOP\n";
            print $fptOut "        run_goal\n";
            my $cur_name = $cur_goal;
            $cur_name =~ s/\//_/;
            print $fptOut "        write_report my_report > rpt/$cur_name.rpt\n";
            print $fptOut "\n";
        }
    }
    print $fptOut "    }\n";
    close F_I;


#--- CLOSE FILE ------------------------
    close $fptOut;
