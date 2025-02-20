//------------------------------------------------------------------------------
    //
    //  Filename       : msc_flt.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : filter related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_flt.hpp"


//*** FUNCTION *****************************************************************
// MSC_FLT
MSC_FLT::MSC_FLT()
{
    // identification
    m_strTag = "MSC_FLT";
}

// ~MSC_FLT
//MSC_FLT::~MSC_FLT()
//{
//    // delete
//    //...
//}

// connect
void MSC_FLT::connect(
msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp, MSC_UNIT &unitPrev)
{
    // basic
    MSC_UNIT::connect(cfg, fth, dmp);

    // other modules
    m_unitPrev = &unitPrev;

    // other configurations
    m_cfgFlgProc =                m_cfg->fltFlgProc;
    m_cfgEnmLoad = (msc_enmLoad_t)m_cfg->fltEnmLoad;
}
