#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : lst2Tcl.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : convert file lists to formality tcls
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use strict;
    use POSIX;


#*** VARIABLES *****************************************************************
    my $CSTR_SRC = $ARGV[0];
    my $CSTR_DST = $ARGV[1];
    my $CSTR_TYP = $ARGV[2];
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
            # include
            if (/\+incdir\+\s*(.*)/) {
                if (!exists($strInc{$1})) {
                    print $fptOut "             $1    \\\n";
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
            # design file
            else {
                if (!exists($strRtl{$_})) {
                    print $fptOut "             $_\n";
                    $strRtl{$_} = 1;
                }
            }
        }
        close $fptInp;
    }


#*** MAIN BODY *****************************************************************
#--- INCLUDE ---------------------------
    if ($CSTR_TYP eq "INC") {
        # log begin
        open my $fptOut, "> $CSTR_DST";
        print $fptOut "\n";
        print $fptOut "set CSTR_INC \"\n";

        # main loop
        getStrInc($fptOut, $CSTR_SRC);

        # log end
        print $fptOut "             \"\n";
        close $fptOut;
    }


#--- RTL -------------------------------
    if ($CSTR_TYP eq "RTL") {
        # log begin
        open my $fptOut, "> $CSTR_DST";
        print $fptOut "\n";
        print $fptOut "set CSTR_RTL \"\n";

        # main loop
        getStrRtl($fptOut, $CSTR_SRC);

        # log end
        print $fptOut "             \"\n";
        close $fptOut;
    }
