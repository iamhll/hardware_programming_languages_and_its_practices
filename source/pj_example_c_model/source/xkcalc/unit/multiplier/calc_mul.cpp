//------------------------------------------------------------------------------
    //
    //  Filename       : calc_mul.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : multiplier related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_mul.hpp"


//*** FUNCTION *****************************************************************
// CALC_MUL
CALC_MUL::CALC_MUL()
{
    // identification
    m_strTag = "CALC_MUL";
}

// ~CALC_MUL
//CALC_MUL::~CALC_MUL()
//{
//    // delete
//    //...
//}

// connect
void CALC_MUL::connect(
calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp, CALC_UNIT &unit)
{
    // basic
    CALC_UNIT::connect(cfg, fth, dmp);

    // other modules
    m_unitPrev = &unit;

    // other configurations
    m_cfgFlgProc =                 m_cfg->mulFlgProc;
    m_cfgEnmLoad = (calc_enmLoad_t)m_cfg->mulEnmLoad;
}
