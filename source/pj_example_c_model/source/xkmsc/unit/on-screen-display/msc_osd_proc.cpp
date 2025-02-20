//------------------------------------------------------------------------------
    //
    //  Filename       : msc_osd_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : on-screen-display related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_osd.hpp"


//*** FUNCTION *****************************************************************
// procPrev
//void MSC_OSD::procPrev()
//{
//    // basic
//    UNIT::procPrev();
//
//    // for the first unit
//    static bool flag = 1;
//    if (flag) {
//        // clear flag
//        flag = 0;
//
//        //...
//    }
//
//    // for the first unit in each frame
//    if (m_cfg->idxUnitX == 0 && m_cfg->idxUnitY == 0) {
//        //...
//    }
//
//    // for each unit
//    {
//        //...
//    }
//}

// procCore
void MSC_OSD::procCore()
{
    procCoreOsd();
}

// procPost
void MSC_OSD::procPost()
{
    // basic
    MSC_UNIT::procPost();

    // for the first unit
    static bool flag = 1;
    if (flag) {
        // clear flag
        flag = 0;

        //...
    }

    // for the first unit in each frame
    if (m_cfg->idxUnitX == 0 && m_cfg->idxUnitY == 0) {
        //...
    }

    // for each unit
    {
        if (m_cfg->osdFlgProc)
            m_dmp->setDatOut(*m_cfg, *m_datOut);
    }
}
