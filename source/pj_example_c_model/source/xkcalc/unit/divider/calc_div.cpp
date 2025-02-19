//------------------------------------------------------------------------------
    //
    //  Filename       : calc_div.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : divider related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_div.hpp"


//*** FUNCTION *****************************************************************
// CALC_DIV
CALC_DIV::CALC_DIV()
{
    // identification
    m_strTag = "CALC_DIV";
}

// ~CALC_DIV
//CALC_DIV::~CALC_DIV()
//{
//    // delete
//    //...
//}

// connect
void CALC_DIV::connect(
calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp, CALC_UNIT &unit)
{
    // basic
    CALC_UNIT::connect(cfg, fth, dmp);

    // other modules
    m_unitPrev = &unit;

    // other configurations
    m_cfgFlgProc =                 m_cfg->divFlgProc;
    m_cfgEnmLoad = (calc_enmLoad_t)m_cfg->divEnmLoad;
}
