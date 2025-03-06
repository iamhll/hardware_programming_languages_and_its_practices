#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkFileHeaderCore.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check file header (core)
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use utf8;
    use strict;


#*** MAIN BODY *****************************************************************
    # open file
    open F_I, "< $ARGV[0]";
    #printf $ARGV[0];

    # variables
    my $numLine = 0;
    my $sizHighLight = 0;
    my $strComment = "\/\/";
    my $sizIndent = 4;
    $ARGV[0] =~ /([^\/]*)$/;
    my $strFilename = $1;

    # choose header according file type
    if ($ARGV[0] =~ /\/.*\.(.*)/) {
        if ($1 eq "v" || $1 eq "vh") {
            $strComment = "\/\/";
            $sizIndent = 2;
        }
        if ($1 eq "c" || $1 eq "sgdc") {
            $strComment = "\/\/";
            $sizIndent = 4;
        }
        if ($1 eq "m") {
            $strComment = "%";
            $sizIndent = 4;
        }
        if ($1 eq "mk" || $1 eq "pl" || $1 eq "prj" || $1 eq "sh" || $1 eq "tcl") {
            $strComment = "#";
            $sizIndent = 4;
        }
    }

    # main loop
    while (<F_I>) {
        # pre-process
        chomp;

        # update line number
        $numLine++;

        # early termination
        if (/skip checkFileHeader/) {
            last;
        }

        # skip #!
        if (/^#\!/) {
            next;
        }

        # stop at blank line
        if (/^$/) {
            if ($numLine == 1) {
                printf "    please check $ARGV[0]:$numLine: $_ to add a file header\n";
            }
            last;
        }

        # match strComment
        elsif (/(.*)$strComment(.*)/) {
            # get strPre and strPst
            my $strPre = $1;
            my $strPst = $2;

            # if strPre is empty
            if ($strPre eq "") {
                # all characters in strPst must be "-"
                if ($strPst eq "" || $strPst =~ /[^-]/) {
                    printf "    please check $ARGV[0]:$numLine: $_ to remove incorrect contents (A)\n";
                    last;
                }

                # but the length of current line must be 80
                if (length($_) != 80) {
                    printf "    please check $ARGV[0]:$numLine: $_ to correct the length\n";
                    last;
                }
            } # if strPre is empty

            # if strPre is "  "
            # TODO: use the next line.
            elsif ($strPre eq " " x 2 || $strPre eq " " x 4) {
            #elsif ($strPre eq " " x $sizIndent) {
                # strPst could be emtpy
                if ($strPst eq "") {
                    next;
                }

                # strPst could be infos
                elsif ($strPst =~ /^  Filename       : $strFilename$/
                    || $strPst =~ /^  Author         : .+$/
                    || $strPst =~ /^  Status         : draft$/
                    || $strPst =~ /^  Created        : [\d?]{4}-[\d?]{2}-[\d?]{2}$/
                    || $strPst =~ /^  Description    : .+$/
                    || $strPst =~ /^                   .+$/
                ) {
                    next;
                }

                # strPst could be highlighted
                elsif ($strPst =~ /^  \*\*\* (.+) \*\*\*$/) {
                    # but the length of highlight must be the same
                    if ($sizHighLight == 0) {
                        $sizHighLight = length($1);
                        next;
                    }
                    else {
                        if (length($1) != $sizHighLight) {
                          printf "    please check $ARGV[0]:$numLine: $_ to correct the length of high lighted content\n";
                          last;
                        }
                    }
                }

                # other content
                else {
                    printf "    please check $ARGV[0]:$numLine: $_ to remove incorrect contents (B)\n";
                    last;
                }
            } # if strPre is "  "

            # other intentation
            else {
                printf "    please check $ARGV[0]:$numLine: $_ to correct the intentation\n";
                last;
            } # other intentation
        } # match strComment

        # other content
        else {
            printf "    please check $ARGV[0]:$numLine: $_ to remove incorrect contents (C)\n";
            last;
        }
    }
