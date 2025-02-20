//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_export.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (export)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_knl.hpp"
#include "msc_knl_export.hpp"


//*** CLASS ********************************************************************
// MSC_KNL_EXPORT
MSC_KNL_EXPORT::MSC_KNL_EXPORT()
{
    m_knl = new MSC_KNL;
}

// ~MSC_KNL_EXPORT
MSC_KNL_EXPORT::~MSC_KNL_EXPORT()
{
    delete m_knl;
}

// connect
void MSC_KNL_EXPORT::connect(
msc_cfg_t &cfg)
{
    m_knl->connect(cfg);
}

// oneShot
void MSC_KNL_EXPORT::oneShot()
{
    m_knl->oneShot();
}

// dspRunTime
void MSC_KNL_EXPORT::dspRunTime()
{
    m_knl->dspRunTime();
}
