#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : generateMemory.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate memory
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    use 5.010;
    use utf8;
    use strict;


#*** PARAMETER *****************************************************************
    my $SIZE_FRA_X_MAX = 4096;
    my $SIZE_FRA_X_MAX_BNK_0 = 4096;
    my $SIZE_FRA_X_MAX_BNK_1 = 2048;
    my $DIR_PRJ  = "../../../..";
    my $DIR_CALC = "$PATH_PRJ/source/xkcalc";
    my @LIST_MEM = (
        #strlocation         strModule       strPostfix  strType   siz   datWd  flgFra
        ["$DIR_CALC/kernel" ,"calc_knl_top" ,"ext"      ,"ram_sp" ,8192 ,128   ,1]
    );


#*** MAIN BODY *****************************************************************
    # pre-precess
    system("rm ../FPGA_INST/*");
    system("rm ../GF_22_INST/*");
    system("rm ../GF_28_INST/*");
    system("rm ../HL_40_INST/*");

    # main loop
    for (my $i = 0; $i < scalar(@LIST_MEM); $i++) {
        # grep info
        my $j = 0;                        printf "processing %02d/%02d\n", $i + 1, scalar(@LIST_MEM);
        my $path      = $LIST_MEM[$i][$j++]; say "\tpath      : $path     ";
        my $postfix   = $LIST_MEM[$i][$j++]; say "\tpostfix   : $postfix  ";
        my $content   = $LIST_MEM[$i][$j++]; say "\tcontent   : $content  ";
        my $type      = $LIST_MEM[$i][$j++]; say "\ttype      : $type     ";
        my $sizeMem   = $LIST_MEM[$i][$j++]; say "\tsizeMem   : $sizeMem  ";
        if ($sizeMem < 24) {
            next;
        }
        my $dataMemWd = $LIST_MEM[$i][$j++]; say "\tdataMemWd : $dataMemWd";
        my $flgFra    = $LIST_MEM[$i][$j++]; say "\tflgFra    : $flgFra   ";

        $path =~ /(.*)\/(\w*)/;
        my $location  = $1                 ; say "\tlocation  : $location ";
        my $module    = $2                 ; say "\tmodule    : $module   ";

        # wrapName
        my $wrapPath = "${location}/${module}/${module}_mem";
        my $wrapType;
        if ($type eq "fifo") {
            $wrapType = "fifo";
        }
        else {
            $wrapType = "ram";
        }
        my $wrapName;
        if ($content eq "") {
            $wrapName = "${wrapType}_${module}_${postfix}";
        }
        else {
            $wrapName = "${wrapType}_${module}_${postfix}_buf_${content}";
        }

        # instName
        my $instName;
        if ($content eq "") {
            $instName = uc("ram_${module}_${postfix}" . "_" . "${sizeMem}X${dataMemWd}");
        }
        else {
            $instName = uc("ram_${module}_${postfix}_buf_${content}" . "_" . "${sizeMem}X${dataMemWd}");
        }

        # create wrap
        if ($flgFra == 0) {
            system("cp wrap/${type}.v.template                  $wrapPath/${wrapName}.v;    \
                    sed -i \"s/example/$wrapName/g\"            $wrapPath/${wrapName}.v;    \
                    sed -i \"s/EXAMPLE/$instName/g\"            $wrapPath/${wrapName}.v;    \
            ");
        }
        else {
            system("cp wrap/${type}.v.template_for_frame_buffer $wrapPath/${wrapName}.v;    \
                    sed -i \"s/example/$wrapName/g\"            $wrapPath/${wrapName}.v;    \
                    sed -i \"s/EXAMPLE/$instName/g\"            $wrapPath/${wrapName}.v;    \
            ");
        }
        # !!! only non-fifo memories may have multi-banks.
        if ($type ne "fifo") {
            system("cp     wrap/${type}_multi_bank.v.template $wrapPath/${wrapName}_multi_bank.v;     \
                    sed -i \"s/example/$wrapName/g\"          $wrapPath/${wrapName}_multi_bank.v;     \
                    sed -i \"s/EXAMPLE/$instName/g\"          $wrapPath/${wrapName}_multi_bank.v;     \
            ");
        }

        # create GF_22_INST
        {
            my $instPath = "$PATH_PRJ/src/enc/enc_mem";
            my $instPref = "GF_22_INST";
            if ($flgFra) {
                system("touch $instPath/$instPref/${instPref}_${instName}_BNK_0.vh");
                system("touch $instPath/$instPref/${instPref}_${instName}_BNK_1.vh");
            }
            else {
                system("touch $instPath/$instPref/${instPref}_${instName}.vh");
            }
        }

        # create GF_28_INST
        {
            my $instPath = "$PATH_PRJ/src/enc/enc_mem";
            my $instPref = "GF_28_INST";
            if ($flgFra) {
                system("touch $instPath/$instPref/${instPref}_${instName}_BNK_0.vh");
                system("touch $instPath/$instPref/${instPref}_${instName}_BNK_1.vh");
            }
            else {
                system("touch $instPath/$instPref/${instPref}_${instName}.vh");
            }
        }

        # create GF_40_INST
        {
            my $instPath = "$PATH_PRJ/src/enc/enc_mem";
            my $instPref = "HL_40_INST";
            if ($flgFra) {
                system("touch $instPath/$instPref/${instPref}_${instName}_BNK_0.vh");
                system("touch $instPath/$instPref/${instPref}_${instName}_BNK_1.vh");
            }
            else {
                system("touch $instPath/$instPref/${instPref}_${instName}.vh");
            }
        }

        # create FPGA_INST
        {
            my $instPath = "$PATH_PRJ/src/enc/enc_mem";
            my $instPref = "FPGA_INST";
            my $instType;
            if ($type eq "sram_sp_behave") {
                $instType = "sram_sp";
            }
            elsif ($type eq "sram_sp_be_behave") {
                $instType = "sram_sp_be";
            }
            elsif ($type eq "sram_tp_behave") {
                $instType = "sram_tp";
            }
            elsif ($type eq "fifo") {
                $instType = "sram_tp";
            }
            if ($flgFra == 0) {
                system("cp     inst/${instPref}_${instType}.vh.template $instPath/$instPref/${instPref}_${instName}.vh;    \
                        sed -i \"s/example/${instPref}_${instName}/g\"  $instPath/$instPref/${instPref}_${instName}.vh;    \
                        cp     inst/${instPref}_${instType}.v.template  $instPath/$instPref/${instPref}_${instName}.v;     \
                        sed -i \"s/example/${instPref}_${instName}/g\"  $instPath/$instPref/${instPref}_${instName}.v;     \
                        sed -i \"s/size_col/1/g\"                       $instPath/$instPref/${instPref}_${instName}.v;     \
                        sed -i \"s/size/${sizeMem}/g\"                  $instPath/$instPref/${instPref}_${instName}.v;     \
                        sed -i \"s/data_wd/${dataMemWd}/g\"             $instPath/$instPref/${instPref}_${instName}.v;     \
                ");
            }
            else {
                for(my $i = 0; $i < 2; $i++) {
                    my $sizMemTrue;
                    if ($i == 0) {
                        $sizMemTrue = $sizeMem * $SIZE_FRA_X_MAX_BNK_0 / $SIZE_FRA_X_MAX;
                    }
                    else {
                        $sizMemTrue = $sizeMem * $SIZE_FRA_X_MAX_BNK_1 / $SIZE_FRA_X_MAX;
                    }
                    system("cp     inst/${instPref}_${instType}.vh.template         $instPath/$instPref/${instPref}_${instName}_BNK_${i}.vh;    \
                            sed -i \"s/example/${instPref}_${instName}_BNK_${i}/g\" $instPath/$instPref/${instPref}_${instName}_BNK_${i}.vh;    \
                            sed -i \"s/ adr_i/ adr_i[SIZE_BNK_ACTIVE_WD-'d1 :0]/\"  $instPath/$instPref/${instPref}_${instName}_BNK_${i}.vh;    \
                            cp     inst/${instPref}_${instType}.v.template          $instPath/$instPref/${instPref}_${instName}_BNK_${i}.v;     \
                            sed -i \"s/example/${instPref}_${instName}_BNK_${i}/g\" $instPath/$instPref/${instPref}_${instName}_BNK_${i}.v;     \
                            sed -i \"s/size_col/1/g\"                               $instPath/$instPref/${instPref}_${instName}_BNK_${i}.v;     \
                            sed -i \"s/size/${sizMemTrue}/g\"                       $instPath/$instPref/${instPref}_${instName}_BNK_${i}.v;     \
                            sed -i \"s/data_wd/${dataMemWd}/g\"                     $instPath/$instPref/${instPref}_${instName}_BNK_${i}.v;     \
                    ");
                }
            }
        }
    }
