//------------------------------------------------------------------------------
    //
    //  Filename       : calc_xor.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2026-03-03
    //  Description    : xor related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_xor.hpp"


//*** FUNCTION *****************************************************************
// CALC_XOR
CALC_XOR::CALC_XOR()
{
    // identification
    m_strTag = "CALC_XOR";
}

// ~CALC_XOR
//CALC_XOR::~CALC_XOR()
//{
//    // delete
//    //...
//}

// connect
void CALC_XOR::connect(
calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp, CALC_UNIT &unit)
{
    // basic
    CALC_UNIT::connect(cfg, fth, dmp);

    // other modules
    m_unitPrev = &unit;

    // other configurations
    m_cfgFlgProc =                 m_cfg->xorFlgProc;
    m_cfgEnmLoad = (calc_enmLoad_t)m_cfg->xorEnmLoad;
}
