//------------------------------------------------------------------------------
    //
    //  Filename       : msc_unit.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_unit.hpp"


//*** FUNCTION *****************************************************************
// MSC_UNIT
MSC_UNIT::MSC_UNIT()
{
    // information
    {
        //...
    }

    // data
    {
        // in, out
        m_datIn  = (msc_pxl_t (*)[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX])
            new     msc_pxl_t    [MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX];
        m_datOut = (msc_pxl_t (*)[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX])
            new     msc_pxl_t    [MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX];
        memset(*m_datIn , 0, sizeof(*m_datIn ));
        memset(*m_datOut, 0, sizeof(*m_datOut));
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

// ~MSC_UNIT
MSC_UNIT::~MSC_UNIT()
{
    // information
    {
        //...
    }

    // data
    {
        delete[] m_datIn ;
        delete[] m_datOut;
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
void MSC_UNIT::connect(
msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp)
{
    m_cfg         = &cfg;
    m_cfgWritable = &cfg;
    m_fth         = &fth;
    m_dmp         = &dmp;
}

// oneShot
void MSC_UNIT::oneShot()
{
    updTic(enmFunc_t::MAIN);
    load();
    proc();
    dump();
    updToc(enmFunc_t::MAIN);
}

// load
void MSC_UNIT::load()
{
    static bool flag = 1;
    if (flag) {
        flag = 0;
        if (m_cfg == NULL) {
            cerr << "[error from c model] invalid configuration structure assigned in module " << m_strTag.c_str() + MSC_SIZE_PREFIX << "!" << endl;
            assert(0);
        }
    }
    switch (m_cfgEnmLoad) {
    case msc_enmLoad_t::PIPE:
        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                <<    " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                <<    " LOAD [PIPE]"
            << endl;
        loadPipe();
    break;
    case msc_enmLoad_t::FILE:
        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                <<    " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                <<    " LOAD [FILE]"
            << endl;
        loadFile();
    break;
    case msc_enmLoad_t::RANDOM:
        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                <<    " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                <<    " LOAD [RAND]"
            << endl;
        loadRand();
    break;
    default:
        assert(0);
    break;
    }
}

// process
void MSC_UNIT::proc()
{
    if (m_cfgFlgProc) {
        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [NORM]"
            << endl;
        procMain();
    }
    else {
        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::UNIT)
            cout << "  FRAME [" << setw(ceil(log10(m_cfg->numFrame))) << setfill('0') << m_cfg->idxFrame << "]"
                << " UNIT [" << setw(ceil(log10(m_cfg->numUnitY))) << setfill('0') << m_cfg->idxUnitY << "," << setw(ceil(log10(m_cfg->numUnitX))) << setfill('0') << m_cfg->idxUnitX << "]"
                << " LOAD [SKIP]"
            << endl;
    }
}

// dump
void MSC_UNIT::dump()
{
    dumpFile();
}
