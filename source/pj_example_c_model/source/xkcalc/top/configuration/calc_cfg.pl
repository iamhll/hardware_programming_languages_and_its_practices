#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : calc_cfg.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate cfg.*
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use utf8;
    use strict;


#*** FUNCTION ******************************************************************
    sub writeHeader {
        my $fpt            = $_[0];
        my $strFileName    = $_[1];
        my $strDescription = $_[2];
        (my $sec,my $min,my $hour,my $mday,my $mon,my $year,my $wday,my $yday,my $isdst) = localtime(time);
        printf $fpt "//------------------------------------------------------------------------------\n";
        printf $fpt "    //\n";
        printf $fpt "    //  Filename       : $strFileName\n";
        printf $fpt "    //  Author         : Huang Leilei\n";
        printf $fpt "    //  Status         : draft\n";
        printf $fpt "    //  Created        : 2025-02-18\n";
       #printf $fpt "    //  Created        : %04d-%02d-%02d\n", $year+1900, $mon+1, $mday;
        printf $fpt "    //  Description    : $strDescription\n";
        printf $fpt "    //\n";
        printf $fpt "//------------------------------------------------------------------------------\n";
        printf $fpt "    //\n";
        printf $fpt "    //  *** auto-generated, please do NOT modify it mannually ***\n";
        printf $fpt "    //\n";
        printf $fpt "//------------------------------------------------------------------------------\n";
        printf $fpt "\n";
    }


#*** VARIABLES *****************************************************************
    my $strTag = "calc";
    my $strTagUc = uc("calc");

    my $fptInp           ;
    my $fptOut           ;
    my $num              ;
    my $sizStrDomain     ;
    my $sizStrLevel      ;
    my $sizStrNameCur    ;
    my $sizStrNameCurKey ;
    my $sizStrNameCurVar ;
    my $sizStrSize       ;
    my $sizStrKeyShort   ;
    my $sizStrType       ;
    my $sizStrDatMin     ;
    my $sizStrDatMax     ;
    my $sizStrDatPrc     ;
    my $sizStrDatDef     ;
    my $sizStrDescription;

    my @domain     ;
    my @level      ;
    my @nameCur    ;
    my @size       ;
    my @keyShort   ;
    my @type       ;
    my @datMin     ;
    my @datMax     ;
    my @datPrc     ;
    my @datDef     ;
    my @description;


#*** MAIN BODY *****************************************************************
#--- GREP INFOFORMATION ----------------
    # open file
    open $fptInp, "< ${strTag}_cfg.csv";

    # grep
    $num = 0;
    while(<$fptInp>) {
        chomp;
        /(?<domain>.*),(?<nameCur>.*),(?<level>.*),(?<size>.*),(?<keyShort>.*),(?<type>.*),(?<datMin>.*),(?<datMax>.*),(?<datPrc>.*),(?<datDef>.*),(?<description>.*)/;
        $domain     [$num] = $+{domain     };
        $nameCur    [$num] = $+{nameCur    };
        $level      [$num] = $+{level      };
        $size       [$num] = $+{size       };
        $keyShort   [$num] = $+{keyShort   };
        $type       [$num] = $+{type       };
        $datMin     [$num] = $+{datMin     };
        $datMax     [$num] = $+{datMax     };
        $datPrc     [$num] = $+{datPrc     };
        $datDef     [$num] = $+{datDef     };
        $description[$num] = $+{description};
        $num = $num + 1;
    }


#--- GET LENGTH ------------------------
    $sizStrDomain      = 0;
    $sizStrNameCur     = 0;
    $sizStrLevel       = 0;
    $sizStrNameCurKey  = 0;
    $sizStrNameCurVar  = 0;
    $sizStrSize        = 0;
    $sizStrKeyShort    = 0;
    $sizStrType        = 0;
    $sizStrDatMin      = 0;
    $sizStrDatMax      = 0;
    $sizStrDatPrc      = 0;
    $sizStrDatDef      = 0;
    $sizStrDescription = 0;
    foreach my $idx (0 .. $num - 1) {
        if (1) {
            if (length($domain     [$idx]) > $sizStrDomain     ) {
                $sizStrDomain      = length($domain     [$idx]);
            }
            if (length($nameCur    [$idx]) > $sizStrNameCur    ) {
                $sizStrNameCur     = length($nameCur    [$idx]);
            }
            if (length($level      [$idx]) > $sizStrLevel      ) {
                $sizStrLevel       = length($level    [$idx]);
            }

            my $sizStrNameCurKeyTmp;
            if ($size[$idx] == 1) {
                $sizStrNameCurKeyTmp = length($nameCur[$idx]);
            }
            elsif ($size[$idx] !~ /x/) {
                $sizStrNameCurKeyTmp = length($nameCur[$idx]) + 2;
            }
            else {
                $sizStrNameCurKeyTmp = length($nameCur[$idx]) + 4;
            }
            if ($sizStrNameCurKeyTmp > $sizStrNameCurKey) {
                $sizStrNameCurKey = $sizStrNameCurKeyTmp;
            }

            my $sizStrNameCurVarTmp;
            if ($size[$idx] == 1) {
                $sizStrNameCurVarTmp = length($nameCur[$idx]);
            }
            elsif ($size[$idx] !~ /x/) {
                $sizStrNameCurVarTmp = length($nameCur[$idx]) + 3;
            }
            else {
                $sizStrNameCurVarTmp = length($nameCur[$idx]) + 6;
            }
            if ($sizStrNameCurVarTmp > $sizStrNameCurVar) {
                $sizStrNameCurVar = $sizStrNameCurVarTmp;
            }

            if (length($nameCur    [$idx]) > $sizStrNameCur    ) {
                $sizStrNameCur     = length($nameCur    [$idx]);
            }
            if (length($size       [$idx]) > $sizStrSize       ) {
                $sizStrSize        = length($size       [$idx]);
            }
            if (length($keyShort   [$idx]) > $sizStrKeyShort   ) {
                $sizStrKeyShort    = length($keyShort   [$idx]);
            }
            if (length($type       [$idx]) > $sizStrType       ) {
                $sizStrType        = length($type       [$idx]);
            }
            if (length($datMin     [$idx]) > $sizStrDatMin     ) {
                $sizStrDatMin      = length($datMin     [$idx]);
            }
            if (length($datMax     [$idx]) > $sizStrDatMax     ) {
                $sizStrDatMax      = length($datMax     [$idx]);
            }
            if (length($datPrc     [$idx]) > $sizStrDatPrc     ) {
                $sizStrDatPrc      = length($datPrc     [$idx]);
            }
            if (length($datDef     [$idx]) > $sizStrDatDef     ) {
                $sizStrDatDef      = length($datDef     [$idx]);
            }
            if (length($description[$idx]) > $sizStrDescription) {
                $sizStrDescription = length($description[$idx]);
            }
        }
    }


#--- DISPLAY INFORMATION ---------------
    my $strDsp = " | %03d "
        . "| %-${sizStrDomain}s "
        . "| %-${sizStrNameCur}s "
        . "| %-${sizStrSize}s "
        . "| %-${sizStrKeyShort}s "
        . "| %-${sizStrType}s "
        . "| %-${sizStrDatMin}s "
        . "| %-${sizStrDatMax}s "
        . "| %-${sizStrDatPrc}s "
        . "| %-${sizStrDatDef}s "
        . "|\n"
    ;
    foreach my $idx (0 .. $num - 1) {
        if (1) {
            printf $strDsp
                ,$idx
                ,$domain     [$idx]
                ,$nameCur    [$idx]
                ,$size       [$idx]
                ,$keyShort   [$idx]
                ,$type       [$idx]
                ,$datMin     [$idx]
                ,$datMax     [$idx]
                ,$datPrc     [$idx]
                ,$datDef     [$idx]
            ;
        }
    }


#--- UPDATE cfg.rst --------------------
    {
        # parameter
        my $strFileName = "${strTag}_cfg.rst";

        # open file
        open $fptOut, "> $strFileName";

        # main
        my $lineTable = ("=" x ($sizStrDomain + 2))
            . " " . ("=" x ($sizStrNameCur     + 2))
            . " " . ("=" x ($sizStrSize        + 2))
            . " " . ("=" x ($sizStrKeyShort    + 2))
            . " " . ("=" x ($sizStrType        + 2))
            . " " . ("=" x ($sizStrDatMin      + 2))
            . " " . ("=" x ($sizStrDatMax      + 2))
            . " " . ("=" x ($sizStrDatPrc      + 2))
            . " " . ("=" x ($sizStrDatDef      + 2))
            . " " . ("=" x ($sizStrDescription + 2))
            . "\n"
        ;
        my $strDsp = " %-${sizStrDomain}s "
            . "  %-${sizStrNameCur}s "
            . "  %-${sizStrSize}s "
            . "  %-${sizStrKeyShort}s "
            . "  %-${sizStrType}s "
            . "  %-${sizStrDatMin}s "
            . "  %-${sizStrDatMax}s "
            . "  %-${sizStrDatPrc}s "
            . "  %-${sizStrDatDef}s "
            . "  %s"
            . "\n"
        ;
        print $fptOut $lineTable;
        foreach my $idx (0 .. $num - 1) {
            if (1) {
                my $description = $description[$idx];
                $description =~ s/\"//g;
                printf $fptOut $strDsp
                    ,$domain     [$idx]
                    ,$nameCur    [$idx]
                    ,$size       [$idx]
                    ,$keyShort   [$idx]
                    ,$type       [$idx]
                    ,$datMin     [$idx]
                    ,$datMax     [$idx]
                    ,$datPrc     [$idx]
                    ,$datDef     [$idx]
                    ,$description
                ;
            }
            if ($idx == 0) {
                print $fptOut $lineTable;
            }
        }
        print $fptOut $lineTable;
    }


#--- UPDATE xkcalc.cfg -------------
    {
        # parameter
        my $strFileName = "xkcalc.cfg";

        # open file
        open $fptOut, "> ../../../../script/run/runXkcalc/$strFileName";
        foreach my $idx (0 .. $num - 1) {
            if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/ && $domain[$idx] !~ m/changeable/ && $domain[$idx] !~ m/derived/) {
                if ($domain[$idx] ne $domain[$idx - 1]) {
                    printf $fptOut "\n#--- %s %s\n", uc($domain[$idx]), "-" x (40 - 6 - length($domain[$idx]));
                }
                if ($datDef[$idx] eq "/") {
                    printf $fptOut "# %s\n", $nameCur[$idx];
                }
                else {
                    if ($size[$idx] == 1) {
                        printf $fptOut "--%-${sizStrNameCurKey}s    %s\n", $nameCur[$idx], $datDef[$idx];
                    }
                    elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                        my $datDefLft = $datDef[$idx];
                        for (my $i = 0; $i < $size[$idx]; $i = $i + 1) {
                            $datDefLft =~ s/^(?<datDef>\S+)\s*//;
                            printf $fptOut "--%-${sizStrNameCurKey}s    %s\n", $nameCur[$idx]."_".$i, $+{datDef};
                        }
                    }
                    else {
                        my $datDefLft = $datDef[$idx];
                        for (my $j = 0; $j < $+{D1}; $j = $j + 1) {
                            for (my $i = 0; $i < $+{D2}; $i = $i + 1) {
                                $datDefLft =~ s/^(?<datDef>\S+)\s*//;
                                printf $fptOut "--%-${sizStrNameCurKey}s    %s\n", $nameCur[$idx]."_".$j."_".$i, $+{datDef};
                            }
                        }
                    }
                }
            }
        }
    }


#--- UPDATE cfg_type.hpp ---------------
    {
        # parameter
        my $strFileName    = "${strTag}_cfg_type.hpp";
        my $strDescription = "configuration related header (type)";

        # open file
        open $fptOut, "> $strFileName";

        # header
        writeHeader($fptOut, $strFileName, $strDescription);

        # ifdef
        $strFileName =~ s/\./_/;
        $strFileName = uc($strFileName);
        printf $fptOut "#ifndef __%s__\n", $strFileName;
        printf $fptOut "#define __%s__\n", $strFileName;
        printf $fptOut "\n";

        # include
        printf $fptOut "//*** INCLUDE ******************************************************************\n";
        printf $fptOut "    #include \"${strTag}_common.hpp\"\n";
        printf $fptOut "\n";
        printf $fptOut "\n";

        # type
        printf $fptOut "//*** TYPE *********************************************************************\n";
        printf $fptOut "    struct ${strTag}_cfg_t {";
        foreach my $idx (0 .. $num - 1) {
            if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/) {
                if ($domain[$idx] ne $domain[$idx - 1]) {
                    printf $fptOut "\n        // $domain[$idx]\n";
                }
                if ($size[$idx] == 1) {
                    printf $fptOut "        %-08s    %s;\n", $type[$idx], $nameCur[$idx];
                }
                elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                    printf $fptOut "        %-08s    %s[%d];\n", $type[$idx], $nameCur[$idx], $size[$idx];
                }
                else {
                    printf $fptOut "        %-08s    %s[%d][%d];\n", $type[$idx], $nameCur[$idx], $+{D1}, $+{D2};
                }
            }
        }
        printf $fptOut "\n";
        printf $fptOut "        // =\n";
        printf $fptOut "        ${strTag}_cfg_t &operator=(const ${strTag}_cfg_t &cfg) {";
        foreach my $idx (0 .. $num - 1) {
            if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/) {
                if ($domain[$idx] ne $domain[$idx - 1]) {
                    printf $fptOut "\n            // $domain[$idx]\n";
                }
                if ($size[$idx] == 1) {
                    printf $fptOut "            %-${sizStrNameCur}s       = cfg.%-${sizStrNameCur}s;\n", $nameCur[$idx], $nameCur[$idx];
                }
                else {
                    printf $fptOut "            memcpy(%-${sizStrNameCur}s, cfg.%-${sizStrNameCur}s, sizeof(%-${sizStrNameCur}s));\n", $nameCur[$idx], $nameCur[$idx], $nameCur[$idx];
                }
            }
        }
        printf $fptOut "            return *this;\n";
        printf $fptOut "        }\n";
        printf $fptOut "    };\n";

        # endif
        printf $fptOut "\n";
        printf $fptOut "#endif /* __%s__ */\n", $strFileName;
    }


#--- UPDATE cfg_proc.cpp ---------------
    {
        # parameter
        my $strFileName    = "${strTag}_cfg_proc.cpp";
        my $strDescription = "configuration related codes (proc)";

        # open file
        open $fptOut, "> $strFileName";

        # header
        writeHeader($fptOut, $strFileName, $strDescription);

        # include
        print $fptOut "//*** INCLUDE ******************************************************************\n";
        print $fptOut "#include \"${strTag}_cfg.hpp\"\n";
        print $fptOut "\n";
        print $fptOut "\n";

        # type
        printf $fptOut "//*** FUNCTION *****************************************************************\n";
        printf $fptOut "// ${strTag}_cfgRst\n";
        {
            printf $fptOut "void ${strTag}_cfgRst(${strTag}_cfg_t *cfg)\n";
            printf $fptOut "{";
            foreach my $idx (0 .. $num - 1) {
                if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/) {
                    if ($domain[$idx] ne $domain[$idx - 1]) {
                        printf $fptOut "\n    // $domain[$idx]\n";
                    }
                    if ($datDef[$idx] eq "/") {
                        if ($type[$idx] eq "string") {
                            printf $fptOut "    cfg->%-${sizStrNameCurVar}s = \"\";\n", $nameCur[$idx];
                        }
                        else {
                            if ($size[$idx] == 1) {
                                printf $fptOut "    cfg->%-${sizStrNameCurVar}s = 0;\n", $nameCur[$idx];
                            }
                            else {
                                printf $fptOut "    memset(cfg->%s, 0, sizeof(cfg->%s));\n", $nameCur[$idx], $nameCur[$idx];
                            }
                        }
                    }
                    else {
                        if ($type[$idx] eq "string") {
                            printf $fptOut "    cfg->%-${sizStrNameCurVar}s = \"%s\";\n", $nameCur[$idx], $datDef[$idx];
                        }
                        else {
                            if ($size[$idx] == 1) {
                                printf $fptOut "    cfg->%-${sizStrNameCurVar}s = $datDef[$idx];\n", $nameCur[$idx];
                            }
                            elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                                my $datDefLft = $datDef[$idx];
                                for (my $i = 0; $i < $size[$idx]; $i = $i + 1) {
                                    $datDefLft =~ s/^(?<datDef>\S+)\s*//;
                                    printf $fptOut "    cfg->%-${sizStrNameCurVar}s = %s;\n", $nameCur[$idx]."[".$i."]", $+{datDef};
                                }
                            }
                            else {
                                my $datDefLft = $datDef[$idx];
                                for (my $j = 0; $j < $+{D1}; $j = $j + 1) {
                                    for (my $i = 0; $i < $+{D2}; $i = $i + 1) {
                                        $datDefLft =~ s/^(?<datDef>\S+)\s*//;
                                        printf $fptOut "    cfg->%-${sizStrNameCurVar}s = %s;\n", $nameCur[$idx]."[".$j."][".$i."]", $+{datDef};
                                    }
                                }
                            }
                        }
                    }
                }
            }
            printf $fptOut "}\n";
            printf $fptOut "\n";
        }

        printf $fptOut "// ${strTag}_cfgHlp\n";
        {
            printf $fptOut "void ${strTag}_cfgHlp(\n";
            printf $fptOut "${strTag}_cfg_t *cfg)\n";
            printf $fptOut "{\n";
            foreach my $idx (0 .. $num - 1) {
                if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/changeable/ && $domain[$idx] !~ m/derived/) {
                    if ($domain[$idx] ne $domain[$idx - 1]) {
                        printf $fptOut "    cout << endl;\n";
                        printf $fptOut "    cout << \"[$domain[$idx]]\" << endl;\n";
                    }
                    my $description = $description[$idx];
                    $description =~ s/\"//g;
                    printf $fptOut "    if (${strTagUc}_CFG_ENUM_LVL_RLS >= ${strTag}_enmLvlCfg_t::%-${sizStrLevel}s) cout << \"    %-${sizStrNameCur}s    %s\" << endl;\n", uc($level[$idx]), $nameCur[$idx], $description;
                }
            }
            printf $fptOut "}\n";
            printf $fptOut "\n";
        }

        printf $fptOut "// ${strTag}_cfgMap\n";
        {
            printf $fptOut "void ${strTag}_cfgMap(${strTag}_cfg_t *cfg,\n";
            printf $fptOut "const string *strKey, const string *strDat)\n";
            printf $fptOut "{\n";
            printf $fptOut "    // variables\n";
            printf $fptOut "    const char *datAsCStr   = strDat->data();\n";
            printf $fptOut "    int         datAsInt    = atoi(strDat->data());\n";
            printf $fptOut "    double      datAsDouble = atof(strDat->data());\n";
            printf $fptOut "    bool        datAsBool   = datAsInt ? true : false;\n";
            printf $fptOut "\n";
            printf $fptOut "    // mapping\n";
            my $numMap = 0;
            foreach my $idx (0 .. $num - 1) {
                if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/ && $domain[$idx] !~ m/changeable/ && $domain[$idx] !~ m/derived/) {
                    my $numI;
                    my $numJ;
                    my $strKey;
                    my $strVar;
                    if ($size[$idx] == 1) {
                        $numJ = 1;
                        $numI = 1;
                    }
                    elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                        $numJ = 1;
                        $numI = $size[$idx];
                    }
                    else {
                        $numJ = $+{D1};
                        $numI = $+{D2};
                    }
                    for (my $idxJ = 0; $idxJ < $numJ; $idxJ = $idxJ + 1) {
                        for (my $idxI = 0; $idxI < $numI; $idxI = $idxI + 1) {
                            if ($numI == 1 && $numJ == 1) {
                                $strKey = $nameCur[$idx];
                                $strVar = $nameCur[$idx];
                            } elsif ($numI > 1 && $numJ == 1) {
                                $strKey = $nameCur[$idx]."_$idxI";
                                $strVar = $nameCur[$idx]."[$idxI]";
                            } else {
                                $strKey = $nameCur[$idx]."_$idxJ"."_$idxI";
                                $strVar = $nameCur[$idx]."[$idxJ]"."[$idxI]";
                            }
                            if ($numMap == 0) {
                                printf $fptOut "    if     ";
                            }
                            else {
                                printf $fptOut "    else if";
                            }
                            my $sizStrTmp = length("\"--") + ${sizStrNameCurKey} + length("\"");
                            printf $fptOut " (${strTagUc}_CFG_ENUM_LVL_RLS >= ${strTag}_enmLvlCfg_t::%-${sizStrLevel}s && (*strKey == %-${sizStrTmp}s", uc($level[$idx]), "\"--".$strKey."\"";
                            if ($keyShort[$idx] ne "/") {
                                printf $fptOut "|| *strKey == \"-%s\"", $keyShort[$idx];
                            }
                            else {
                                printf $fptOut " " x length("|| *strKey == \"-c\"");
                            }
                            printf $fptOut "))", $strKey;
                            printf $fptOut "    cfg->%-${sizStrNameCurVar}s = ", $strVar;
                            if ($type[$idx] eq "string") {
                                printf $fptOut "datAsCStr";
                            }
                            elsif ($type[$idx] eq "bool") {
                                printf $fptOut "datAsBool";
                            }
                            elsif ($type[$idx] eq "double") {
                                printf $fptOut "datAsDouble";
                            }
                            else {
                                printf $fptOut "datAsInt";
                            }
                            printf $fptOut ";\n";
                            $numMap = ($numMap + 1) % 100;
                        }
                    }
                }
            }
            printf $fptOut "}\n";
            printf $fptOut "\n";
        }

        printf $fptOut "// ${strTag}_cfgL2X\n";
        {
            printf $fptOut "void ${strTag}_cfgL2X(${strTag}_cfg_t *cfg)\n";
            printf $fptOut "{\n";
            foreach my $idx (0 .. $num - 1) {
                if ($domain[$idx] !~ m/domain/) {
                    if ($datPrc[$idx] != '\\') {
                        my $numI;
                        my $numJ;
                        my $strKey;
                        my $strVar;
                        if ($size[$idx] == 1) {
                            $numJ = 1;
                            $numI = 1;
                        }
                        elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                            $numJ = 1;
                            $numI = $size[$idx];
                        }
                        else {
                            $numJ = $+{D1};
                            $numI = $+{D2};
                        }
                        for (my $idxJ = 0; $idxJ < $numJ; $idxJ = $idxJ + 1) {
                            for (my $idxI = 0; $idxI < $numI; $idxI = $idxI + 1) {
                                if ($numI == 1 && $numJ == 1) {
                                    $strKey = $nameCur[$idx];
                                    $strVar = $nameCur[$idx];
                                } elsif ($numI > 1 && $numJ == 1) {
                                    $strKey = $nameCur[$idx]."_$idxI";
                                    $strVar = $nameCur[$idx]."[$idxI]";
                                } else {
                                    $strKey = $nameCur[$idx]."_$idxJ"."_$idxI";
                                    $strVar = $nameCur[$idx]."[$idxJ]"."[$idxI]";
                                }
                                printf $fptOut "    cfg->%s = ${strTag}_getDatRound(cfg->%s, %1s);\n", $strVar, $strVar, $datPrc[$idx];
                            }
                        }
                    }
                }
            }
            printf $fptOut "}\n";
            printf $fptOut "\n";
        }

        printf $fptOut "// ${strTag}_cfgChk\n";
        {
            printf $fptOut "int  ${strTag}_cfgChk(\n";
            printf $fptOut "${strTag}_cfg_t *cfg)\n";
            printf $fptOut "{\n";
            foreach my $idx (0 .. $num - 1) {
                if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/ && $domain[$idx] !~ m/changeable/) {
                    if ($datMin[$idx] ne "/" || $datMax[$idx] ne "/") {
                        my $numI;
                        my $numJ;
                        my $strKey;
                        my $strVar;
                        if ($size[$idx] == 1) {
                            $numJ = 1;
                            $numI = 1;
                        }
                        elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                            $numJ = 1;
                            $numI = $size[$idx];
                        }
                        else {
                            $numJ = $+{D1};
                            $numI = $+{D2};
                        }
                        for (my $idxJ = 0; $idxJ < $numJ; $idxJ = $idxJ + 1) {
                            for (my $idxI = 0; $idxI < $numI; $idxI = $idxI + 1) {
                                if ($numI == 1 && $numJ == 1) {
                                    $strKey = $nameCur[$idx];
                                    $strVar = $nameCur[$idx];
                                } elsif ($numI > 1 && $numJ == 1) {
                                    $strKey = $nameCur[$idx]."_$idxI";
                                    $strVar = $nameCur[$idx]."[$idxI]";
                                } else {
                                    $strKey = $nameCur[$idx]."_$idxJ"."_$idxI";
                                    $strVar = $nameCur[$idx]."[$idxJ]"."[$idxI]";
                                }
                                printf $fptOut "    if (";
                                if ($datMin[$idx] ne "/") {
                                    printf $fptOut "cfg->$strVar < $datMin[$idx]";
                                }
                                if ($datMin[$idx] ne "/" && $datMax[$idx] ne "/") {
                                    printf $fptOut " || ";
                                }
                                if ($datMax[$idx] ne "/") {
                                    printf $fptOut "cfg->$strVar > $datMax[$idx]";
                                }
                                printf $fptOut ") {\n        ";
                                if ($datMin[$idx] ne "/" && $datMax[$idx] ne "/") {
                                    printf $fptOut "cerr << \"[error from c model] cfg->$strVar should be within [$datMin[$idx],$datMax[$idx]]!\" << endl;\n";
                                }
                                elsif ($datMin[$idx] ne "/") {
                                    printf $fptOut "cerr << \"[error from c model] cfg->$strVar should be within [$datMin[$idx], +inf)!\" << endl;\n";
                                }
                                elsif ($datMax[$idx] ne "/") {
                                    printf $fptOut "cerr << \"[error from c model] cfg->$strVar should be within (-inf, $datMax[$idx]]!\" << endl;\n";
                                }
                                printf $fptOut "        return 1;\n";
                                printf $fptOut "    };\n";
                            }
                        }
                    }
                }
            }
            printf $fptOut "    return 0;\n";
            printf $fptOut "}\n";
            printf $fptOut "\n";
        }

        printf $fptOut "// ${strTag}_cfgLog\n";
        {
            printf $fptOut "void ${strTag}_cfgLog(\n";
            printf $fptOut "${strTag}_cfg_t *cfg)\n";
            printf $fptOut "{\n";
            foreach my $idx (0 .. $num - 1) {
                if ($domain[$idx] !~ m/domain/ && $domain[$idx] !~ m/virtual/ && $domain[$idx] !~ m/changeable/) {
                    my $numI;
                    my $numJ;
                    my $strKey;
                    my $strVar;
                    if ($size[$idx] == 1) {
                        $numJ = 1;
                        $numI = 1;
                    }
                    elsif ($size[$idx] !~ /(?<D1>\d+)x(?<D2>\d+)/) {
                        $numJ = 1;
                        $numI = $size[$idx];
                    }
                    else {
                        $numJ = $+{D1};
                        $numI = $+{D2};
                    }
                    for (my $idxJ = 0; $idxJ < $numJ; $idxJ = $idxJ + 1) {
                        for (my $idxI = 0; $idxI < $numI; $idxI = $idxI + 1) {
                            if ($numI == 1 && $numJ == 1) {
                                $strKey = $nameCur[$idx];
                                $strVar = $nameCur[$idx];
                            } elsif ($numI > 1 && $numJ == 1) {
                                $strKey = $nameCur[$idx]."_$idxI";
                                $strVar = $nameCur[$idx]."[$idxI]";
                            } else {
                                $strKey = $nameCur[$idx]."_$idxJ"."_$idxI";
                                $strVar = $nameCur[$idx]."[$idxJ]"."[$idxI]";
                            }
                            printf $fptOut "    if (${strTagUc}_CFG_ENUM_LVL_RLS >= ${strTag}_enmLvlCfg_t::%-${sizStrLevel}s)", uc($level[$idx]);
                            if ($type[$idx] eq "string") {
                                my $strStr = $sizStrNameCurVar + length("data()");
                                printf $fptOut "    cout << \"--%-${sizStrNameCurKey}s    \" << cfg->%s << endl;\n", $strKey, $strVar.".data()";
                            }
                            elsif ($type[$idx] eq "double") {
                                printf $fptOut "    cout << \"--%-${sizStrNameCurKey}s    \" << cfg->%s << endl;\n", $strKey, $strVar;
                            }
                            elsif ($type[$idx] eq "FILE *") {
                                printf $fptOut "    ;\n";
                            }
                            else {
                                printf $fptOut "    cout << \"--%-${sizStrNameCurKey}s    \" << cfg->%s << endl;\n", $strKey, $strVar;
                            }
                        }
                    }
                }
            }
            printf $fptOut "}\n";
        }
    }
