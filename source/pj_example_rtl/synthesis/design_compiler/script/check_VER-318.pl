#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : check_VER-318.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check design compiler's warning VER-318
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use strict;
    use POSIX;


#*** VARIABLES *****************************************************************
    my $flag;
    my $strFile;
    my $idxLine;
    my $strCode;


#*** MAIN BODY *****************************************************************
    # open report
    open FPT, "<$ARGV[0]";

    # core loop
    while (<FPT>) {
        # reset
        chomp;
        $flag = 0;
        $strCode = "none";

        # get strFile, idxLine
        if (/^Warning:  (?<strFile>\S+):(?<idxLine>\d+):.*\(VER-318\)/) {
            $flag    = 1;
            $strFile = $+{strFile};
            $idxLine = $+{idxLine};
        }

        # get strCode
        if ($flag) {
            if (-e "$strFile") {
                $strCode = readpipe("sed -n '${idxLine}p' $strFile");
            }
        }

        # mannually skip by file names
        #if (   $strFile =~ /???/
        #    || $strFile =~ /???/
        #) {
        #    $flag = 0;
        #}

        # mannually skip by markers
        if ($strCode =~ /skip checkVER-318/) {
            $flag = 0;
        }
        # begin of generation block
        if ($strCode =~ /^\s*for\( gvIdx/) {
            $flag = 0;
        }
        # begin of loop block
        if ($strCode =~ /^\s*for\( lpIdx/) {
            $flag = 0;
        }
        # end of generation or loop block
        if ($strCode =~ /^\s*end$/) {
            $flag = 0;
        }
        # instantiation
        if ($strCode =~ /^\s*\) \w+\($/) {
            $flag = 0;
        }

        # display
        if ($flag) {
            print "$_\n";
        }
    }

    # close strFile
    close FPT;
