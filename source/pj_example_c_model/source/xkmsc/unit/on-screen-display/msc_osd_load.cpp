//------------------------------------------------------------------------------
    //
    //  Filename       : msc_osd_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : on-screen-display related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_osd.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void MSC_OSD::loadPipe()
{
    // !!! a special case
    // m_flgRun, m_idxRun
    m_flgRun = 0;
    for (int idxOsd = 0; idxOsd < MSC_OSD_NUMB_MAX; ++idxOsd) {
        m_flgRun =                                                 m_cfg->osdFlg      [idxOsd]
            &&     ( m_cfg->idxUnitX      * m_cfg->sizUnitX     >= m_cfg->osdPosFrameX[idxOsd]                                                            )
            &&     ((m_cfg->idxUnitX + 1) * m_cfg->sizUnitX - 1 <= m_cfg->osdPosFrameX[idxOsd] + m_cfg->osdSizFrameX[idxOsd] * m_cfg->osdDatScl[idxOsd][0])
            &&     ( m_cfg->idxUnitY      * m_cfg->sizUnitY     >= m_cfg->osdPosFrameY[idxOsd]                                                            )
            &&     ((m_cfg->idxUnitY + 1) * m_cfg->sizUnitY - 1 <= m_cfg->osdPosFrameY[idxOsd] + m_cfg->osdSizFrameY[idxOsd] * m_cfg->osdDatScl[idxOsd][1])
        ;
        if (m_flgRun) {
            m_idxRun = idxOsd;
            break;
        }
    }

    // basic
    //MSC_UNIT::loadPipe();

    // m_datIn
    m_unitPrev->cpyDatOut(*m_datIn);

    // m_datOsd
    if (m_flgRun)
        m_fth->cpyDatOsd(*m_datOsd, *m_cfg, m_idxRun);
}

// loadFile
//void MSC_OSD::loadFile()
//{
//    // basic
//    MSC_UNIT::loadFile();
//
//    //...
//}

//// loadRand
//void MSC_OSD::loadRand()
//{
//    // basic
//    MSC_UNIT::loadRand();
//
//    //...
//}
