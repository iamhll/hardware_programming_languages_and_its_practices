//------------------------------------------------------------------------------
    //
    //  Filename       : calc_sub.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : substrator related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_sub.hpp"


//*** FUNCTION *****************************************************************
// CALC_SUB
CALC_SUB::CALC_SUB()
{
    // identification
    m_strTag = "CALC_SUB";
}

// ~CALC_SUB
//CALC_SUB::~CALC_SUB()
//{
//    // delete
//    //...
//}

// connect
void CALC_SUB::connect(
calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp, CALC_UNIT &unit)
{
    // basic
    CALC_UNIT::connect(cfg, fth, dmp);

    // other modules
    m_unitPrev = &unit;

    // other configurations
    m_cfgFlgProc =                 m_cfg->subFlgProc;
    m_cfgEnmLoad = (calc_enmLoad_t)m_cfg->subEnmLoad;
}
