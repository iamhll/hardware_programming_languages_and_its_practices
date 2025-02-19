#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkAssignmentCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check assignment (core)
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
    my $strWrong = "EMPTY";

    # main loop
    while (<F_I>) {
        # preprocess
        chomp;

        # udpate the line number
        $numLine++;

        # match non-block assignment
        if (/always @\(\*/ || /assign/ || /wire/) {
            $strWrong = "<=";
        }

        # match block assignment
        if (/always @\(posedge/) {
            $strWrong = "[^<=>!]=[^=]";
        }

        # reset pattern
        if (/module / || /initial / || /for\(/) {
            $strWrong = "EMPTY";
        }

        # check assignment
        if (/$strWrong/) {
            if (!/$strWrong here is not an assignment/) {
                printf "    please check $ARGV[0]:$numLine: $_\n";
            }
        }
    }
