//------------------------------------------------------------------------------
    //
    //  Filename       : calc_cfg.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_cfg.hpp"


//*** FUNCTION *****************************************************************
// calc_cfgIni
int calc_cfgIni(calc_cfg_t *cfg,
int numArg, char *strArg[])
{
    // variables
    int    datRet;
    string strKey;

    // help
    for (int i = 0; i < numArg; ++i) {
        strKey = strArg[i];
        if (strKey == "--help") {
            calc_cfgHlp(cfg);
            return 1;
        }
    }

    // reset
    calc_cfgRst(cfg);

    // set from file
    datRet = calc_cfgIniFromFile(cfg, numArg, strArg);
    if (datRet != 0)
        return datRet;

    // set from command line interface
    datRet = calc_cfgIniFromCli(cfg, numArg, strArg);
    if (datRet != 0)
        return datRet;

    // derive parameters
    cfg->numUnitX = cfg->sizFrameX / cfg->sizUnitX;
    cfg->numUnitY = cfg->sizFrameY / cfg->sizUnitY;

    // float2fix (with round operation)
    if ((calc_enmProc_t)cfg->enmProc == calc_enmProc_t::HARDWARE)
        calc_cfgL2X(cfg);

    // check (with script)
    datRet = calc_cfgChk(cfg);
    if (datRet != 0)
        return datRet;

    // check (manually)
    datRet = calc_cfgChkMan(cfg);
    if (datRet != 0)
        return datRet;

    // log
    for (int i = 0; i < numArg; ++i) {
        strKey = strArg[i];
        if (strKey == "--show") {
            calc_cfgLog(cfg);
        }
    }

    // dump
    calc_cfgDmp(cfg);

    // return
    return 0;
}

// calc_cfgIniFromFile
int calc_cfgIniFromFile(calc_cfg_t *cfg,
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
                calc_cfgMap(cfg, &strKey, &strDat);
                strKey = strDat;
            }

            // close
            fptCfg.close();
        }
    }

    // return
    return 0;
}

// calc_cfgIniFromCli
int calc_cfgIniFromCli(calc_cfg_t *cfg,
int numArg, char *strArg[])
{
    // process
    for (int idxArg = 1; idxArg < numArg - 1; ++idxArg) {
        // variables
        string strKey = strArg[idxArg];
        string strDat = strArg[idxArg + 1];
        calc_cfgMap(cfg, &strKey, &strDat);
    }

    // return
    return 0;
}

// calc_cfgChkMan
int calc_cfgChkMan(
calc_cfg_t *cfg)
{
    if (cfg->sizFrameX > CALC_SIZE_FRAME_X_MAX) {
        cerr << "[error from c model] sizFrameX should be smaller than" << CALC_SIZE_FRAME_X_MAX << "!" << endl;
        return 1;
    }
    if (cfg->sizFrameY > CALC_SIZE_FRAME_Y_MAX) {
        cerr << "[error from c model] sizFrameY should be smaller than" << CALC_SIZE_FRAME_Y_MAX << "!" << endl;
        return 1;
    }
    if (cfg->sizFrameZ > CALC_SIZE_FRAME_Z_MAX) {
        cerr << "[error from c model] sizFrameZ should be smaller than" << CALC_SIZE_FRAME_Z_MAX << "!" << endl;
        return 1;
    }
    if (cfg->sizUnitX  > CALC_SIZE_UNIT_X_MAX ) {
        cerr << "[error from c model] sizUnitX  should be smaller than" << CALC_SIZE_UNIT_X_MAX  << "!" << endl;
        return 1;
    }
    if (cfg->sizUnitY  > CALC_SIZE_UNIT_Y_MAX ) {
        cerr << "[error from c model] sizUnitY  should be smaller than" << CALC_SIZE_UNIT_Y_MAX  << "!" << endl;
        return 1;
    }
    if (cfg->sizUnitZ  > CALC_SIZE_UNIT_Z_MAX ) {
        cerr << "[error from c model] sizUnitZ  should be smaller than" << CALC_SIZE_UNIT_Z_MAX  << "!" << endl;
        return 1;
    }

    // return
    return 0;
}
