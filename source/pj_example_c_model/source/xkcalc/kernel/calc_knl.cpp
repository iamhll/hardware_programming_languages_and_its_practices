//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_knl.hpp"


//*** CLASS ********************************************************************
// CALC_KNL
CALC_KNL::CALC_KNL()
{
    // name
    m_strTag = "CALC_KNL";

    // data
    m_datInp = (calc_dat_t (*)[CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX])
        new     calc_dat_t    [CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX];
    m_datOut = (calc_dat_t (*)[CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX])
        new     calc_dat_t    [CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX];
    memset(*m_datInp, 0, sizeof(*m_datInp));
    memset(*m_datOut, 0, sizeof(*m_datOut));
}

// ~CALC_KNL
CALC_KNL::~CALC_KNL()
{
    delete[] m_datInp;
    delete[] m_datOut;
}

// connect
void CALC_KNL::connect(
calc_cfg_t &cfg)
{
    // cfg
    m_cfg = &cfg;

    // other module
    m_fth.connect(m_datInp);
    m_add.connect(cfg, m_fth, m_dmp);
    m_sub.connect(cfg, m_fth, m_dmp, m_add);
    m_mul.connect(cfg, m_fth, m_dmp, m_sub);
    m_div.connect(cfg, m_fth, m_dmp, m_mul);
    m_dmp.connect(m_datOut);
}

// oneShot
void CALC_KNL::oneShot()
{
    updTic(enmFunc_t::LOAD); load(); updToc(enmFunc_t::LOAD);
    updTic(enmFunc_t::PROC); proc(); updToc(enmFunc_t::PROC);
    updTic(enmFunc_t::DUMP); dump(); updToc(enmFunc_t::DUMP);
}

// load
void CALC_KNL::load()
{
    if ((calc_enmLoad_t)m_cfg->enmLoad == calc_enmLoad_t::RANDOM)
        loadRand();
    else
        loadFile();
}

// process
void CALC_KNL::proc()
{
    procMain();
}

// dump
void CALC_KNL::dump()
{
    dumpFile();
}

// dspRunTime
void CALC_KNL::dspRunTime()
{
    #ifdef CALC_KNOB_TIME
    #ifdef __linux__
    cout << "run time of LOAD           is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::LOAD          ] / 1000 << " s" << endl;
    cout << "run time of PROC           is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC          ] / 1000 << " s" << endl;
    cout << "run time of PROC PREV      is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_PREV     ] / 1000 << " s" << endl;
    cout << "run time of PROC CORE      is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_CORE     ] / 1000 << " s" << endl;
    m_add.dspRunTime();
    m_sub.dspRunTime();
    m_mul.dspRunTime();
    m_div.dspRunTime();
    cout << "run time of PROC CORE MISC is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_CORE_MISC] / 1000 << " s" << endl;
    cout << "run time of PROC POST      is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_POST     ] / 1000 << " s" << endl;
    cout << "run time of DUMP           is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::DUMP          ] / 1000 << " s" << endl;
    cout << endl;
    #endif
    #endif
}
