//------------------------------------------------------------------------------
    //
    //  Filename       : msc_cfg_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related codes (proc)
    //
//------------------------------------------------------------------------------
    //
    //  *** auto-generated, please do NOT modify it mannually ***
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_cfg.hpp"


//*** FUNCTION *****************************************************************
// msc_cfgRst
void msc_cfgRst(msc_cfg_t *cfg)
{
    // changeable
    cfg->idxFrame              = 0;
    cfg->idxUnitX              = 0;
    cfg->idxUnitY              = 0;

    // top
    cfg->strFileIn             = "/mnt/e/DOWNLOAD/SEQUENCE/HM/BasketballPass/BasketballPass.yuv";
    cfg->strFileOut            = "out.yuv";
    cfg->strPrefixDump         = "";
    cfg->strPrefixLoad         = "";
    cfg->numFrame              = 10;
    cfg->sizFrameX             = 416;
    cfg->sizFrameY             = 240;
    cfg->sizFrameZ             = 3;
    cfg->enmFormatIn           = 0;
    cfg->enmProc               = 0;
    cfg->enmInfo               = 2;
    cfg->enmLoad               = 0;
    cfg->enmDump               = 0;
    cfg->datSeed               = 0;
    cfg->sizUnitX              = 16;
    cfg->sizUnitY              = 16;

    // scaler
    cfg->sclFlgProc            = 1;
    cfg->sclNumTap             = 4;
    cfg->sclSizFrameX          = 548;
    cfg->sclSizFrameY          = 316;
    cfg->sclEnmMode            = 0;
    cfg->sclEnmLoad            = 0;
    cfg->sclEnmDump            = 0;
    cfg->sclDatThreshold2      = 0.5;
    cfg->sclDatThreshold4      = 128;

    // filter
    cfg->fltFlgProc            = 0;
    cfg->fltEnmLoad            = 0;
    cfg->fltEnmDump            = 0;
    cfg->fltDatCoe[0][0]       = 0;
    cfg->fltDatCoe[0][1]       = -1;
    cfg->fltDatCoe[0][2]       = 0;
    cfg->fltDatCoe[1][0]       = -1;
    cfg->fltDatCoe[1][1]       = 5;
    cfg->fltDatCoe[1][2]       = -1;
    cfg->fltDatCoe[2][0]       = 0;
    cfg->fltDatCoe[2][1]       = -1;
    cfg->fltDatCoe[2][2]       = 0;

    // on-screen-display
    cfg->osdFlgProc            = 0;
    cfg->osdStrFile0           = "/mnt/e/DOWNLOAD/SEQUENCE/HM/BasketballPass/BasketballPass.yuv";
    cfg->osdStrFile1           = "/mnt/e/DOWNLOAD/SEQUENCE/HM_AYUV1555/BasketballPass/BasketballPass.yuv";
    cfg->osdStrFile2           = "/mnt/e/DOWNLOAD/SEQUENCE/HM_INDX2/BasketballPass/BasketballPass.yuv";
    cfg->osdStrFile3           = "/mnt/e/DOWNLOAD/SEQUENCE/HM_INDX4/BasketballPass/BasketballPass.yuv";
    cfg->osdStrFile4           = "/mnt/e/DOWNLOAD/SEQUENCE/HM_ARGB1555/BasketballPass/BasketballPass.yuv";
    cfg->osdStrFile5           = "osd5.yuv";
    cfg->osdStrFile6           = "osd6.yuv";
    cfg->osdStrFile7           = "osd7.yuv";
    cfg->osdFlg[0]             = 0;
    cfg->osdFlg[1]             = 0;
    cfg->osdFlg[2]             = 0;
    cfg->osdFlg[3]             = 0;
    cfg->osdFlg[4]             = 0;
    cfg->osdFlg[5]             = 0;
    cfg->osdFlg[6]             = 0;
    cfg->osdFlg[7]             = 0;
    cfg->osdSizFrameX[0]       = 416;
    cfg->osdSizFrameX[1]       = 416;
    cfg->osdSizFrameX[2]       = 416;
    cfg->osdSizFrameX[3]       = 416;
    cfg->osdSizFrameX[4]       = 416;
    cfg->osdSizFrameX[5]       = 16;
    cfg->osdSizFrameX[6]       = 16;
    cfg->osdSizFrameX[7]       = 16;
    cfg->osdSizFrameY[0]       = 240;
    cfg->osdSizFrameY[1]       = 240;
    cfg->osdSizFrameY[2]       = 240;
    cfg->osdSizFrameY[3]       = 240;
    cfg->osdSizFrameY[4]       = 240;
    cfg->osdSizFrameY[5]       = 16;
    cfg->osdSizFrameY[6]       = 16;
    cfg->osdSizFrameY[7]       = 16;
    cfg->osdPosFrameX[0]       = 16;
    cfg->osdPosFrameX[1]       = 32;
    cfg->osdPosFrameX[2]       = 64;
    cfg->osdPosFrameX[3]       = 128;
    cfg->osdPosFrameX[4]       = 256;
    cfg->osdPosFrameX[5]       = 0;
    cfg->osdPosFrameX[6]       = 0;
    cfg->osdPosFrameX[7]       = 0;
    cfg->osdPosFrameY[0]       = 0;
    cfg->osdPosFrameY[1]       = 16;
    cfg->osdPosFrameY[2]       = 32;
    cfg->osdPosFrameY[3]       = 64;
    cfg->osdPosFrameY[4]       = 128;
    cfg->osdPosFrameY[5]       = 0;
    cfg->osdPosFrameY[6]       = 0;
    cfg->osdPosFrameY[7]       = 0;
    cfg->osdEnmLoad            = 0;
    cfg->osdEnmMode[0]         = 0;
    cfg->osdEnmMode[1]         = 1;
    cfg->osdEnmMode[2]         = 2;
    cfg->osdEnmMode[3]         = 3;
    cfg->osdEnmMode[4]         = 4;
    cfg->osdEnmMode[5]         = 0;
    cfg->osdEnmMode[6]         = 0;
    cfg->osdEnmMode[7]         = 0;
    cfg->osdEnmDump            = 0;
    cfg->osdDatScl[0][0]       = 1;
    cfg->osdDatScl[0][1]       = 1;
    cfg->osdDatScl[1][0]       = 1;
    cfg->osdDatScl[1][1]       = 1;
    cfg->osdDatScl[2][0]       = 1;
    cfg->osdDatScl[2][1]       = 1;
    cfg->osdDatScl[3][0]       = 1;
    cfg->osdDatScl[3][1]       = 1;
    cfg->osdDatScl[4][0]       = 1;
    cfg->osdDatScl[4][1]       = 1;
    cfg->osdDatScl[5][0]       = 1;
    cfg->osdDatScl[5][1]       = 1;
    cfg->osdDatScl[6][0]       = 1;
    cfg->osdDatScl[6][1]       = 1;
    cfg->osdDatScl[7][0]       = 1;
    cfg->osdDatScl[7][1]       = 1;
    cfg->osdDatLut0[0][0]      = 192;
    cfg->osdDatLut0[0][1]      = 81;
    cfg->osdDatLut0[0][2]      = 90;
    cfg->osdDatLut0[0][3]      = 240;
    cfg->osdDatLut0[1][0]      = 128;
    cfg->osdDatLut0[1][1]      = 145;
    cfg->osdDatLut0[1][2]      = 54;
    cfg->osdDatLut0[1][3]      = 34;
    cfg->osdDatLut0[2][0]      = 64;
    cfg->osdDatLut0[2][1]      = 41;
    cfg->osdDatLut0[2][2]      = 240;
    cfg->osdDatLut0[2][3]      = 110;
    cfg->osdDatLut0[3][0]      = 110;
    cfg->osdDatLut0[3][1]      = 53;
    cfg->osdDatLut0[3][2]      = 22;
    cfg->osdDatLut0[3][3]      = 127;
    cfg->osdDatLut1[0][0]      = 192;
    cfg->osdDatLut1[0][1]      = 81;
    cfg->osdDatLut1[0][2]      = 90;
    cfg->osdDatLut1[0][3]      = 240;
    cfg->osdDatLut1[1][0]      = 128;
    cfg->osdDatLut1[1][1]      = 145;
    cfg->osdDatLut1[1][2]      = 54;
    cfg->osdDatLut1[1][3]      = 34;
    cfg->osdDatLut1[2][0]      = 64;
    cfg->osdDatLut1[2][1]      = 41;
    cfg->osdDatLut1[2][2]      = 240;
    cfg->osdDatLut1[2][3]      = 110;
    cfg->osdDatLut1[3][0]      = 110;
    cfg->osdDatLut1[3][1]      = 53;
    cfg->osdDatLut1[3][2]      = 22;
    cfg->osdDatLut1[3][3]      = 127;
    cfg->osdDatLut2[0][0]      = 192;
    cfg->osdDatLut2[0][1]      = 81;
    cfg->osdDatLut2[0][2]      = 90;
    cfg->osdDatLut2[0][3]      = 240;
    cfg->osdDatLut2[1][0]      = 128;
    cfg->osdDatLut2[1][1]      = 145;
    cfg->osdDatLut2[1][2]      = 54;
    cfg->osdDatLut2[1][3]      = 34;
    cfg->osdDatLut2[2][0]      = 64;
    cfg->osdDatLut2[2][1]      = 41;
    cfg->osdDatLut2[2][2]      = 240;
    cfg->osdDatLut2[2][3]      = 110;
    cfg->osdDatLut2[3][0]      = 110;
    cfg->osdDatLut2[3][1]      = 53;
    cfg->osdDatLut2[3][2]      = 22;
    cfg->osdDatLut2[3][3]      = 127;
    cfg->osdDatLut3[0][0]      = 192;
    cfg->osdDatLut3[0][1]      = 81;
    cfg->osdDatLut3[0][2]      = 90;
    cfg->osdDatLut3[0][3]      = 240;
    cfg->osdDatLut3[1][0]      = 128;
    cfg->osdDatLut3[1][1]      = 145;
    cfg->osdDatLut3[1][2]      = 54;
    cfg->osdDatLut3[1][3]      = 34;
    cfg->osdDatLut3[2][0]      = 64;
    cfg->osdDatLut3[2][1]      = 41;
    cfg->osdDatLut3[2][2]      = 240;
    cfg->osdDatLut3[2][3]      = 110;
    cfg->osdDatLut3[3][0]      = 110;
    cfg->osdDatLut3[3][1]      = 53;
    cfg->osdDatLut3[3][2]      = 22;
    cfg->osdDatLut3[3][3]      = 127;
    cfg->osdDatLut4[0][0]      = 192;
    cfg->osdDatLut4[0][1]      = 81;
    cfg->osdDatLut4[0][2]      = 90;
    cfg->osdDatLut4[0][3]      = 240;
    cfg->osdDatLut4[1][0]      = 128;
    cfg->osdDatLut4[1][1]      = 145;
    cfg->osdDatLut4[1][2]      = 54;
    cfg->osdDatLut4[1][3]      = 34;
    cfg->osdDatLut4[2][0]      = 64;
    cfg->osdDatLut4[2][1]      = 41;
    cfg->osdDatLut4[2][2]      = 240;
    cfg->osdDatLut4[2][3]      = 110;
    cfg->osdDatLut4[3][0]      = 110;
    cfg->osdDatLut4[3][1]      = 53;
    cfg->osdDatLut4[3][2]      = 22;
    cfg->osdDatLut4[3][3]      = 127;
    cfg->osdDatLut5[0][0]      = 0;
    cfg->osdDatLut5[0][1]      = 0;
    cfg->osdDatLut5[0][2]      = 0;
    cfg->osdDatLut5[0][3]      = 0;
    cfg->osdDatLut5[1][0]      = 0;
    cfg->osdDatLut5[1][1]      = 0;
    cfg->osdDatLut5[1][2]      = 0;
    cfg->osdDatLut5[1][3]      = 0;
    cfg->osdDatLut5[2][0]      = 0;
    cfg->osdDatLut5[2][1]      = 0;
    cfg->osdDatLut5[2][2]      = 0;
    cfg->osdDatLut5[2][3]      = 0;
    cfg->osdDatLut5[3][0]      = 0;
    cfg->osdDatLut5[3][1]      = 0;
    cfg->osdDatLut5[3][2]      = 0;
    cfg->osdDatLut5[3][3]      = 0;
    cfg->osdDatLut6[0][0]      = 0;
    cfg->osdDatLut6[0][1]      = 0;
    cfg->osdDatLut6[0][2]      = 0;
    cfg->osdDatLut6[0][3]      = 0;
    cfg->osdDatLut6[1][0]      = 0;
    cfg->osdDatLut6[1][1]      = 0;
    cfg->osdDatLut6[1][2]      = 0;
    cfg->osdDatLut6[1][3]      = 0;
    cfg->osdDatLut6[2][0]      = 0;
    cfg->osdDatLut6[2][1]      = 0;
    cfg->osdDatLut6[2][2]      = 0;
    cfg->osdDatLut6[2][3]      = 0;
    cfg->osdDatLut6[3][0]      = 0;
    cfg->osdDatLut6[3][1]      = 0;
    cfg->osdDatLut6[3][2]      = 0;
    cfg->osdDatLut6[3][3]      = 0;
    cfg->osdDatLut7[0][0]      = 0;
    cfg->osdDatLut7[0][1]      = 0;
    cfg->osdDatLut7[0][2]      = 0;
    cfg->osdDatLut7[0][3]      = 0;
    cfg->osdDatLut7[1][0]      = 0;
    cfg->osdDatLut7[1][1]      = 0;
    cfg->osdDatLut7[1][2]      = 0;
    cfg->osdDatLut7[1][3]      = 0;
    cfg->osdDatLut7[2][0]      = 0;
    cfg->osdDatLut7[2][1]      = 0;
    cfg->osdDatLut7[2][2]      = 0;
    cfg->osdDatLut7[2][3]      = 0;
    cfg->osdDatLut7[3][0]      = 0;
    cfg->osdDatLut7[3][1]      = 0;
    cfg->osdDatLut7[3][2]      = 0;
    cfg->osdDatLut7[3][3]      = 0;

    // example
    cfg->exampleDatInt         = 0;
    cfg->exampleDatDouble      = 0;
    cfg->exampleDatVector[0]   = 0;
    cfg->exampleDatVector[1]   = 0;
    cfg->exampleDatArray[0][0] = 0;
    cfg->exampleDatArray[0][1] = 0;
    cfg->exampleDatArray[0][2] = 0;
    cfg->exampleDatArray[1][0] = 0;
    cfg->exampleDatArray[1][1] = 0;
    cfg->exampleDatArray[1][2] = 0;

    // derived
    cfg->numUnitX              = 0;
    cfg->numUnitY              = 0;
    cfg->datScalerX            = 0;
    cfg->datScalerY            = 0;
    cfg->sclDatThreshold2Inv   = 0;
}

// msc_cfgHlp
void msc_cfgHlp(
msc_cfg_t *cfg)
{
    cout << endl;
    cout << "[virtual]" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    strFileCfg             location of the configuration file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    help                   to print help information" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    show                   to show configuration value" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    dryRun                 to check input without running" << endl;
    cout << endl;
    cout << "[top]" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    strFileIn              full location of the input file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    strFileOut             full location of the output file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    strPrefixDump          dump prefix for debug data" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED) cout << "    strPrefixLoad          load prefix for debug data" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    numFrame               number of the frames to be processed" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sizFrameX              size of frames in 1st dimension" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sizFrameY              size of frames in 2nd dimension" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sizFrameZ              size of frames in 3rd dimension" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    enmFormatIn            enumerator for input format (<value> 0: yuv420p 1: nv12)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    enmProc                enumerator for processing behavior (<value> 0: software 1: hardware)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    enmInfo                enumerator for information level (<value> 0: none 1: system 2: top 3: module 4: common)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    enmLoad                enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    enmDump                enumerator for dump level (<value> 0: none 1: inout 2: intermediate)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    datSeed                value of random seed" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sizUnitX               size of units' 1st dimension" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sizUnitY               size of units' 2nd dimension" << endl;
    cout << endl;
    cout << "[scaler]" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclFlgProc             enable flag for processing" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclNumTap              number of filter tap (<value> 0: 2 1: 4)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclSizFrameX           size of frames in 1st dimension" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclSizFrameY           size of frames in 2nd dimension" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclEnmMode             enumerator for mode (<value> 0: bilinear 1: bicubic)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclEnmLoad             enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclEnmDump             enumerator for dump level (<value> 0: none 1: inout 2: intermediate)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclDatThreshold2       threshold for 2-tap filter" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    sclDatThreshold4       threshold for 4-tap filter" << endl;
    cout << endl;
    cout << "[filter]" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    fltFlgProc             enable flag for processing" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    fltEnmLoad             enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    fltEnmDump             enumerator for dump level (<value> 0: none 1: inout 2: intermediate)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    fltDatCoe              coefficient data (<index> Y(0/1/2)~X(0/1/2): value of the coefficient positioned at Y(-1/0/1)~X(-1/0/1))" << endl;
    cout << endl;
    cout << "[on-screen-display]" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdFlgProc             enable flag for processing" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile0            location of the 0th OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile1            location of the 1st OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile2            location of the 2nd OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile3            location of the 3rd OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile4            location of the 4th OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile5            location of the 5th OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile6            location of the 6th OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdStrFile7            location of the 7th OSD file" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdFlg                 enable flags for OSD (<index> N: the Nth OSD)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdSizFrameX           size of OSD frames in 1st dimension (<index> N: the Nth OSD)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdSizFrameY           size of OSD frames in 2nd dimension (<index> N: the Nth OSD)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdPosFrameX           position of OSD frames in 1st dimension (<index> N: the Nth OSD)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdPosFrameY           position of OSD frames in 2nd dimension (<index> N: the Nth OSD)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdEnmLoad             enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdEnmMode             enumerator for work mode (<index> N: the Nth OSD) (<value> 0: YUV420; 1: AYUV1555; 2: index 2; 3: index 4; 4: ARGB1555)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdEnmDump             enumerator for dump level (<value> 0: none 1: inout 2: intermediate)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatScl              scaler data (<index> N-A(0/1): axis A(X/Y) of the Nth OSD)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut0             data of 0th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut1             data of the 1st OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut2             data of the 2nd OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut3             data of the 3rd OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut4             data of the 4th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut5             data of the 5th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut6             data of the 6th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   ) cout << "    osdDatLut7             data of the 7th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)" << endl;
    cout << endl;
    cout << "[example]" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED) cout << "    exampleDatInt          an example for int (scalar)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED) cout << "    exampleDatDouble       an example for double (scalar)" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED) cout << "    exampleDatVector       an example for (int) vector" << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED) cout << "    exampleDatArray        an example for (int) array" << endl;
}

// msc_cfgMap
void msc_cfgMap(msc_cfg_t *cfg,
const string *strKey, const string *strDat)
{
    // variables
    const char *datAsCStr   = strDat->data();
    int         datAsInt    = atoi(strDat->data());
    double      datAsDouble = atof(strDat->data());
    bool        datAsBool   = datAsInt ? true : false;

    // mapping
    if      (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--strFileIn"          || *strKey == "-i"))    cfg->strFileIn             = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--strFileOut"         || *strKey == "-o"))    cfg->strFileOut            = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--strPrefixDump"                        ))    cfg->strPrefixDump         = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--strPrefixLoad"                        ))    cfg->strPrefixLoad         = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--numFrame"                             ))    cfg->numFrame              = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizFrameX"                            ))    cfg->sizFrameX             = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizFrameY"                            ))    cfg->sizFrameY             = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizFrameZ"                            ))    cfg->sizFrameZ             = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmFormatIn"                          ))    cfg->enmFormatIn           = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmProc"                              ))    cfg->enmProc               = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmInfo"                              ))    cfg->enmInfo               = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmLoad"                              ))    cfg->enmLoad               = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmDump"                              ))    cfg->enmDump               = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--datSeed"            || *strKey == "-r"))    cfg->datSeed               = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizUnitX"                             ))    cfg->sizUnitX              = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizUnitY"                             ))    cfg->sizUnitY              = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclFlgProc"                           ))    cfg->sclFlgProc            = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclNumTap"                            ))    cfg->sclNumTap             = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclSizFrameX"                         ))    cfg->sclSizFrameX          = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclSizFrameY"                         ))    cfg->sclSizFrameY          = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclEnmMode"                           ))    cfg->sclEnmMode            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclEnmLoad"                           ))    cfg->sclEnmLoad            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclEnmDump"                           ))    cfg->sclEnmDump            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclDatThreshold2"                     ))    cfg->sclDatThreshold2      = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--sclDatThreshold4"                     ))    cfg->sclDatThreshold4      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltFlgProc"                           ))    cfg->fltFlgProc            = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltEnmLoad"                           ))    cfg->fltEnmLoad            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltEnmDump"                           ))    cfg->fltEnmDump            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_0_0"                        ))    cfg->fltDatCoe[0][0]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_0_1"                        ))    cfg->fltDatCoe[0][1]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_0_2"                        ))    cfg->fltDatCoe[0][2]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_1_0"                        ))    cfg->fltDatCoe[1][0]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_1_1"                        ))    cfg->fltDatCoe[1][1]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_1_2"                        ))    cfg->fltDatCoe[1][2]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_2_0"                        ))    cfg->fltDatCoe[2][0]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_2_1"                        ))    cfg->fltDatCoe[2][1]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--fltDatCoe_2_2"                        ))    cfg->fltDatCoe[2][2]       = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlgProc"                           ))    cfg->osdFlgProc            = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile0"        || *strKey == "-i"))    cfg->osdStrFile0           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile1"        || *strKey == "-i"))    cfg->osdStrFile1           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile2"        || *strKey == "-i"))    cfg->osdStrFile2           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile3"        || *strKey == "-i"))    cfg->osdStrFile3           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile4"        || *strKey == "-i"))    cfg->osdStrFile4           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile5"        || *strKey == "-i"))    cfg->osdStrFile5           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile6"        || *strKey == "-i"))    cfg->osdStrFile6           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdStrFile7"        || *strKey == "-i"))    cfg->osdStrFile7           = datAsCStr;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_0"                             ))    cfg->osdFlg[0]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_1"                             ))    cfg->osdFlg[1]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_2"                             ))    cfg->osdFlg[2]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_3"                             ))    cfg->osdFlg[3]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_4"                             ))    cfg->osdFlg[4]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_5"                             ))    cfg->osdFlg[5]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_6"                             ))    cfg->osdFlg[6]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdFlg_7"                             ))    cfg->osdFlg[7]             = datAsBool;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_0"                       ))    cfg->osdSizFrameX[0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_1"                       ))    cfg->osdSizFrameX[1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_2"                       ))    cfg->osdSizFrameX[2]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_3"                       ))    cfg->osdSizFrameX[3]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_4"                       ))    cfg->osdSizFrameX[4]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_5"                       ))    cfg->osdSizFrameX[5]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_6"                       ))    cfg->osdSizFrameX[6]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameX_7"                       ))    cfg->osdSizFrameX[7]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_0"                       ))    cfg->osdSizFrameY[0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_1"                       ))    cfg->osdSizFrameY[1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_2"                       ))    cfg->osdSizFrameY[2]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_3"                       ))    cfg->osdSizFrameY[3]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_4"                       ))    cfg->osdSizFrameY[4]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_5"                       ))    cfg->osdSizFrameY[5]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_6"                       ))    cfg->osdSizFrameY[6]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdSizFrameY_7"                       ))    cfg->osdSizFrameY[7]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_0"                       ))    cfg->osdPosFrameX[0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_1"                       ))    cfg->osdPosFrameX[1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_2"                       ))    cfg->osdPosFrameX[2]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_3"                       ))    cfg->osdPosFrameX[3]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_4"                       ))    cfg->osdPosFrameX[4]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_5"                       ))    cfg->osdPosFrameX[5]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_6"                       ))    cfg->osdPosFrameX[6]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameX_7"                       ))    cfg->osdPosFrameX[7]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_0"                       ))    cfg->osdPosFrameY[0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_1"                       ))    cfg->osdPosFrameY[1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_2"                       ))    cfg->osdPosFrameY[2]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_3"                       ))    cfg->osdPosFrameY[3]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_4"                       ))    cfg->osdPosFrameY[4]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_5"                       ))    cfg->osdPosFrameY[5]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_6"                       ))    cfg->osdPosFrameY[6]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdPosFrameY_7"                       ))    cfg->osdPosFrameY[7]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmLoad"                           ))    cfg->osdEnmLoad            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_0"                         ))    cfg->osdEnmMode[0]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_1"                         ))    cfg->osdEnmMode[1]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_2"                         ))    cfg->osdEnmMode[2]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_3"                         ))    cfg->osdEnmMode[3]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_4"                         ))    cfg->osdEnmMode[4]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_5"                         ))    cfg->osdEnmMode[5]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_6"                         ))    cfg->osdEnmMode[6]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmMode_7"                         ))    cfg->osdEnmMode[7]         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdEnmDump"                           ))    cfg->osdEnmDump            = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_0_0"                        ))    cfg->osdDatScl[0][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_0_1"                        ))    cfg->osdDatScl[0][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_1_0"                        ))    cfg->osdDatScl[1][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_1_1"                        ))    cfg->osdDatScl[1][1]       = datAsInt;
    if      (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_2_0"                        ))    cfg->osdDatScl[2][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_2_1"                        ))    cfg->osdDatScl[2][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_3_0"                        ))    cfg->osdDatScl[3][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_3_1"                        ))    cfg->osdDatScl[3][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_4_0"                        ))    cfg->osdDatScl[4][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_4_1"                        ))    cfg->osdDatScl[4][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_5_0"                        ))    cfg->osdDatScl[5][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_5_1"                        ))    cfg->osdDatScl[5][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_6_0"                        ))    cfg->osdDatScl[6][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_6_1"                        ))    cfg->osdDatScl[6][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_7_0"                        ))    cfg->osdDatScl[7][0]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatScl_7_1"                        ))    cfg->osdDatScl[7][1]       = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_0_0"                       ))    cfg->osdDatLut0[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_0_1"                       ))    cfg->osdDatLut0[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_0_2"                       ))    cfg->osdDatLut0[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_0_3"                       ))    cfg->osdDatLut0[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_1_0"                       ))    cfg->osdDatLut0[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_1_1"                       ))    cfg->osdDatLut0[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_1_2"                       ))    cfg->osdDatLut0[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_1_3"                       ))    cfg->osdDatLut0[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_2_0"                       ))    cfg->osdDatLut0[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_2_1"                       ))    cfg->osdDatLut0[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_2_2"                       ))    cfg->osdDatLut0[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_2_3"                       ))    cfg->osdDatLut0[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_3_0"                       ))    cfg->osdDatLut0[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_3_1"                       ))    cfg->osdDatLut0[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_3_2"                       ))    cfg->osdDatLut0[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut0_3_3"                       ))    cfg->osdDatLut0[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_0_0"                       ))    cfg->osdDatLut1[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_0_1"                       ))    cfg->osdDatLut1[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_0_2"                       ))    cfg->osdDatLut1[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_0_3"                       ))    cfg->osdDatLut1[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_1_0"                       ))    cfg->osdDatLut1[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_1_1"                       ))    cfg->osdDatLut1[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_1_2"                       ))    cfg->osdDatLut1[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_1_3"                       ))    cfg->osdDatLut1[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_2_0"                       ))    cfg->osdDatLut1[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_2_1"                       ))    cfg->osdDatLut1[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_2_2"                       ))    cfg->osdDatLut1[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_2_3"                       ))    cfg->osdDatLut1[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_3_0"                       ))    cfg->osdDatLut1[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_3_1"                       ))    cfg->osdDatLut1[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_3_2"                       ))    cfg->osdDatLut1[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut1_3_3"                       ))    cfg->osdDatLut1[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_0_0"                       ))    cfg->osdDatLut2[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_0_1"                       ))    cfg->osdDatLut2[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_0_2"                       ))    cfg->osdDatLut2[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_0_3"                       ))    cfg->osdDatLut2[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_1_0"                       ))    cfg->osdDatLut2[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_1_1"                       ))    cfg->osdDatLut2[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_1_2"                       ))    cfg->osdDatLut2[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_1_3"                       ))    cfg->osdDatLut2[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_2_0"                       ))    cfg->osdDatLut2[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_2_1"                       ))    cfg->osdDatLut2[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_2_2"                       ))    cfg->osdDatLut2[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_2_3"                       ))    cfg->osdDatLut2[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_3_0"                       ))    cfg->osdDatLut2[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_3_1"                       ))    cfg->osdDatLut2[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_3_2"                       ))    cfg->osdDatLut2[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut2_3_3"                       ))    cfg->osdDatLut2[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_0_0"                       ))    cfg->osdDatLut3[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_0_1"                       ))    cfg->osdDatLut3[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_0_2"                       ))    cfg->osdDatLut3[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_0_3"                       ))    cfg->osdDatLut3[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_1_0"                       ))    cfg->osdDatLut3[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_1_1"                       ))    cfg->osdDatLut3[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_1_2"                       ))    cfg->osdDatLut3[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_1_3"                       ))    cfg->osdDatLut3[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_2_0"                       ))    cfg->osdDatLut3[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_2_1"                       ))    cfg->osdDatLut3[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_2_2"                       ))    cfg->osdDatLut3[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_2_3"                       ))    cfg->osdDatLut3[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_3_0"                       ))    cfg->osdDatLut3[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_3_1"                       ))    cfg->osdDatLut3[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_3_2"                       ))    cfg->osdDatLut3[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut3_3_3"                       ))    cfg->osdDatLut3[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_0_0"                       ))    cfg->osdDatLut4[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_0_1"                       ))    cfg->osdDatLut4[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_0_2"                       ))    cfg->osdDatLut4[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_0_3"                       ))    cfg->osdDatLut4[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_1_0"                       ))    cfg->osdDatLut4[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_1_1"                       ))    cfg->osdDatLut4[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_1_2"                       ))    cfg->osdDatLut4[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_1_3"                       ))    cfg->osdDatLut4[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_2_0"                       ))    cfg->osdDatLut4[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_2_1"                       ))    cfg->osdDatLut4[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_2_2"                       ))    cfg->osdDatLut4[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_2_3"                       ))    cfg->osdDatLut4[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_3_0"                       ))    cfg->osdDatLut4[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_3_1"                       ))    cfg->osdDatLut4[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_3_2"                       ))    cfg->osdDatLut4[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut4_3_3"                       ))    cfg->osdDatLut4[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_0_0"                       ))    cfg->osdDatLut5[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_0_1"                       ))    cfg->osdDatLut5[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_0_2"                       ))    cfg->osdDatLut5[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_0_3"                       ))    cfg->osdDatLut5[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_1_0"                       ))    cfg->osdDatLut5[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_1_1"                       ))    cfg->osdDatLut5[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_1_2"                       ))    cfg->osdDatLut5[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_1_3"                       ))    cfg->osdDatLut5[1][3]      = datAsInt;
    if      (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_2_0"                       ))    cfg->osdDatLut5[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_2_1"                       ))    cfg->osdDatLut5[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_2_2"                       ))    cfg->osdDatLut5[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_2_3"                       ))    cfg->osdDatLut5[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_3_0"                       ))    cfg->osdDatLut5[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_3_1"                       ))    cfg->osdDatLut5[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_3_2"                       ))    cfg->osdDatLut5[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut5_3_3"                       ))    cfg->osdDatLut5[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_0_0"                       ))    cfg->osdDatLut6[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_0_1"                       ))    cfg->osdDatLut6[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_0_2"                       ))    cfg->osdDatLut6[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_0_3"                       ))    cfg->osdDatLut6[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_1_0"                       ))    cfg->osdDatLut6[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_1_1"                       ))    cfg->osdDatLut6[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_1_2"                       ))    cfg->osdDatLut6[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_1_3"                       ))    cfg->osdDatLut6[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_2_0"                       ))    cfg->osdDatLut6[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_2_1"                       ))    cfg->osdDatLut6[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_2_2"                       ))    cfg->osdDatLut6[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_2_3"                       ))    cfg->osdDatLut6[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_3_0"                       ))    cfg->osdDatLut6[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_3_1"                       ))    cfg->osdDatLut6[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_3_2"                       ))    cfg->osdDatLut6[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut6_3_3"                       ))    cfg->osdDatLut6[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_0_0"                       ))    cfg->osdDatLut7[0][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_0_1"                       ))    cfg->osdDatLut7[0][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_0_2"                       ))    cfg->osdDatLut7[0][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_0_3"                       ))    cfg->osdDatLut7[0][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_1_0"                       ))    cfg->osdDatLut7[1][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_1_1"                       ))    cfg->osdDatLut7[1][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_1_2"                       ))    cfg->osdDatLut7[1][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_1_3"                       ))    cfg->osdDatLut7[1][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_2_0"                       ))    cfg->osdDatLut7[2][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_2_1"                       ))    cfg->osdDatLut7[2][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_2_2"                       ))    cfg->osdDatLut7[2][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_2_3"                       ))    cfg->osdDatLut7[2][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_3_0"                       ))    cfg->osdDatLut7[3][0]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_3_1"                       ))    cfg->osdDatLut7[3][1]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_3_2"                       ))    cfg->osdDatLut7[3][2]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH    && (*strKey == "--osdDatLut7_3_3"                       ))    cfg->osdDatLut7[3][3]      = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatInt"                        ))    cfg->exampleDatInt         = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatDouble"                     ))    cfg->exampleDatDouble      = datAsDouble;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatVector_0"                   ))    cfg->exampleDatVector[0]   = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatVector_1"                   ))    cfg->exampleDatVector[1]   = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_0_0"                  ))    cfg->exampleDatArray[0][0] = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_0_1"                  ))    cfg->exampleDatArray[0][1] = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_0_2"                  ))    cfg->exampleDatArray[0][2] = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_1_0"                  ))    cfg->exampleDatArray[1][0] = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_1_1"                  ))    cfg->exampleDatArray[1][1] = datAsInt;
    else if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_1_2"                  ))    cfg->exampleDatArray[1][2] = datAsInt;
}

// msc_cfgL2X
void msc_cfgL2X(msc_cfg_t *cfg)
{
    cfg->sclDatThreshold2 = msc_getDatRound(cfg->sclDatThreshold2, 8);
    cfg->fltDatCoe[0][0] = msc_getDatRound(cfg->fltDatCoe[0][0], 4);
    cfg->fltDatCoe[0][1] = msc_getDatRound(cfg->fltDatCoe[0][1], 4);
    cfg->fltDatCoe[0][2] = msc_getDatRound(cfg->fltDatCoe[0][2], 4);
    cfg->fltDatCoe[1][0] = msc_getDatRound(cfg->fltDatCoe[1][0], 4);
    cfg->fltDatCoe[1][1] = msc_getDatRound(cfg->fltDatCoe[1][1], 4);
    cfg->fltDatCoe[1][2] = msc_getDatRound(cfg->fltDatCoe[1][2], 4);
    cfg->fltDatCoe[2][0] = msc_getDatRound(cfg->fltDatCoe[2][0], 4);
    cfg->fltDatCoe[2][1] = msc_getDatRound(cfg->fltDatCoe[2][1], 4);
    cfg->fltDatCoe[2][2] = msc_getDatRound(cfg->fltDatCoe[2][2], 4);
    cfg->exampleDatDouble = msc_getDatRound(cfg->exampleDatDouble, 8);
    cfg->datScalerX = msc_getDatRound(cfg->datScalerX, 16);
    cfg->datScalerY = msc_getDatRound(cfg->datScalerY, 16);
    cfg->sclDatThreshold2Inv = msc_getDatRound(cfg->sclDatThreshold2Inv, 8);
}

// msc_cfgChk
int  msc_cfgChk(
msc_cfg_t *cfg)
{
    if (cfg->sizFrameX < 1 || cfg->sizFrameX > 4096) {
        cerr << "[error from c model] cfg->sizFrameX should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->sizFrameY < 1 || cfg->sizFrameY > 4096) {
        cerr << "[error from c model] cfg->sizFrameY should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->sizFrameZ < 1 || cfg->sizFrameZ > 3) {
        cerr << "[error from c model] cfg->sizFrameZ should be within [1,3]!" << endl;
        return 1;
    };
    if (cfg->enmFormatIn < 0 || cfg->enmFormatIn > 1) {
        cerr << "[error from c model] cfg->enmFormatIn should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->enmProc < 0 || cfg->enmProc > 1) {
        cerr << "[error from c model] cfg->enmProc should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->enmInfo < 0 || cfg->enmInfo > 4) {
        cerr << "[error from c model] cfg->enmInfo should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->enmLoad < 0 || cfg->enmLoad > 2) {
        cerr << "[error from c model] cfg->enmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->enmDump < 0 || cfg->enmDump > 2) {
        cerr << "[error from c model] cfg->enmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->sizUnitX < 1 || cfg->sizUnitX > 64) {
        cerr << "[error from c model] cfg->sizUnitX should be within [1,64]!" << endl;
        return 1;
    };
    if (cfg->sizUnitY < 1 || cfg->sizUnitY > 64) {
        cerr << "[error from c model] cfg->sizUnitY should be within [1,64]!" << endl;
        return 1;
    };
    if (cfg->sclNumTap < 2 || cfg->sclNumTap > 4) {
        cerr << "[error from c model] cfg->sclNumTap should be within [2,4]!" << endl;
        return 1;
    };
    if (cfg->sclSizFrameX < 1 || cfg->sclSizFrameX > 8192) {
        cerr << "[error from c model] cfg->sclSizFrameX should be within [1,8192]!" << endl;
        return 1;
    };
    if (cfg->sclSizFrameY < 1 || cfg->sclSizFrameY > 8192) {
        cerr << "[error from c model] cfg->sclSizFrameY should be within [1,8192]!" << endl;
        return 1;
    };
    if (cfg->sclEnmMode < 0 || cfg->sclEnmMode > 1) {
        cerr << "[error from c model] cfg->sclEnmMode should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->sclEnmLoad < 0 || cfg->sclEnmLoad > 2) {
        cerr << "[error from c model] cfg->sclEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->sclEnmDump < 0 || cfg->sclEnmDump > 2) {
        cerr << "[error from c model] cfg->sclEnmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->sclDatThreshold2 < 0 || cfg->sclDatThreshold2 > 1) {
        cerr << "[error from c model] cfg->sclDatThreshold2 should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->sclDatThreshold4 < 0 || cfg->sclDatThreshold4 > 255) {
        cerr << "[error from c model] cfg->sclDatThreshold4 should be within [0,255]!" << endl;
        return 1;
    };
    if (cfg->fltEnmLoad < 0 || cfg->fltEnmLoad > 2) {
        cerr << "[error from c model] cfg->fltEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->fltEnmDump < 0 || cfg->fltEnmDump > 2) {
        cerr << "[error from c model] cfg->fltEnmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[0][0] < -16 || cfg->fltDatCoe[0][0] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[0][0] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[0][1] < -16 || cfg->fltDatCoe[0][1] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[0][1] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[0][2] < -16 || cfg->fltDatCoe[0][2] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[0][2] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[1][0] < -16 || cfg->fltDatCoe[1][0] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[1][0] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[1][1] < -16 || cfg->fltDatCoe[1][1] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[1][1] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[1][2] < -16 || cfg->fltDatCoe[1][2] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[1][2] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[2][0] < -16 || cfg->fltDatCoe[2][0] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[2][0] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[2][1] < -16 || cfg->fltDatCoe[2][1] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[2][1] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->fltDatCoe[2][2] < -16 || cfg->fltDatCoe[2][2] > 15.9375) {
        cerr << "[error from c model] cfg->fltDatCoe[2][2] should be within [-16,15.9375]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[0] < 1 || cfg->osdSizFrameX[0] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[0] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[1] < 1 || cfg->osdSizFrameX[1] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[1] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[2] < 1 || cfg->osdSizFrameX[2] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[2] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[3] < 1 || cfg->osdSizFrameX[3] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[3] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[4] < 1 || cfg->osdSizFrameX[4] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[4] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[5] < 1 || cfg->osdSizFrameX[5] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[5] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[6] < 1 || cfg->osdSizFrameX[6] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[6] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameX[7] < 1 || cfg->osdSizFrameX[7] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameX[7] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[0] < 1 || cfg->osdSizFrameY[0] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[0] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[1] < 1 || cfg->osdSizFrameY[1] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[1] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[2] < 1 || cfg->osdSizFrameY[2] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[2] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[3] < 1 || cfg->osdSizFrameY[3] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[3] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[4] < 1 || cfg->osdSizFrameY[4] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[4] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[5] < 1 || cfg->osdSizFrameY[5] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[5] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[6] < 1 || cfg->osdSizFrameY[6] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[6] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdSizFrameY[7] < 1 || cfg->osdSizFrameY[7] > 4096) {
        cerr << "[error from c model] cfg->osdSizFrameY[7] should be within [1,4096]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[0] < 0 || cfg->osdPosFrameX[0] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[0] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[1] < 0 || cfg->osdPosFrameX[1] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[1] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[2] < 0 || cfg->osdPosFrameX[2] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[2] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[3] < 0 || cfg->osdPosFrameX[3] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[3] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[4] < 0 || cfg->osdPosFrameX[4] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[4] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[5] < 0 || cfg->osdPosFrameX[5] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[5] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[6] < 0 || cfg->osdPosFrameX[6] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[6] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameX[7] < 0 || cfg->osdPosFrameX[7] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameX[7] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[0] < 0 || cfg->osdPosFrameY[0] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[0] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[1] < 0 || cfg->osdPosFrameY[1] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[1] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[2] < 0 || cfg->osdPosFrameY[2] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[2] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[3] < 0 || cfg->osdPosFrameY[3] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[3] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[4] < 0 || cfg->osdPosFrameY[4] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[4] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[5] < 0 || cfg->osdPosFrameY[5] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[5] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[6] < 0 || cfg->osdPosFrameY[6] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[6] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdPosFrameY[7] < 0 || cfg->osdPosFrameY[7] > 4095) {
        cerr << "[error from c model] cfg->osdPosFrameY[7] should be within [0,4095]!" << endl;
        return 1;
    };
    if (cfg->osdEnmLoad < 0 || cfg->osdEnmLoad > 2) {
        cerr << "[error from c model] cfg->osdEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[0] < 0 || cfg->osdEnmMode[0] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[0] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[1] < 0 || cfg->osdEnmMode[1] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[1] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[2] < 0 || cfg->osdEnmMode[2] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[2] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[3] < 0 || cfg->osdEnmMode[3] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[3] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[4] < 0 || cfg->osdEnmMode[4] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[4] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[5] < 0 || cfg->osdEnmMode[5] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[5] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[6] < 0 || cfg->osdEnmMode[6] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[6] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmMode[7] < 0 || cfg->osdEnmMode[7] > 4) {
        cerr << "[error from c model] cfg->osdEnmMode[7] should be within [0,4]!" << endl;
        return 1;
    };
    if (cfg->osdEnmDump < 0 || cfg->osdEnmDump > 2) {
        cerr << "[error from c model] cfg->osdEnmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[0][0] < 1 || cfg->osdDatScl[0][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[0][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[0][1] < 1 || cfg->osdDatScl[0][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[0][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[1][0] < 1 || cfg->osdDatScl[1][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[1][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[1][1] < 1 || cfg->osdDatScl[1][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[1][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[2][0] < 1 || cfg->osdDatScl[2][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[2][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[2][1] < 1 || cfg->osdDatScl[2][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[2][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[3][0] < 1 || cfg->osdDatScl[3][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[3][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[3][1] < 1 || cfg->osdDatScl[3][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[3][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[4][0] < 1 || cfg->osdDatScl[4][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[4][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[4][1] < 1 || cfg->osdDatScl[4][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[4][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[5][0] < 1 || cfg->osdDatScl[5][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[5][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[5][1] < 1 || cfg->osdDatScl[5][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[5][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[6][0] < 1 || cfg->osdDatScl[6][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[6][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[6][1] < 1 || cfg->osdDatScl[6][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[6][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[7][0] < 1 || cfg->osdDatScl[7][0] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[7][0] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->osdDatScl[7][1] < 1 || cfg->osdDatScl[7][1] > 4) {
        cerr << "[error from c model] cfg->osdDatScl[7][1] should be within [1,4]!" << endl;
        return 1;
    };
    if (cfg->exampleDatInt < 0 || cfg->exampleDatInt > 1) {
        cerr << "[error from c model] cfg->exampleDatInt should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatDouble < 0 || cfg->exampleDatDouble > 0.875) {
        cerr << "[error from c model] cfg->exampleDatDouble should be within [0,0.875]!" << endl;
        return 1;
    };
    if (cfg->exampleDatVector[0] < 0 || cfg->exampleDatVector[0] > 1) {
        cerr << "[error from c model] cfg->exampleDatVector[0] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatVector[1] < 0 || cfg->exampleDatVector[1] > 1) {
        cerr << "[error from c model] cfg->exampleDatVector[1] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatArray[0][0] < 0 || cfg->exampleDatArray[0][0] > 1) {
        cerr << "[error from c model] cfg->exampleDatArray[0][0] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatArray[0][1] < 0 || cfg->exampleDatArray[0][1] > 1) {
        cerr << "[error from c model] cfg->exampleDatArray[0][1] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatArray[0][2] < 0 || cfg->exampleDatArray[0][2] > 1) {
        cerr << "[error from c model] cfg->exampleDatArray[0][2] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatArray[1][0] < 0 || cfg->exampleDatArray[1][0] > 1) {
        cerr << "[error from c model] cfg->exampleDatArray[1][0] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatArray[1][1] < 0 || cfg->exampleDatArray[1][1] > 1) {
        cerr << "[error from c model] cfg->exampleDatArray[1][1] should be within [0,1]!" << endl;
        return 1;
    };
    if (cfg->exampleDatArray[1][2] < 0 || cfg->exampleDatArray[1][2] > 1) {
        cerr << "[error from c model] cfg->exampleDatArray[1][2] should be within [0,1]!" << endl;
        return 1;
    };
    return 0;
}

// msc_cfgLog
void msc_cfgLog(
msc_cfg_t *cfg)
{
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--strFileIn              " << cfg->strFileIn.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--strFileOut             " << cfg->strFileOut.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--strPrefixDump          " << cfg->strPrefixDump.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--strPrefixLoad          " << cfg->strPrefixLoad.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--numFrame               " << cfg->numFrame << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sizFrameX              " << cfg->sizFrameX << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sizFrameY              " << cfg->sizFrameY << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sizFrameZ              " << cfg->sizFrameZ << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--enmFormatIn            " << cfg->enmFormatIn << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--enmProc                " << cfg->enmProc << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--enmInfo                " << cfg->enmInfo << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--enmLoad                " << cfg->enmLoad << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--enmDump                " << cfg->enmDump << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--datSeed                " << cfg->datSeed << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sizUnitX               " << cfg->sizUnitX << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sizUnitY               " << cfg->sizUnitY << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclFlgProc             " << cfg->sclFlgProc << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclNumTap              " << cfg->sclNumTap << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclSizFrameX           " << cfg->sclSizFrameX << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclSizFrameY           " << cfg->sclSizFrameY << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclEnmMode             " << cfg->sclEnmMode << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclEnmLoad             " << cfg->sclEnmLoad << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclEnmDump             " << cfg->sclEnmDump << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclDatThreshold2       " << cfg->sclDatThreshold2 << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclDatThreshold4       " << cfg->sclDatThreshold4 << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltFlgProc             " << cfg->fltFlgProc << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltEnmLoad             " << cfg->fltEnmLoad << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltEnmDump             " << cfg->fltEnmDump << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_0_0          " << cfg->fltDatCoe[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_0_1          " << cfg->fltDatCoe[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_0_2          " << cfg->fltDatCoe[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_1_0          " << cfg->fltDatCoe[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_1_1          " << cfg->fltDatCoe[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_1_2          " << cfg->fltDatCoe[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_2_0          " << cfg->fltDatCoe[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_2_1          " << cfg->fltDatCoe[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--fltDatCoe_2_2          " << cfg->fltDatCoe[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlgProc             " << cfg->osdFlgProc << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile0            " << cfg->osdStrFile0.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile1            " << cfg->osdStrFile1.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile2            " << cfg->osdStrFile2.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile3            " << cfg->osdStrFile3.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile4            " << cfg->osdStrFile4.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile5            " << cfg->osdStrFile5.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile6            " << cfg->osdStrFile6.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdStrFile7            " << cfg->osdStrFile7.data() << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_0               " << cfg->osdFlg[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_1               " << cfg->osdFlg[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_2               " << cfg->osdFlg[2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_3               " << cfg->osdFlg[3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_4               " << cfg->osdFlg[4] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_5               " << cfg->osdFlg[5] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_6               " << cfg->osdFlg[6] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdFlg_7               " << cfg->osdFlg[7] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_0         " << cfg->osdSizFrameX[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_1         " << cfg->osdSizFrameX[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_2         " << cfg->osdSizFrameX[2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_3         " << cfg->osdSizFrameX[3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_4         " << cfg->osdSizFrameX[4] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_5         " << cfg->osdSizFrameX[5] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_6         " << cfg->osdSizFrameX[6] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameX_7         " << cfg->osdSizFrameX[7] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_0         " << cfg->osdSizFrameY[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_1         " << cfg->osdSizFrameY[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_2         " << cfg->osdSizFrameY[2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_3         " << cfg->osdSizFrameY[3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_4         " << cfg->osdSizFrameY[4] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_5         " << cfg->osdSizFrameY[5] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_6         " << cfg->osdSizFrameY[6] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdSizFrameY_7         " << cfg->osdSizFrameY[7] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_0         " << cfg->osdPosFrameX[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_1         " << cfg->osdPosFrameX[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_2         " << cfg->osdPosFrameX[2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_3         " << cfg->osdPosFrameX[3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_4         " << cfg->osdPosFrameX[4] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_5         " << cfg->osdPosFrameX[5] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_6         " << cfg->osdPosFrameX[6] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameX_7         " << cfg->osdPosFrameX[7] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_0         " << cfg->osdPosFrameY[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_1         " << cfg->osdPosFrameY[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_2         " << cfg->osdPosFrameY[2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_3         " << cfg->osdPosFrameY[3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_4         " << cfg->osdPosFrameY[4] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_5         " << cfg->osdPosFrameY[5] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_6         " << cfg->osdPosFrameY[6] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdPosFrameY_7         " << cfg->osdPosFrameY[7] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmLoad             " << cfg->osdEnmLoad << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_0           " << cfg->osdEnmMode[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_1           " << cfg->osdEnmMode[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_2           " << cfg->osdEnmMode[2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_3           " << cfg->osdEnmMode[3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_4           " << cfg->osdEnmMode[4] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_5           " << cfg->osdEnmMode[5] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_6           " << cfg->osdEnmMode[6] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmMode_7           " << cfg->osdEnmMode[7] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdEnmDump             " << cfg->osdEnmDump << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_0_0          " << cfg->osdDatScl[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_0_1          " << cfg->osdDatScl[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_1_0          " << cfg->osdDatScl[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_1_1          " << cfg->osdDatScl[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_2_0          " << cfg->osdDatScl[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_2_1          " << cfg->osdDatScl[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_3_0          " << cfg->osdDatScl[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_3_1          " << cfg->osdDatScl[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_4_0          " << cfg->osdDatScl[4][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_4_1          " << cfg->osdDatScl[4][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_5_0          " << cfg->osdDatScl[5][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_5_1          " << cfg->osdDatScl[5][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_6_0          " << cfg->osdDatScl[6][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_6_1          " << cfg->osdDatScl[6][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_7_0          " << cfg->osdDatScl[7][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatScl_7_1          " << cfg->osdDatScl[7][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_0_0         " << cfg->osdDatLut0[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_0_1         " << cfg->osdDatLut0[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_0_2         " << cfg->osdDatLut0[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_0_3         " << cfg->osdDatLut0[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_1_0         " << cfg->osdDatLut0[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_1_1         " << cfg->osdDatLut0[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_1_2         " << cfg->osdDatLut0[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_1_3         " << cfg->osdDatLut0[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_2_0         " << cfg->osdDatLut0[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_2_1         " << cfg->osdDatLut0[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_2_2         " << cfg->osdDatLut0[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_2_3         " << cfg->osdDatLut0[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_3_0         " << cfg->osdDatLut0[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_3_1         " << cfg->osdDatLut0[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_3_2         " << cfg->osdDatLut0[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut0_3_3         " << cfg->osdDatLut0[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_0_0         " << cfg->osdDatLut1[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_0_1         " << cfg->osdDatLut1[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_0_2         " << cfg->osdDatLut1[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_0_3         " << cfg->osdDatLut1[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_1_0         " << cfg->osdDatLut1[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_1_1         " << cfg->osdDatLut1[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_1_2         " << cfg->osdDatLut1[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_1_3         " << cfg->osdDatLut1[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_2_0         " << cfg->osdDatLut1[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_2_1         " << cfg->osdDatLut1[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_2_2         " << cfg->osdDatLut1[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_2_3         " << cfg->osdDatLut1[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_3_0         " << cfg->osdDatLut1[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_3_1         " << cfg->osdDatLut1[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_3_2         " << cfg->osdDatLut1[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut1_3_3         " << cfg->osdDatLut1[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_0_0         " << cfg->osdDatLut2[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_0_1         " << cfg->osdDatLut2[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_0_2         " << cfg->osdDatLut2[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_0_3         " << cfg->osdDatLut2[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_1_0         " << cfg->osdDatLut2[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_1_1         " << cfg->osdDatLut2[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_1_2         " << cfg->osdDatLut2[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_1_3         " << cfg->osdDatLut2[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_2_0         " << cfg->osdDatLut2[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_2_1         " << cfg->osdDatLut2[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_2_2         " << cfg->osdDatLut2[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_2_3         " << cfg->osdDatLut2[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_3_0         " << cfg->osdDatLut2[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_3_1         " << cfg->osdDatLut2[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_3_2         " << cfg->osdDatLut2[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut2_3_3         " << cfg->osdDatLut2[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_0_0         " << cfg->osdDatLut3[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_0_1         " << cfg->osdDatLut3[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_0_2         " << cfg->osdDatLut3[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_0_3         " << cfg->osdDatLut3[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_1_0         " << cfg->osdDatLut3[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_1_1         " << cfg->osdDatLut3[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_1_2         " << cfg->osdDatLut3[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_1_3         " << cfg->osdDatLut3[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_2_0         " << cfg->osdDatLut3[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_2_1         " << cfg->osdDatLut3[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_2_2         " << cfg->osdDatLut3[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_2_3         " << cfg->osdDatLut3[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_3_0         " << cfg->osdDatLut3[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_3_1         " << cfg->osdDatLut3[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_3_2         " << cfg->osdDatLut3[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut3_3_3         " << cfg->osdDatLut3[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_0_0         " << cfg->osdDatLut4[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_0_1         " << cfg->osdDatLut4[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_0_2         " << cfg->osdDatLut4[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_0_3         " << cfg->osdDatLut4[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_1_0         " << cfg->osdDatLut4[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_1_1         " << cfg->osdDatLut4[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_1_2         " << cfg->osdDatLut4[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_1_3         " << cfg->osdDatLut4[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_2_0         " << cfg->osdDatLut4[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_2_1         " << cfg->osdDatLut4[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_2_2         " << cfg->osdDatLut4[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_2_3         " << cfg->osdDatLut4[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_3_0         " << cfg->osdDatLut4[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_3_1         " << cfg->osdDatLut4[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_3_2         " << cfg->osdDatLut4[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut4_3_3         " << cfg->osdDatLut4[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_0_0         " << cfg->osdDatLut5[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_0_1         " << cfg->osdDatLut5[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_0_2         " << cfg->osdDatLut5[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_0_3         " << cfg->osdDatLut5[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_1_0         " << cfg->osdDatLut5[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_1_1         " << cfg->osdDatLut5[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_1_2         " << cfg->osdDatLut5[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_1_3         " << cfg->osdDatLut5[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_2_0         " << cfg->osdDatLut5[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_2_1         " << cfg->osdDatLut5[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_2_2         " << cfg->osdDatLut5[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_2_3         " << cfg->osdDatLut5[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_3_0         " << cfg->osdDatLut5[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_3_1         " << cfg->osdDatLut5[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_3_2         " << cfg->osdDatLut5[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut5_3_3         " << cfg->osdDatLut5[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_0_0         " << cfg->osdDatLut6[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_0_1         " << cfg->osdDatLut6[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_0_2         " << cfg->osdDatLut6[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_0_3         " << cfg->osdDatLut6[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_1_0         " << cfg->osdDatLut6[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_1_1         " << cfg->osdDatLut6[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_1_2         " << cfg->osdDatLut6[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_1_3         " << cfg->osdDatLut6[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_2_0         " << cfg->osdDatLut6[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_2_1         " << cfg->osdDatLut6[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_2_2         " << cfg->osdDatLut6[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_2_3         " << cfg->osdDatLut6[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_3_0         " << cfg->osdDatLut6[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_3_1         " << cfg->osdDatLut6[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_3_2         " << cfg->osdDatLut6[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut6_3_3         " << cfg->osdDatLut6[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_0_0         " << cfg->osdDatLut7[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_0_1         " << cfg->osdDatLut7[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_0_2         " << cfg->osdDatLut7[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_0_3         " << cfg->osdDatLut7[0][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_1_0         " << cfg->osdDatLut7[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_1_1         " << cfg->osdDatLut7[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_1_2         " << cfg->osdDatLut7[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_1_3         " << cfg->osdDatLut7[1][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_2_0         " << cfg->osdDatLut7[2][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_2_1         " << cfg->osdDatLut7[2][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_2_2         " << cfg->osdDatLut7[2][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_2_3         " << cfg->osdDatLut7[2][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_3_0         " << cfg->osdDatLut7[3][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_3_1         " << cfg->osdDatLut7[3][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_3_2         " << cfg->osdDatLut7[3][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--osdDatLut7_3_3         " << cfg->osdDatLut7[3][3] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatInt          " << cfg->exampleDatInt << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatDouble       " << cfg->exampleDatDouble << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatVector_0     " << cfg->exampleDatVector[0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatVector_1     " << cfg->exampleDatVector[1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_0_0    " << cfg->exampleDatArray[0][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_0_1    " << cfg->exampleDatArray[0][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_0_2    " << cfg->exampleDatArray[0][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_1_0    " << cfg->exampleDatArray[1][0] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_1_1    " << cfg->exampleDatArray[1][1] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_1_2    " << cfg->exampleDatArray[1][2] << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--numUnitX               " << cfg->numUnitX << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--numUnitY               " << cfg->numUnitY << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--datScalerX             " << cfg->datScalerX << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::DETAILED)    cout << "--datScalerY             " << cfg->datScalerY << endl;
    if (MSC_CFG_ENUM_LVL_RLS >= msc_enmLvlCfg_t::ROUGH   )    cout << "--sclDatThreshold2Inv    " << cfg->sclDatThreshold2Inv << endl;
}
