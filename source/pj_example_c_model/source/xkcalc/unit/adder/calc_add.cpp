//------------------------------------------------------------------------------
    //
    //  Filename       : calc_add.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : adder related codes (top)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_add.hpp"


//*** FUNCTION *****************************************************************
// CALC_ADD
CALC_ADD::CALC_ADD()
{
    // identification
    m_strTag = "CALC_ADD";
}

// ~CALC_ADD
//CALC_ADD::~CALC_ADD()
//{
//    // delete
//    //...
//}

// connect
void CALC_ADD::connect(
calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp)
{
    // basic
    CALC_UNIT::connect(cfg, fth, dmp);

    // other configurations
    m_cfgFlgProc =                 m_cfg->addFlgProc;
    m_cfgEnmLoad = (calc_enmLoad_t)m_cfg->addEnmLoad;
}
