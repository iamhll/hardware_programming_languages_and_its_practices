//------------------------------------------------------------------------------
    //
    //  Filename       : calc_div_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : divider related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_div.hpp"


//*** FUNCTION *****************************************************************
// procPrev
//void CALC_DIV::procPrev()
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
void CALC_DIV::procCore()
{
    procCoreDiv();
}

// procPost
void CALC_DIV::procPost()
{
    // basic
    CALC_UNIT::procPost();

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
        m_dmp->setDatOut(*m_cfg, *m_datOut);
    }
}
