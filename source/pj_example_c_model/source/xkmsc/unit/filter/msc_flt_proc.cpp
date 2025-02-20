//------------------------------------------------------------------------------
    //
    //  Filename       : msc_flt_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : filter related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_flt.hpp"


//*** FUNCTION *****************************************************************
// procPrev
//void MSC_FLT::procPrev()
//{
//    // basic
//    MSC_UNIT::procPrev();
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
void MSC_FLT::procCore()
{
    procCoreFlt();
}

// procPost
void MSC_FLT::procPost()
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
        if (!m_cfg->osdFlgProc)
            m_dmp->setDatOut(*m_cfg, *m_datOut);
    }
}
