#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkParamInputOutputRegAndWireDeclarationCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check paramter, input, output, reg and wire declaration (core)
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
    my $SIZE_MAX = 10000;
    my $numLine = 0;
    my $sizSpaceBeforeSemiMin = $SIZE_MAX;
    my $sizSpaceInWidthMin = $SIZE_MAX;
    my $sizLine = 0;
    my $enmTag = "PARAM";
    my $sizIndentName = 0;
    my $sizIndentWidth = 0;

    # go to the begin of parameter
    while (<F_I>) {
        # preprocess
        chomp;

        # udpate the line number
        $numLine++;

        # break
        if (/PARAMETER/) {
            last;
        }
    }

    # parameter
    while (<F_I>) {
        # preprocess
        chomp;

        # udpate the line number
        $numLine++;

        # update enmTag
        if (/INPUT\/OUTPUT/) {
            $enmTag = "IO";
            next;
        }
        if (/WIRE\/REG/) {
            $enmTag = "RW";
            next;
        }

        # stop at MAIN BODY or SUB BENCH
        if (/MAIN BODY/ || /SUB BENCH/) {
            if ($sizSpaceBeforeSemiMin != 1) {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of ;\n";
                last;
            }
            if ($sizSpaceInWidthMin != $SIZE_MAX && $sizSpaceInWidthMin != 0) {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of -1 :0]\n";
                last;
            }
            last;
        }

        # manually bypass
        if (/skip checkParamInputOutputRegAndWireDeclaration/ ) {
            next;
        }

        # check indentation of ;
        if ($_ !~ /^  \/\//) {
            if (/^(?<code>  .*?\S(?<space>\s*);)/) {
                # note down the smallest space length
                if (length($+{space}) < $sizSpaceBeforeSemiMin) {
                    $sizSpaceBeforeSemiMin = length($+{space});
                }

                # check length
                if ($sizLine == 0) {
                    $sizLine = length($+{code});
                }
                else {
                    if (length($+{code}) != $sizLine) {
                        printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of ;\n";
                        last;
                    }
                }
            }
        }

        # check format of param
        if ($enmTag eq "PARAM") {
            # bypass blank line, comment or define
            if (/^$/ || /^  \/\// || /^\  `ifdef/ || /^\  `else/ || /^\  `endif/ ) {
                next;
            }

            # check parameter/localparam
            elsif (/^(?<beforeName>  (?<type>parameter |localparam)\s*\S+\s* )= (?<value>\S.*)/) {
                # check the indentation of =
                if ($sizIndentName == 0) {
                    $sizIndentName = length($+{beforeName});
                }
                else {
                    if (length($+{beforeName}) != $sizIndentName) {
                        printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of =\n";
                        last;
                    }
                }
                # check value of parameter
                if ($+{type} eq "parameter " && $+{value} !~ /-1/) {
                    printf "    please check $ARGV[0]:$numLine: $_ to correct the value of parameter\n";
                    last;
                }
            }
            elsif (/(?<beforeName>\s+)\S/) {
                if (length($+{beforeName}) < $sizIndentName) {
                    printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of =\n";
                    last;
                }
            }

            # log other content
            else {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the contents (A)\n";
                last;
            }
        }

        # check format for IO or RW
        if ($enmTag eq "IO" || $enmTag eq "RW") {
            # bypass blank line, comment, include or define
            if (/^$/ || /^  \/\// || /^  \`include/ || /^  \`ifdef/ || /^  \`else/ || /^  \`endif/ ) {
                next;
            }

            # bypass marker
            if (/^    \/\/ \++$/ ) {
                next;
            }

            # check input/output/inout
            if (/^(?<beforeName>(?<beforeWidth>  .*)\[.*?(?<space>\s*)-1 :.\]    )\S+.* ;/) {
                # note down the smallest space length
                if (length($+{space}) < $sizSpaceInWidthMin) {
                    $sizSpaceInWidthMin = length($+{space});
                }

                # check the indentation of name
                if ($sizIndentName == 0) {
                    $sizIndentName = length($+{beforeName});
                }
                else {
                    if (length($+{beforeName}) != $sizIndentName) {
                        printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of name\n";
                        last;
                    }
                }

                # check the indentation of width
                if ($sizIndentWidth == 0) {
                    $sizIndentWidth = length($+{beforeWidth});
                }
                else {
                    if (length($+{beforeWidth}) != $sizIndentWidth) {
                        printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of width\n";
                        last;
                    }
                }
            }
            elsif (/\[.*\]/) {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the content of width\n";
                last;
            }
            elsif (/^(?<beforeName>  .*? )\S+\s+;/) {
                # check the indentation of name
                if ($sizIndentName == 0) {
                  $sizIndentName = length($+{beforeName});
                }
                else {
                    if (length($+{beforeName}) != $sizIndentName) {
                        printf "    please check $ARGV[0]:$numLine: $_ to correct the indentation of name\n";
                        last;
                    }
                }
            }

            # log other content
            else {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the contents (B)\n";
                last;
            }
        }

        # format for RW
        if ($enmTag eq "RW") {
            next;
        }
    }
