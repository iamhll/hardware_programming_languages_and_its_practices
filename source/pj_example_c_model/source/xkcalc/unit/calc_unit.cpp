//------------------------------------------------------------------------------
    //
    //  Filename       : calc_unit.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_unit.hpp"


//*** FUNCTION *****************************************************************
// CALC_UNIT
CALC_UNIT::CALC_UNIT()
{
    // information
    {
        //...
    }

    // data
    {
        // inp0, inp1, out
        m_datInp0 = (calc_dat_t (*)[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX])
            new      calc_dat_t    [CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX];
        m_datInp1 = (calc_dat_t (*)[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX])
            new      calc_dat_t    [CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX];
        m_datOut  = (calc_dat_t (*)[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX])
            new      calc_dat_t    [CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX];
        memset(*m_datInp0, 0, sizeof(*m_datInp0));
        memset(*m_datInp1, 0, sizeof(*m_datInp1));
        memset(*m_datOut , 0, sizeof(*m_datOut ));
    }

    // cost
    {
        //...
    }

    // debug
    {
        //...
    }
}

// ~CALC_UNIT
CALC_UNIT::~CALC_UNIT()
{
    // information
    {
        //...
    }

    // data
    {
        delete[] m_datInp0;
        delete[] m_datInp1;
        delete[] m_datOut ;
    }

    // cost
    {
        //...
    }

    // debug
    {
        //...
    }
}

// connect
void CALC_UNIT::connect(
calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp)
{
    m_cfg         = &cfg;
    m_cfgWritable = &cfg;
    m_fth         = &fth;
    m_dmp         = &dmp;
}

// oneShot
void CALC_UNIT::oneShot()
{
    updTic(enmFunc_t::MAIN);
    load();
    proc();
    dump();
    updToc(enmFunc_t::MAIN);
}

// load
void CALC_UNIT::load()
{
    static bool flag = 1;
    if (flag) {
        flag = 0;
        if (m_cfg == NULL) {
            cerr << "[error from c model] invalid configuration structure assigned in module " << m_strTag.c_str() + CALC_SIZE_PREFIX << "!" << endl;
            assert(0);
        }
    }
    switch (m_cfgEnmLoad) {
    case calc_enmLoad_t::PIPE:
        if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [PIPE]"
            << endl;
        loadPipe();
    break;
    case calc_enmLoad_t::FILE:
        if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [FILE]"
            << endl;
        loadFile();
    break;
    case calc_enmLoad_t::RANDOM:
        if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [RAND]"
            << endl;
        loadRand();
    break;
    default:
        assert(0);
    break;
    }
}

// process
void CALC_UNIT::proc()
{
    if (m_cfgFlgProc) {
        if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [NORM]"
            << endl;
        procMain();
    }
    else {
        if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [SKIP]"
            << endl;
    }
}

// dump
void CALC_UNIT::dump()
{
    dumpFile();
}
