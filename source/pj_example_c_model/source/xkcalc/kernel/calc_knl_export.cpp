//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl_export.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (export)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_knl.hpp"
#include "calc_knl_export.hpp"


//*** CLASS ********************************************************************
// CALC_KNL_EXPORT
CALC_KNL_EXPORT::CALC_KNL_EXPORT()
{
    m_knl = new CALC_KNL;
}

// ~CALC_KNL_EXPORT
CALC_KNL_EXPORT::~CALC_KNL_EXPORT()
{
    delete m_knl;
}

// connect
void CALC_KNL_EXPORT::connect(
calc_cfg_t &cfg)
{
    m_knl->connect(cfg);
}

// oneShot
void CALC_KNL_EXPORT::oneShot()
{
    m_knl->oneShot();
}

// dspRunTime
void CALC_KNL_EXPORT::dspRunTime()
{
    m_knl->dspRunTime();
}
