#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkLineLengthCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check line length (core)
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use utf8;
    use strict;


#*** MAIN BODY *****************************************************************
#--- VARIABLES -------------------------
    my $numLine = 0;


#--- CHECK REFERENCE ------------------
    # open file
    open F_I, "< $ARGV[0]";

    # main loop
    while (<F_I>) {
        # pre-process
        chomp;

        # update line number
        $numLine++;

        # skip $display
        if (/\$display/) {
            next;
        }

        # skip define
        if (/`define/) {
            next;
        }

        # skip check
        if (/skip checkLineLength/) {
            next;
        }

        # remove comments
        while (/\/\//) {
            s/(.*)\/\/.*/$1/;
        }

        # check line length
        if (length($_) > 120) {
            printf "    please check $ARGV[0]:$numLine: $_\n";
        }
    }

    # close file
    close F_I
