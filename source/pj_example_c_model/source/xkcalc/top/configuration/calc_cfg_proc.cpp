//------------------------------------------------------------------------------
    //
    //  Filename       : calc_cfg_proc.cpp
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
#include "calc_cfg.hpp"


//*** FUNCTION *****************************************************************
// calc_cfgRst
void calc_cfgRst(calc_cfg_t *cfg)
{
    // changeable
    cfg->idxFrame              = 0;
    cfg->idxUnitX              = 0;
    cfg->idxUnitY              = 0;

    // top
    cfg->strFileInp            = "";
    cfg->strFileOut            = "out.dat";
    cfg->strPrefixDump         = "";
    cfg->strPrefixLoad         = "";
    cfg->numFrame              = 10;
    cfg->sizFrameX             = 256;
    cfg->sizFrameY             = 256;
    cfg->sizFrameZ             = 4;
    cfg->enmProc               = 0;
    cfg->enmInfo               = 2;
    cfg->enmLoad               = 2;
    cfg->datSeed               = 0;
    cfg->sizUnitX              = 32;
    cfg->sizUnitY              = 32;
    cfg->sizUnitZ              = 4;

    // adder
    cfg->addFlgProc            = 1;
    cfg->addFlgSaturation      = 0;
    cfg->addEnmLoad            = 0;
    cfg->addEnmDump            = 0;

    // substrator
    cfg->subFlgProc            = 1;
    cfg->subFlgSaturation      = 0;
    cfg->subEnmLoad            = 0;
    cfg->subEnmDump            = 0;

    // multiplier
    cfg->mulFlgProc            = 1;
    cfg->mulFlgSaturation      = 0;
    cfg->mulEnmLoad            = 0;
    cfg->mulEnmDump            = 0;

    // divider
    cfg->divFlgProc            = 1;
    cfg->divFlgSaturation      = 0;
    cfg->divEnmLoad            = 0;
    cfg->divEnmDump            = 0;

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
}

// calc_cfgHlp
void calc_cfgHlp(
calc_cfg_t *cfg)
{
    cout << endl;
    cout << "[virtual]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    strFileCfg          full location of the configuration file" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    help                to print help information" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    show                to show configuration value" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    dryRun              to check input without running" << endl;
    cout << endl;
    cout << "[top]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    strFileInp          full location of the input file" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    strFileOut          full location of the output file" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    strPrefixDump       dump prefix for debug data" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED) cout << "    strPrefixLoad       load prefix for debug data" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    numFrame            number of the frames to be processed" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    sizFrameX           size of frames in 1st dimension" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    sizFrameY           size of frames in 2nd dimension" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    sizFrameZ           size of frames in 3rd dimension" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    enmProc             enumerator for processing behavior (<value> 0: software 1: hardware)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    enmInfo             enumerator for information level (<value> 0: none 1: system 2: top 3: module 4: common)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    enmLoad             enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    datSeed             value of random seed" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    sizUnitX            size of units' 1st dimension" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    sizUnitY            size of units' 2nd dimension" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    sizUnitZ            size of units' 3rd dimension" << endl;
    cout << endl;
    cout << "[adder]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    addFlgProc          enable flag for processing" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    addFlgSaturation    enable flag for saturation" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    addEnmLoad          enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    addEnmDump          enumerator for data dump (<value> 0: none 1: inout 2: intermediate)" << endl;
    cout << endl;
    cout << "[substrator]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    subFlgProc          enable flag for processing" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    subFlgSaturation    enable flag for saturation" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    subEnmLoad          enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    subEnmDump          enumerator for data dump (<value> 0: none 1: inout 2: intermediate)" << endl;
    cout << endl;
    cout << "[multiplier]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    mulFlgProc          enable flag for processing" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    mulFlgSaturation    enable flag for saturation" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    mulEnmLoad          enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    mulEnmDump          enumerator for data dump (<value> 0: none 1: inout 2: intermediate)" << endl;
    cout << endl;
    cout << "[divider]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    divFlgProc          enable flag for processing" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    divFlgSaturation    enable flag for saturation" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    divEnmLoad          enumerator for load source (<value> 0: pipeline 1: file 2: random)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   ) cout << "    divEnmDump          enumerator for data dump (<value> 0: none 1: inout 2: intermediate)" << endl;
    cout << endl;
    cout << "[example]" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED) cout << "    exampleDatInt       an example for int (scalar)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED) cout << "    exampleDatDouble    an example for double (scalar)" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED) cout << "    exampleDatVector    an example for (int) vector" << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED) cout << "    exampleDatArray     an example for (int) array" << endl;
}

// calc_cfgMap
void calc_cfgMap(calc_cfg_t *cfg,
const string *strKey, const string *strDat)
{
    // variables
    const char *datAsCStr   = strDat->data();
    int         datAsInt    = atoi(strDat->data());
    double      datAsDouble = atof(strDat->data());
    bool        datAsBool   = datAsInt ? true : false;

    // mapping
    if      (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--strFileInp"         || *strKey == "-i"))    cfg->strFileInp            = datAsCStr;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--strFileOut"         || *strKey == "-o"))    cfg->strFileOut            = datAsCStr;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--strPrefixDump"                        ))    cfg->strPrefixDump         = datAsCStr;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--strPrefixLoad"                        ))    cfg->strPrefixLoad         = datAsCStr;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--numFrame"                             ))    cfg->numFrame              = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizFrameX"                            ))    cfg->sizFrameX             = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizFrameY"                            ))    cfg->sizFrameY             = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizFrameZ"                            ))    cfg->sizFrameZ             = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmProc"                              ))    cfg->enmProc               = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmInfo"                              ))    cfg->enmInfo               = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--enmLoad"                              ))    cfg->enmLoad               = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--datSeed"            || *strKey == "-r"))    cfg->datSeed               = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizUnitX"                             ))    cfg->sizUnitX              = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizUnitY"                             ))    cfg->sizUnitY              = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--sizUnitZ"                             ))    cfg->sizUnitZ              = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--addFlgProc"                           ))    cfg->addFlgProc            = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--addFlgSaturation"                     ))    cfg->addFlgSaturation      = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--addEnmLoad"                           ))    cfg->addEnmLoad            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--addEnmDump"                           ))    cfg->addEnmDump            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--subFlgProc"                           ))    cfg->subFlgProc            = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--subFlgSaturation"                     ))    cfg->subFlgSaturation      = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--subEnmLoad"                           ))    cfg->subEnmLoad            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--subEnmDump"                           ))    cfg->subEnmDump            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--mulFlgProc"                           ))    cfg->mulFlgProc            = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--mulFlgSaturation"                     ))    cfg->mulFlgSaturation      = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--mulEnmLoad"                           ))    cfg->mulEnmLoad            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--mulEnmDump"                           ))    cfg->mulEnmDump            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--divFlgProc"                           ))    cfg->divFlgProc            = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--divFlgSaturation"                     ))    cfg->divFlgSaturation      = datAsBool;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--divEnmLoad"                           ))    cfg->divEnmLoad            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH    && (*strKey == "--divEnmDump"                           ))    cfg->divEnmDump            = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatInt"                        ))    cfg->exampleDatInt         = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatDouble"                     ))    cfg->exampleDatDouble      = datAsDouble;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatVector_0"                   ))    cfg->exampleDatVector[0]   = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatVector_1"                   ))    cfg->exampleDatVector[1]   = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_0_0"                  ))    cfg->exampleDatArray[0][0] = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_0_1"                  ))    cfg->exampleDatArray[0][1] = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_0_2"                  ))    cfg->exampleDatArray[0][2] = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_1_0"                  ))    cfg->exampleDatArray[1][0] = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_1_1"                  ))    cfg->exampleDatArray[1][1] = datAsInt;
    else if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED && (*strKey == "--exampleDatArray_1_2"                  ))    cfg->exampleDatArray[1][2] = datAsInt;
}

// calc_cfgL2X
void calc_cfgL2X(calc_cfg_t *cfg)
{
    cfg->exampleDatDouble = calc_getDatRound(cfg->exampleDatDouble, 8);
}

// calc_cfgChk
int  calc_cfgChk(
calc_cfg_t *cfg)
{
    if (cfg->sizFrameX < 1 || cfg->sizFrameX > 1024) {
        cerr << "[error from c model] cfg->sizFrameX should be within [1,1024]!" << endl;
        return 1;
    };
    if (cfg->sizFrameY < 1 || cfg->sizFrameY > 1024) {
        cerr << "[error from c model] cfg->sizFrameY should be within [1,1024]!" << endl;
        return 1;
    };
    if (cfg->sizFrameZ < 1 || cfg->sizFrameZ > 16) {
        cerr << "[error from c model] cfg->sizFrameZ should be within [1,16]!" << endl;
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
    if (cfg->sizUnitX < 1 || cfg->sizUnitX > 32) {
        cerr << "[error from c model] cfg->sizUnitX should be within [1,32]!" << endl;
        return 1;
    };
    if (cfg->sizUnitY < 1 || cfg->sizUnitY > 32) {
        cerr << "[error from c model] cfg->sizUnitY should be within [1,32]!" << endl;
        return 1;
    };
    if (cfg->sizUnitZ < 1 || cfg->sizUnitZ > 16) {
        cerr << "[error from c model] cfg->sizUnitZ should be within [1,16]!" << endl;
        return 1;
    };
    if (cfg->addEnmLoad < 0 || cfg->addEnmLoad > 2) {
        cerr << "[error from c model] cfg->addEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->addEnmDump < 0 || cfg->addEnmDump > 2) {
        cerr << "[error from c model] cfg->addEnmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->subEnmLoad < 0 || cfg->subEnmLoad > 2) {
        cerr << "[error from c model] cfg->subEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->subEnmDump < 0 || cfg->subEnmDump > 2) {
        cerr << "[error from c model] cfg->subEnmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->mulEnmLoad < 0 || cfg->mulEnmLoad > 2) {
        cerr << "[error from c model] cfg->mulEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->mulEnmDump < 0 || cfg->mulEnmDump > 2) {
        cerr << "[error from c model] cfg->mulEnmDump should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->divEnmLoad < 0 || cfg->divEnmLoad > 2) {
        cerr << "[error from c model] cfg->divEnmLoad should be within [0,2]!" << endl;
        return 1;
    };
    if (cfg->divEnmDump < 0 || cfg->divEnmDump > 2) {
        cerr << "[error from c model] cfg->divEnmDump should be within [0,2]!" << endl;
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

// calc_cfgLog
void calc_cfgLog(
calc_cfg_t *cfg)
{
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--strFileInp             " << cfg->strFileInp.data() << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--strFileOut             " << cfg->strFileOut.data() << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--strPrefixDump          " << cfg->strPrefixDump.data() << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--strPrefixLoad          " << cfg->strPrefixLoad.data() << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--numFrame               " << cfg->numFrame << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--sizFrameX              " << cfg->sizFrameX << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--sizFrameY              " << cfg->sizFrameY << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--sizFrameZ              " << cfg->sizFrameZ << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--enmProc                " << cfg->enmProc << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--enmInfo                " << cfg->enmInfo << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--enmLoad                " << cfg->enmLoad << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--datSeed                " << cfg->datSeed << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--sizUnitX               " << cfg->sizUnitX << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--sizUnitY               " << cfg->sizUnitY << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--sizUnitZ               " << cfg->sizUnitZ << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--addFlgProc             " << cfg->addFlgProc << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--addFlgSaturation       " << cfg->addFlgSaturation << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--addEnmLoad             " << cfg->addEnmLoad << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--addEnmDump             " << cfg->addEnmDump << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--subFlgProc             " << cfg->subFlgProc << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--subFlgSaturation       " << cfg->subFlgSaturation << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--subEnmLoad             " << cfg->subEnmLoad << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--subEnmDump             " << cfg->subEnmDump << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--mulFlgProc             " << cfg->mulFlgProc << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--mulFlgSaturation       " << cfg->mulFlgSaturation << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--mulEnmLoad             " << cfg->mulEnmLoad << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--mulEnmDump             " << cfg->mulEnmDump << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--divFlgProc             " << cfg->divFlgProc << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--divFlgSaturation       " << cfg->divFlgSaturation << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--divEnmLoad             " << cfg->divEnmLoad << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::ROUGH   )    cout << "--divEnmDump             " << cfg->divEnmDump << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatInt          " << cfg->exampleDatInt << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatDouble       " << cfg->exampleDatDouble << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatVector_0     " << cfg->exampleDatVector[0] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatVector_1     " << cfg->exampleDatVector[1] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_0_0    " << cfg->exampleDatArray[0][0] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_0_1    " << cfg->exampleDatArray[0][1] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_0_2    " << cfg->exampleDatArray[0][2] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_1_0    " << cfg->exampleDatArray[1][0] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_1_1    " << cfg->exampleDatArray[1][1] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--exampleDatArray_1_2    " << cfg->exampleDatArray[1][2] << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--numUnitX               " << cfg->numUnitX << endl;
    if (CALC_CFG_ENUM_LVL_RLS >= calc_enmLvlCfg_t::DETAILED)    cout << "--numUnitY               " << cfg->numUnitY << endl;
}
