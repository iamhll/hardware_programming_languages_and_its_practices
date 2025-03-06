#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : define2undefCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate undef from define (kernel)
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use strict;
    use POSIX;


#*** MAIN BODY *****************************************************************
    # open file
    open F_I, "< $ARGV[0]";
    open F_O, "> $ARGV[1]";

    # main body
    print F_O "// skip checkFileHeader\n";
    while (<F_I>) {
        chomp;
        if (/^(\s*)`define (\w+)/) {
            print F_O "`undef $2\n";
        }
    }
