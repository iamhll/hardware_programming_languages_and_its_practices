#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkUnreferencedVariableCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check unreferenced variables (core)
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use utf8;
    use strict;


#*** MAIN BODY *****************************************************************
#--- VARIABLES -------------------------
    my %strVar;
    my $strkey;
    my $numLine = 0;


#--- COLLECT DECLARATION ---------------
    # open file
    open F_I, "< $ARGV[0]";

    # main loop
    while (<F_I>) {
        # pre-process
        chomp;

        # update line number
        $numLine++;

        # remove comments
        while (/\/\//) {
            s/(.*)\/\/.*/$1/;
        }

        # match );
        if (/^\s*(?:reg|wire).*\s(\w+)\s*;/) {
            #print "$1\n";
            $strVar{$1} = $numLine;
        }
    }

    # close file
    close F_I;


#--- CHECK REFERENCE ------------------
    # open file
    open F_I, "< $ARGV[0]";

    # main loop
    while (<F_I>) {
        # pre-process
        chomp;

        # remove comments
        while (/\/\//) {
            s/(.*)\/\/.*/$1/;
        }

        # skip declaration
        if (/^\s*(?:reg|wire).*\s(\w+)\s*;/) {
            next;
        }

        foreach $strkey (keys %strVar) {
            if (/$strkey/) {
                delete $strVar{$strkey};
            }
        }
    }

    # log
    foreach $strkey (keys %strVar) {
        printf "    please check $ARGV[0]:$strVar{$strkey}: $strkey\n";
    }

    # close file
    close F_I
