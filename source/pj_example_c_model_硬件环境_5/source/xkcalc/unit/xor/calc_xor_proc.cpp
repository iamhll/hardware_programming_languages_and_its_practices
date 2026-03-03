//------------------------------------------------------------------------------
    //
    //  Filename       : calc_xor_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2026-03-03
    //  Description    : xor related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_xor.hpp"


//*** FUNCTION *****************************************************************
// procPrev
//void CALC_XOR::procPrev()
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
void CALC_XOR::procCore()
{
    procCoreXor();
}

// procPost
//void CALC_XOR::procPost()
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
