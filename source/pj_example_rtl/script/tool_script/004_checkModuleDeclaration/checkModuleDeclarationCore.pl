#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkModuleDeclarationCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check module declaration (core)
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
    my $sizLine = 0;
    my $sizSpaceMin = 100;

    # go to the begin of module declaration
    while (<F_I>) {
        # preprocess
        chomp;

        # update line number
        $numLine++;

        # break
        if (/^module \S+(\s*)\(/) {
            if (length($1) > 0) {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the space between module name and (\n";
            }
            last;
        }
    }

    # main loop
    while (<F_I>) {
        # preprocess
        chomp;

        # update line number
        $numLine++;

        # skip
        if (/skip checkModuleDeclaration/) {
            next;
        }

        # stop at );
        if (/^(\s*)\);/) {
            if (length($1) > 0) {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the space before )\n";
            }
            if ($sizSpaceMin != 4) {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the intention of ,\n";
            }
            last;
        }

        # bypass comment
        if (/^  \/\//) {
            next;
        }

        # bypass `ifdef
        if (/^  \`ifdef/ || /^  \`endif/) {
            next;
        }

        # match the last input and output list
        if (/^  \S+$/) {
            next;
        }

        # match include
        if (/^  \`include \"\S+\"/) {
            next;
        }

        # match normal input and output list
        if (/^  \S*(\s*),$/) {
            # note down the smallest space length
            if (length($1) < $sizSpaceMin) {
                $sizSpaceMin = length($1);
            }

            # the line length must be the same
            if ($sizLine == 0) {
                $sizLine = length($_);
            }
            else {
                if (length($_) != $sizLine) {
                    printf "    please check $ARGV[0]:$numLine: $_ to correct length of line\n";
                    last;
                }
            }
            next;
        }

        # other content
        printf "    please check $ARGV[0]:$numLine: $_ to correct the contents\n";
        last;
    }
