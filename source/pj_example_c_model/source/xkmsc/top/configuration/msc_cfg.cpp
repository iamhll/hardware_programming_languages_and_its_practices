//------------------------------------------------------------------------------
    //
    //  Filename       : msc_cfg.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_cfg.hpp"


//*** FUNCTION *****************************************************************
// msc_cfgIni
int msc_cfgIni(msc_cfg_t *cfg,
int numArg, char *strArg[])
{
    // variables
    int    datRet;
    string strKey;

    // help
    for (int i = 0; i < numArg; ++i) {
        strKey = strArg[i];
        if (strKey == "--help") {
            msc_cfgHlp(cfg);
            return 1;
        }
    }

    // reset
    msc_cfgRst(cfg);

    // set from file
    datRet = msc_cfgIniFromFile(cfg, numArg, strArg);
    if (datRet != 0)
        return datRet;

    // set from command line interface
    datRet = msc_cfgIniFromCli(cfg, numArg, strArg);
    if (datRet != 0)
        return datRet;

    // derive parameters
    cfg->numUnitX = (cfg->sclSizFrameX + cfg->sizUnitX - 1)/ cfg->sizUnitX;
    cfg->numUnitY = (cfg->sclSizFrameY + cfg->sizUnitY - 1)/ cfg->sizUnitY;
    cfg->datScalerX = 1.0 / cfg->sclSizFrameX * cfg->sizFrameX;
    cfg->datScalerY = 1.0 / cfg->sclSizFrameY * cfg->sizFrameY;
    cfg->sclDatThreshold2Inv = 1.0 / cfg->sclDatThreshold2;

    // float2fix (with round operation)
    if ((msc_enmProc_t)cfg->enmProc == msc_enmProc_t::HARDWARE)
        msc_cfgL2X(cfg);

    // check (with script)
    datRet = msc_cfgChk(cfg);
    if (datRet != 0)
        return datRet;

    // check (manually)
    datRet = msc_cfgChkMan(cfg);
    if (datRet != 0)
        return datRet;

    // log
    for (int i = 0; i < numArg; ++i) {
        strKey = strArg[i];
        if (strKey == "--show") {
            msc_cfgLog(cfg);
        }
    }

    // dump
    msc_cfgDmp(cfg);

    // return
    return 0;
}

// msc_cfgIniFromFile
int msc_cfgIniFromFile(msc_cfg_t *cfg,
int numArg, char *strArg[])
{
    // variables
    string strFileCfg;
    string strKey, strDat;

    // main loop
    for (int idxArg = 0; idxArg < numArg; ++idxArg) {
        strKey = strArg[idxArg];
        if (strKey == "-c" || strKey == "--strFileCfg") {
            // open
            strFileCfg = strArg[idxArg + 1];
            fstream fptCfg;
            fptCfg.open(strFileCfg.c_str());
            if (!fptCfg.is_open()) {
                cout << "ERROR: cannot find configuartion file(" << strFileCfg << ")!" << endl;
                return 1;
            }

            // process
            fptCfg >> strKey;
            while (fptCfg >> strDat) {
                msc_cfgMap(cfg, &strKey, &strDat);
                strKey = strDat;
            }

            // close
            fptCfg.close();
        }
    }

    // return
    return 0;
}

// msc_cfgIniFromCli
int msc_cfgIniFromCli(msc_cfg_t *cfg,
int numArg, char *strArg[])
{
    // process
    for (int idxArg = 1; idxArg < numArg - 1; ++idxArg) {
        // variables
        string strKey = strArg[idxArg];
        string strDat = strArg[idxArg + 1];
        msc_cfgMap(cfg, &strKey, &strDat);
    }

    // return
    return 0;
}

// msc_cfgChkMan
int msc_cfgChkMan(
msc_cfg_t *cfg)
{
    if (cfg->sizFrameX > MSC_SIZE_FRAME_X_MAX) {
        cerr << "[error from c model] sizFrameX should be smaller than" << MSC_SIZE_FRAME_X_MAX << "!" << endl;
        return 1;
    }
    if (cfg->sizFrameY > MSC_SIZE_FRAME_Y_MAX) {
        cerr << "[error from c model] sizFrameY should be smaller than" << MSC_SIZE_FRAME_Y_MAX << "!" << endl;
        return 1;
    }
    if (cfg->sizFrameZ > MSC_SIZE_FRAME_Z_MAX) {
        cerr << "[error from c model] sizFrameZ should be smaller than" << MSC_SIZE_FRAME_Z_MAX << "!" << endl;
        return 1;
    }
    if (cfg->sizUnitX  > MSC_SIZE_UNIT_X_MAX ) {
        cerr << "[error from c model] sizUnitX  should be smaller than" << MSC_SIZE_UNIT_X_MAX  << "!" << endl;
        return 1;
    }
    if (cfg->sizUnitY  > MSC_SIZE_UNIT_Y_MAX ) {
        cerr << "[error from c model] sizUnitY  should be smaller than" << MSC_SIZE_UNIT_Y_MAX  << "!" << endl;
        return 1;
    }

    // return
    return 0;
}
