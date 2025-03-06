//------------------------------------------------------------------------------
    //
    //  Filename       : calc_fth.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : fetcher related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_fth.hpp"


//*** FUNCTION *****************************************************************
// CALC_FTH
//CALC_FTH::CALC_FTH()
//{
//}

// CALC_FTH
//CALC_FTH::~CALC_FTH()
//{
//}

// connect
void CALC_FTH::connect(
calc_dat_t (*datInp) [CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX])
{
    m_datInp = datInp;
}

// cpyDatInp
void CALC_FTH::cpyDatInp(calc_dat_t datInp[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX],
const calc_cfg_t &cfg)
{
    for (int k = 0; k < cfg.sizUnitZ; ++k) {
        for (int j = 0; j < cfg.sizUnitY; ++j) {
            for (int i = 0; i < cfg.sizUnitX; ++i)
                datInp[k][j][i] = (*m_datInp)[k][cfg.idxUnitY * cfg.sizUnitY + j][cfg.idxUnitX * cfg.sizUnitX + i];
        }
    }
}
