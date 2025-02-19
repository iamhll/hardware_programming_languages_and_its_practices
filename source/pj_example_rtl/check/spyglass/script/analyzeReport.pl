#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : analyzeReport.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : analyze spyglass reports
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use strict;
    use POSIX;


#*** VARIABLES *****************************************************************
    my $CSTR_SRC         = $ARGV[0];
    my $CSTR_DST         = $ARGV[1];
    my $CSTR_LEVEL_WAIVE = $ARGV[2];
    my $CSTR_DIR_RPT     = "rpt";

    my $flg;
    my $strLabel;
    my $strFile;
    my $strName;
    my $idxLine;
    my $strDescription;
    my $strCode;


#*** MAIN BODY *****************************************************************
    # open file
    open F_O          , "> $CSTR_DST";
    open F_I_LIST_RULE, "< $CSTR_SRC";

    # main loop
    while (<F_I_LIST_RULE>) {
        # preprocess
        chomp;

        # bypass comment
        if (/\s*#\s*(\S*)/) {
            print "bypassing  [$_]\n";
            next;
        }

        # bypass blank line
        if (/^\s*$/) {
            next;
        }

        # match target in list
        if (/(\S*)/) {
            # log
            print "processing [$_]\n";

            # get rule
            my $strRule = $1;
            $strRule =~ s/\//_/;
            $strRule = $strRule.".rpt";

            # log
            print F_O "#---------------------------------------\n";
            print F_O "#  processing $strRule\n";
            print F_O "#---------------------------------------\n";

            # open report
            open F_I_REPORT, "< $CSTR_DIR_RPT/$strRule";

            # core loop
            while (<F_I_REPORT>) {
                # reset
                chomp;
                $flg     = 0;
                $strCode = "none";

                # get label, file, line and descriptin
                if (/^(?<strLabel>\S+).*(Warning|Error)\s+(?<strFile>\S+)\s+(?<idxLine>\d+)\s+\d+\s(?<strDescription>.*)/) {
                    $flg            = 1;
                    $strLabel       = $+{strLabel};
                    $strFile        = $+{strFile};
                    $idxLine        = $+{idxLine};
                    $strDescription = $+{strDescription};
                    if (   ($CSTR_LEVEL_WAIVE ne "off")
                        && (   $strLabel eq 'checkSGDC_01'
                            || $strLabel eq 'WRN_69'
                            || $strLabel eq 'ReportIgnoredOverlappingRules'
                            || $strLabel eq 'Av_width_mismatch_assign'
                               # Reason     : This violation appears when the LHS width is less than the RHS width
                               # Consequence: If you do not fix this violation,
                               #              SpyGlass truncates some bits in the assignment
                            || $strLabel eq 'Av_width_mismatch_expr02'
                               # Reason     : A violation is reported when there is a bit-width mismatch
                               #              between the left expression of bit-width and right-expression of bit-width
                               # Consequence: While working with expressions of different bit-widths
                               #              may be the intended behavior,
                               #              it is also a potentially error-prone design practice.
                               #              For example, the addition of two words of unequal widths may indicate that
                               #              you forgot to update the width of one of the buses.
                            || $strLabel eq 'W116'
                               # Reason     : A violation is reported when there is a bit-width mismatch
                               #              between the left expression of bit-width and right-expression of bit-width
                               # Consequence: While working with expressions of different bit-widths
                               #              may be the intended behavior,
                               #              it is also a potentially error-prone design practice.
                               #              For example, the addition of two words of unequal widths may indicate that
                               #              you forgot to update the width of one of the buses.
                            || $strLabel eq 'W240'
                               # Reason     : The W240 rule reports input ports that are never read in the module.
                               #              While such ports are allowed, the rule helps you clean up your design.
                            || $strLabel eq 'W287b'
                               # Reason     : The W287b flags module or gate instances where the output portsare not connected.
                               #              While such descriptions are allowed, they are generally design mistakes.
                            || $strLabel eq 'W486'
                               # Reason     : Violation may arise when the width of the RHS expression
                               #              is greater than the width of the LHS expression in a left-shift operation.
                               # Consequence: When an expression containing a left-shift is assigned to
                               #              a bus with a width less than required to
                               #              hold some of the most-significant shifted bits,
                               #              such bits are truncated and this can lead to arithmetic functional error.
                            || $strLabel eq 'Av_signed_unsigned_mismatch' && $strDescription =~ /used with signed expression \'.*gvIdx.*\'/
                               # Reason     : This violation appears when an unsigned expression is used with a signed expression.
                               # Consequence: \
                            || $strLabel eq 'Av_signed_unsigned_mismatch' && $strDescription =~ /used with signed expression \'.*lpIdx.*\'/
                               # Reason     : This violation appears when an unsigned expression is used with a signed expression.
                               # Consequence: \
                           )
                    ) {
                        $flg = 0;
                    }
                }

                # grep
                if ($flg) {
                    # get name & code
                    if (/(?<strName>\w+\.v)/) {
                        $strName = $+{strName};
                    }
                    else {
                        $strName = $strFile;
                    }
                    if (-e "$strFile") {
                        $strCode = readpipe("sed -n '${idxLine}p' $strFile");
                        $strCode =~ s/^\s+(.*)/$1/
                    }

                    # display
                    if ($CSTR_LEVEL_WAIVE ne "both" || $strCode !~ /spyglass/ || $strCode !~ /$strLabel/) {
                        print F_O "    $strLabel @ $strFile:$idxLine\n";
                        print F_O "    description :    $strDescription\n";
                        print F_O "    code        :    $strCode\n";
                        print F_O "\n";
                    }
                }
                #else {
                #  print F_O "    bypass $_\n";
                #}
            }

            # close file
            close F_I_REPORT;
        }
    }

    # close file
    close F_O;
