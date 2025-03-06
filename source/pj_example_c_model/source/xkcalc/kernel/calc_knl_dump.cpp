//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (dump)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_knl.hpp"


//*** FUNCTION *****************************************************************
// dumpFile
void CALC_KNL::dumpFile()
{
    // dumpFileOut
    dumpFileOut();
}

// dumpFileOut
void CALC_KNL::dumpFileOut()
{
    if (m_cfg->strFileOut != "") {
        // open file
        if (m_dumpFileOutFlg == 0) {
            m_dumpFileOutFlg = 1;
            m_dumpFileOutFpt = fopen(m_cfg->strFileOut.c_str(), "w");
            if (m_dumpFileOutFpt == NULL) {
                cerr << "[error from c model] cannot open output file [" << m_cfg->strFileOut.c_str() << "]!" << endl;
                assert(0);
            }
        }

        // dump data
        for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
            for (int j = 0; j < m_cfg->sizFrameY; ++j) {
                for (int i = 0; i < m_cfg->sizFrameX; ++i) {
                    if (i == m_cfg->sizFrameX - 1)
                        fprintf(m_dumpFileOutFpt, "%04x\n", (*m_datOut)[k][j][i] & 0xffff);
                    else
                        fprintf(m_dumpFileOutFpt, "%04x " , (*m_datOut)[k][j][i] & 0xffff);
                }
            }
        }
    }
}
