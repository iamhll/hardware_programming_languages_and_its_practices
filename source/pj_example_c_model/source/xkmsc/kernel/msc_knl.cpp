//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_knl.hpp"


//*** CLASS ********************************************************************
// MSC_KNL
MSC_KNL::MSC_KNL()
{
    // name
    m_strTag = "MSC_KNL";

    // data
    m_datIn  = (msc_pxl_t (*)[MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX])
        new     msc_pxl_t    [MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];
    m_datOut = (msc_pxl_t (*)[MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX])
        new     msc_pxl_t    [MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];
    memset(*m_datIn , 0, sizeof(*m_datIn ));
    memset(*m_datOut, 0, sizeof(*m_datOut));

    // osd
    m_datOsd = (msc_osd_t (*)[MSC_OSD_NUMB_MAX][MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX])
        new     msc_osd_t    [MSC_OSD_NUMB_MAX][MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];
    memset(*m_datOsd, 0, sizeof(*m_datOsd));
}

// ~MSC_KNL
MSC_KNL::~MSC_KNL()
{
    // data
    delete[] m_datIn ;
    delete[] m_datOut;

    // osd
    delete[] m_datOsd;
}

// connect
void MSC_KNL::connect(
msc_cfg_t &cfg)
{
    // cfg
    m_cfg = &cfg;

    // other modules
    m_fth.connect(m_datIn, m_datOsd);
    m_scl.connect(cfg, m_fth, m_dmp);
    m_flt.connect(cfg, m_fth, m_dmp, m_scl);
    m_osd.connect(cfg, m_fth, m_dmp, m_flt);
    m_dmp.connect(m_datOut);
}

// oneShot
void MSC_KNL::oneShot()
{
    updTic(enmFunc_t::LOAD); load(); updToc(enmFunc_t::LOAD);
    updTic(enmFunc_t::PROC); proc(); updToc(enmFunc_t::PROC);
    updTic(enmFunc_t::DUMP); dump(); updToc(enmFunc_t::DUMP);
}

// load
void MSC_KNL::load()
{
    if ((msc_enmLoad_t)m_cfg->enmLoad == msc_enmLoad_t::RANDOM)
        loadRand();
    else
        loadFile();
}

// process
void MSC_KNL::proc()
{
    procMain();
}

// dump
void MSC_KNL::dump()
{
    dumpFile();
}

// dspRunTime
void MSC_KNL::dspRunTime()
{
    #ifdef MSC_KNOB_TIME
    #ifdef __linux__
    cout << "run time of LOAD           is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::LOAD          ] / 1000 << " s" << endl;
    cout << "run time of PROC           is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC          ] / 1000 << " s" << endl;
    cout << "run time of PROC PREV      is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_PREV     ] / 1000 << " s" << endl;
    cout << "run time of PROC CORE      is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_CORE     ] / 1000 << " s" << endl;
    m_scl.dspRunTime();
    m_flt.dspRunTime();
    m_osd.dspRunTime();
    cout << "run time of PROC CORE MISC is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_CORE_MISC] / 1000 << " s" << endl;
    cout << "run time of PROC POST      is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::PROC_POST     ] / 1000 << " s" << endl;
    cout << "run time of DUMP           is " << setprecision(3) << (double)m_datTAcc[(int)enmFunc_t::DUMP          ] / 1000 << " s" << endl;
    cout << endl;
    #endif
    #endif
}
