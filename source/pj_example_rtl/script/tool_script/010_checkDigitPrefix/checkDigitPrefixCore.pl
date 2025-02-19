#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkDigitPrefixCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check digital prefix (core)
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
        # strPre-process
        chomp;

        # update line counter
        $numLine++;

        # bypass comments
        if (/^\s*\/\//) {
            next;
        }

        # reset flag
        $flgHit = 0;

        # match digits
        my $strIter = $_ ;
        while ($strIter =~ /(?<strPre>.*\D)(?<strMid>\d+)(?<strPst>\D*)/) {
            my $strPre = $+{strPre};
            my $strMid = $+{strMid};
            my $strPst = $+{strPst};
            $flgHit = 1;

            # type A
            if (   $strPre =~ /\w$/                                # if it is a variable
                || $strPst =~ /^\'/                                # if it is a prefix
            #   || $strPre =~ /#\(?\s*$/                           # if it is a delay
                || $strPre =~ /reg \s*(signed)?/                   # if it is a reg  declaration
                || $strPre =~ /wire\s*(signed)?/                   # if it is a wire declaration
                || $strPre =~ /input \s*(signed)?/                 # if it is an input  declaration
                || $strPre =~ /output\s*(signed)?/                 # if it is an output declaration
            #   || $strPre =~ /{[^{]*$/ && $strPst =~ /^[^{]*{/    # if it is a "cat" counter
            ) {
                $flgHit = 0;
            }

            # type B
            if (   $strPre =~ /^\s+parameter\s+\w+\s+= -$/  && $strPst =~ /^\s+;(    \/\/ .*)?$/    # if it is a global parameter
                || $strPre =~ /^\s+\`define\s+\w+\s+ -$/    && $strPst =~ /^$/                      # if it is a global define
                || $strPre =~ /^\s+\`define\s+SIM_DATA_PRD_CLK/                                     # if it is a time related define
                || $strPre =~ /^\s+\`define\s+\w+_TIME/                                             # if it is a dump related define
            #   || $strPre =~ /KNOB_REGOUT == -/                                                    # if it is a sanity check
                || $strPre =~ /^\s+#/                                                               # if it is a delay
            ) {
                $flgHit = 0;
            }

            # type C
            if (   $strPre =~ /\/\/.*$/                          # if it is inside a comment
            #   || $strPre =~ /for\(/                            # if it is inside a for statement
                || $strPre =~ /\[\s*$/ && $strPst =~ /^\s*\]/    # if it is inside a square brackets and nothing else is there
                || $strPre =~ /\[\s*$/ && $strPst =~ /^\s*:/
                || $strPre =~ /:\s*$/  && $strPst =~ /^\s*\]/
                || $strPre =~ /"[^"]*$/                          # if it is inside a pair of double quotation marks
            ) {
                $flgHit = 0;
            }

            ## type D
            #if (   $strPre =~ /gvIdx\w*\s*[+\-*\/<=>]\s*$/    # if it works with gvIdx
            #    || $strPre =~ /`GET_PXL\([^(]*$/              # if it works with specific defines
            #) {
            #    $flgHit = 0;
            #}

            if (   $strPre =~ /\[\s*\'[dhx]$/ && $strPst =~ /^\s*\]/    # if it is inside a square brackets and nothing else is there
                || $strPre =~ /\[\s*\'[dhx]$/ && $strPst =~ /^\s*:/
                || $strPre =~ /:\s*\'[dhx]$/  && $strPst =~ /^\s*\]/
            ) {
                # !!!     1 here is not a typo.
                $flgHit = 1;
            }

            # exit or strIter
            if ($flgHit) {
                last;
            }
            else {
                $strIter = $strPre;
            }
        }

        # print info
        if ($flgHit == 1) {
            if (   $FLAG_SHOW
                || ! ( /skip checkDigitPrefix/
                    || /skip checkParamInputOutputRegAndWireDeclaration/
                     )
            ) {
                printf "    please check $ARGV[0]:$numLine: $_\n";
            }
        }
    }
