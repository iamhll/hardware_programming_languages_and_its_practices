#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : collect.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : collect flow results
    #
#-------------------------------------------------------------------------------

#--- SIM -------------------------------
strDirLst=(
    vv_enc_rmd_top
    vv_enc_ime_top
    vv_enc_fme_top
    vv_enc_rdo_top
    vv_enc_ilf_top
    vv_enc_e_c_top
    vv_dec_e_d_top
    vv_enc_knl_top
    vv_enc_top
)

strDirTmp=temp
mkdir -p $strDirTmp
rm   -rf $strDirTmp/*
for strDir in ${strDirLst[*]}
do
    mkdir -p             $strDirTmp/$strDir/rpt
    cp ../$strDir/*.xlsx $strDirTmp/$strDir/rpt
done
