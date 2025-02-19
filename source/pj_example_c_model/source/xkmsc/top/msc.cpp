//------------------------------------------------------------------------------
    //
    //  Filename       : main.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : main
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_cfg.hpp"
#include "msc_knl_export.hpp"


//*** FUNCTION *****************************************************************
// msc_logo
void msc_logo(
msc_cfg_t cfg)
{
    cout << endl;
    cout << "+-------------------------------+" << endl;
    cout << "| XKMSC     VERSION: 2025.02.18 |" << endl;
    cout << "+-------------------------------+" << endl;
    cout << endl;
}

// main
int main(
int numArg, char *strArg[])
{
    // variables
    msc_cfg_t cfg;
    int datRet;
    MSC_KNL_EXPORT knlExport;
    #ifdef MSC_KNOB_TIME
    #ifdef __linux__
    timespec tic;
    timespec toc;
    #endif
    #endif

    // init cfg
    datRet = msc_cfgIni(&cfg, numArg, strArg);
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
    if ((msc_enmInfo_t)cfg.enmInfo >= msc_enmInfo_t::TOP)
        msc_logo(cfg);

    // connect knlExport
    knlExport.connect(cfg);

    // set tic
    #ifdef MSC_KNOB_TIME
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
    #ifdef MSC_KNOB_TIME
    #ifdef __linux__
    clock_gettime(CLOCK_MONOTONIC, &toc);
    #endif
    #endif

    // display run time
    #ifdef MSC_KNOB_TIME
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
