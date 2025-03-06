#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkExpressionInSquareBracketCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check expression in squre brackets (core)
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

        # match type A
        if (/\[[^\[:\]]*[^-+]:(?<str>[^\[:\]]*)/) {
            my $str = $+{str};
            $flgHit = 1;

            # if $str does not contain any non-digital or non-space character, bypass it
            if ($str !~ /[^0-9 ]/) {
                $flgHit = 0;
            }
        }

        # match type B
        elsif (/^\s*[^-+]:(?<str>.*)/) {
            my $str = $+{str};
            $flgHit = 1;

            # if $str does not contain any non-digital or non-space character, bypass it
            if ($str !~ /[^0-9 ]/) {
                $flgHit = 0;
            }
            # if $str contains ;, bypass it
            if ($str =~ /[;\[\]]/) {
                $flgHit = 0;
            }
        }

        # print info
        if ($flgHit == 1) {
            if ($FLAG_SHOW || !/skip checkExpressionInSquareBracket/) {
                printf "    please check $ARGV[0]:$numLine: $_\n";
            }
        }
    }
