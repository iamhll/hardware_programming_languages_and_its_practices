//------------------------------------------------------------------------------
    //
    //  Filename       : calc_dmp.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : dumper related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_dmp.hpp"


//*** FUNCTION *****************************************************************
// CALC_DMP
//CALC_DMP::CALC_DMP()
//{
//}

// ~CALC_DMP
//CALC_DMP::~CALC_DMP()
//{
//}

// connect
void CALC_DMP::connect(
calc_dat_t (*datOut) [CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX])
{
    m_datOut = datOut;
}

// setRec
void CALC_DMP::setDatOut(
const calc_cfg_t &cfg, calc_dat_t datOut[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX])
{
    for (int k = 0; k < cfg.sizUnitZ; ++k) {
        for (int j = 0; j < cfg.sizUnitY; ++j) {
            for (int i = 0; i < cfg.sizUnitX; ++i)
                (*m_datOut)[k][cfg.idxUnitY * cfg.sizUnitY + j][cfg.idxUnitX * cfg.sizUnitX + i] = datOut[k][j][i];
        }
    }
}
