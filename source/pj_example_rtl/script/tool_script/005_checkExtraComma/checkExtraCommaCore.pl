#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkExtraCommaCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check extra comma (core)
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use utf8;
    use strict;


#*** MAIN BODY *****************************************************************
    # open file
    open F_I, "< $ARGV[0]";

    # variables
    my $numLine = 0;
    my $strLinePre;
    my $flgHit = 0;

    # main loop
    while (<F_I>) {
        # pre-process
        chomp;

        # update line number
        $numLine++;

        # match );
        if (/^\s*\);/) {
            if ($flgHit) {
              printf "    please check $ARGV[0]:$numLine: $_\n";
            };
        }

        # match ,
        if (/,\s*(\/\/.*)?$/) {
            $flgHit = 1;
        }
        else {
            $flgHit = 0;
        }

        # note down the current line
        $strLinePre = $_;
    }
