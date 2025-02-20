//------------------------------------------------------------------------------
    //
    //  Filename       : msc_dmp.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : dumper related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_dmp.hpp"


//*** FUNCTION *****************************************************************
// MSC_DMP
//MSC_DMP::MSC_DMP()
//{
//}

// ~MSC_DMP
//MSC_DMP::~MSC_DMP()
//{
//}

// connect
void MSC_DMP::connect(
msc_pxl_t (*datOut) [MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX])
{
    m_datOut = datOut;
}

// setDatOut
void MSC_DMP::setDatOut(
const msc_cfg_t &cfg, msc_pxl_t datOut[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX])
{
    for (int k = 0; k < cfg.sizFrameZ; ++k) {
        int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
        for (int j = 0; j < cfg.sizUnitY >> datShift; ++j) {
            for (int i = 0; i < cfg.sizUnitX >> datShift; ++i)
                (*m_datOut)[k][cfg.idxUnitY * (cfg.sizUnitY >> datShift) + j][cfg.idxUnitX * (cfg.sizUnitX >> datShift) + i] = datOut[k][j][i];
        }
    }
}
