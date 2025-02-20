//------------------------------------------------------------------------------
    //
    //  Filename       : msc_scl_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : scaler related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_scl.hpp"


//*** FUNCTION *****************************************************************
// procPrev
//void MSC_SCL::procPrev()
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
void MSC_SCL::procCore()
{
    procCoreScl();
}

// procPost
void MSC_SCL::procPost()
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
        if (!m_cfg->fltFlgProc && !m_cfg->osdFlgProc)
            m_dmp->setDatOut(*m_cfg, (msc_pxl_t (*)[MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX])&(*m_datOut)[0][MSC_FLT_SIZE][MSC_FLT_SIZE]);
    }
}
