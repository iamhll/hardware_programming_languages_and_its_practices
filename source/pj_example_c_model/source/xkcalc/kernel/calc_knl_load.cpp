//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_knl.hpp"


//*** FUNCTION *****************************************************************
// loadFile
void CALC_KNL::loadFile()
{
    loadFileInp();
}

// loadFileInp
void CALC_KNL::loadFileInp()
{
    // open file
    if (!m_loadFileInpFlg) {
        m_loadFileInpFlg = 1;
        m_loadFileInpFpt = fopen(m_cfg->strFileInp.c_str(), "r");
        if (m_loadFileInpFpt == NULL) {
            cerr << "[error from c model] cannot open input file [" << m_cfg->strFileInp.c_str() << "]!" << endl;
            assert(0);
        }
    }

    // read data
    for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
        for (int j = 0; j < m_cfg->sizFrameY; ++j) {
            for (int i = 0; i < m_cfg->sizFrameX; ++i) {
                int numInp = fscanf(m_loadFileInpFpt, "%hx", &(*m_datInp)[k][j][i]);
                if (numInp != 1) {
                    cerr << "[error from c model] cannot read enough data from the input file!" << endl;
                    assert(0);
                }
            }
        }
    }
}

// loadRand
void CALC_KNL::loadRand()
{
    loadRandInp();
}

// loadRandInp
void CALC_KNL::loadRandInp()
{
    // read data
    for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
        for (int j = 0; j < m_cfg->sizFrameY; ++j) {
            for (int i = 0; i < m_cfg->sizFrameX; ++i)
                (*m_datInp)[k][j][i] = rand();
        }
    }
}
