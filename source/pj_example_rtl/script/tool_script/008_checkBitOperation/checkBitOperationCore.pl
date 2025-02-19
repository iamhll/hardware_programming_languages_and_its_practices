#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkBitOperationCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check bit operation (core)
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use utf8;
    use strict;


#*** PARAMTER ******************************************************************
    my $FLAG_SHOW = 0;


#*** MAIN BODY *****************************************************************
    # open file
    open F_I, "< $ARGV[0]";

    # variables
    my $numLine = 0;
    my $flgHit = 0;

    # main loop
    while (<F_I>) {
        # pre-process
        chomp;

        # update line counter
        $numLine++;

        # bypass comments
        if (/^\s*\/\//) {
            next;
        }

        # reset flag
        $flgHit = 0;

        # match single &
        if (/[^&](&)[^&]/) {
            $flgHit += 1;
        }
        # match single |
        if (/[^|](\|)[^|]/) {
            $flgHit += 2;
        }

        # print info
        if ($flgHit == 1) {
            if ($FLAG_SHOW || !/& here is a bit operation/) {
                printf "    please check $ARGV[0]:$numLine: $_\n";
            }
        }
        if ($flgHit == 2) {
            if ($FLAG_SHOW || !/\| here is a bit operation/) {
                printf "    please check $ARGV[0]:$numLine: $_\n";
            }
        }
        if ($flgHit == 3) {
            if ($FLAG_SHOW || !/& and \| here are bit operations/) {
                printf "    please check $ARGV[0]:$numLine: $_\n";
            }
        }
    }
