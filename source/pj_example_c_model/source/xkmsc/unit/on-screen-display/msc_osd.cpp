//------------------------------------------------------------------------------
    //
    //  Filename       : msc_osd.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : on-screen-display related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_osd.hpp"


//*** FUNCTION *****************************************************************
// MSC_OSD
MSC_OSD::MSC_OSD()
{
    // identification
    m_strTag = "MSC_OSD";

    // data
    m_datOsd = (msc_osd_t (*)[MSC_SIZE_UNIT_Z_MAX + 1][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX])
        new     msc_osd_t    [MSC_SIZE_UNIT_Z_MAX + 1][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX];
    memset(*m_datOsd, 0, sizeof(*m_datOsd));
}

// ~MSC_OSD
MSC_OSD::~MSC_OSD()
{
    // data
    delete[] m_datOsd;
}

// connect
void MSC_OSD::connect(
msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp, MSC_UNIT &unitPrev)
{
    // basic
    MSC_UNIT::connect(cfg, fth, dmp);

    // other modules
    m_unitPrev = &unitPrev;

    // other configurations
    m_cfgFlgProc =                m_cfg->osdFlgProc;
    m_cfgEnmLoad = (msc_enmLoad_t)m_cfg->osdEnmLoad;
}
