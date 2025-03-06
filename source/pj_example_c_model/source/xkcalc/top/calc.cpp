//------------------------------------------------------------------------------
    //
    //  Filename       : calc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : top related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_cfg.hpp"
#include "calc_knl_export.hpp"


//*** FUNCTION *****************************************************************
// calc_logo
void calc_logo(
calc_cfg_t cfg)
{
    cout << endl;
    cout << "+-------------------------------+" << endl;
    cout << "| XKCALC    VERSION: 2025.02.18 |" << endl;
    cout << "+-------------------------------+" << endl;
    cout << endl;
}

// main
int main(
int numArg, char *strArg[])
{
    // variables
    calc_cfg_t cfg;
    int datRet;
    CALC_KNL_EXPORT knlExport;
    #ifdef CALC_KNOB_TIME
    #ifdef __linux__
    timespec tic;
    timespec toc;
    #endif
    #endif

    // init cfg
    datRet = calc_cfgIni(&cfg, numArg, strArg);
    if (datRet != 0)
        return datRet;

    // dry run
    for (int i = 0; i < numArg; ++i) {
        string strKey = strArg[i];
        if (strKey == "--dryRun") {
            return 0;
        }
    }

    // init seed
    srand(cfg.datSeed);

    // show logo
    if ((calc_enmInfo_t)cfg.enmInfo >= calc_enmInfo_t::TOP)
        calc_logo(cfg);

    // connect knlExport
    knlExport.connect(cfg);

    // set tic
    #ifdef CALC_KNOB_TIME
    #ifdef __linux__
    clock_gettime(CLOCK_MONOTONIC, &tic);
    #endif
    #endif

    // run
    for (cfg.idxFrame = 0; cfg.idxFrame < cfg.numFrame; ++cfg.idxFrame) {
        // one shot
        knlExport.oneShot();
    }

    // set toc
    #ifdef CALC_KNOB_TIME
    #ifdef __linux__
    clock_gettime(CLOCK_MONOTONIC, &toc);
    #endif
    #endif

    // display run time
    #ifdef CALC_KNOB_TIME
    #ifdef __linux__
    {
        unsigned long datDlt = toc.tv_sec * 1000 + toc.tv_nsec / 1000 / 1000
            -                  tic.tv_sec * 1000 - tic.tv_nsec / 1000 / 1000
        ;
        cout << "run time                   is " << setprecision(3) << (double)datDlt / 1000 << " s" << endl;
    }
    knlExport.dspRunTime();
    #endif
    #endif

    // return
    return 0;
}
