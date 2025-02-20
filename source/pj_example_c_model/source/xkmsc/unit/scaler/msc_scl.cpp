//------------------------------------------------------------------------------
    //
    //  Filename       : msc_scl.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : scaler related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_scl.hpp"


//*** FUNCTION *****************************************************************
// MSC_SCL
MSC_SCL::MSC_SCL()
{
    // identification
    m_strTag = "MSC_SCL";
}

// ~MSC_SCL
//MSC_SCL::~MSC_SCL()
//{
//    // delete
//    //...
//}

// connect
void MSC_SCL::connect(
msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp)
{
    // basic
    MSC_UNIT::connect(cfg, fth, dmp);

    // other configurations
    m_cfgFlgProc =                m_cfg->sclFlgProc; assert(m_cfgFlgProc);    // !!! scl must be enabled
    m_cfgEnmLoad = (msc_enmLoad_t)m_cfg->sclEnmLoad;
}
