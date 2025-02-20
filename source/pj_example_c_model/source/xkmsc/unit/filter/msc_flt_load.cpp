//------------------------------------------------------------------------------
    //
    //  Filename       : msc_flt_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : filter related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_flt.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void MSC_FLT::loadPipe()
{
    // basic
    //MSC_UNIT::loadPipe();

    // m_datIn
    m_unitPrev->cpyDatOut(*m_datIn);
    if (!m_cfg->fltFlgProc) {
        for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
            int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
            for (int j = 0; j < m_cfg->sizUnitY >> datShift; ++j) {
                for (int i = 0; i < m_cfg->sizUnitX >> datShift; ++i)
                    (*m_datOut)[k][j][i] = (*m_datIn)[k][MSC_FLT_SIZE + j][MSC_FLT_SIZE + i];
            }
        }
    }
}

// loadFile
//void MSC_FLT::loadFile()
//{
//    // basic
//    MSC_UNIT::loadFile();
//
//    //...
//}

//// loadRand
//void MSC_FLT::loadRand()
//{
//    // basic
//    MSC_UNIT::loadRand();
//
//    //...
//}
