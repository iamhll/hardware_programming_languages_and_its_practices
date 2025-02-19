//------------------------------------------------------------------------------
    //
    //  Filename       : calc_sub_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : substrator related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_sub.hpp"


//*** FUNCTION *****************************************************************
// procPrev
//void CALC_SUB::procPrev()
//{
//    // basic
//    CALC_UNIT::procPrev();
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
void CALC_SUB::procCore()
{
    procCoreSub();
}

// procPost
//void CALC_SUB::procPost()
//{
//    // basic
//    CALC_UNIT::procPost();
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
