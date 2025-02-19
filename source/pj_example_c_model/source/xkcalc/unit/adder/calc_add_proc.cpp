//------------------------------------------------------------------------------
    //
    //  Filename       : calc_add_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : adder related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_add.hpp"


//*** FUNCTION *****************************************************************
// procPrev
void CALC_ADD::procPrev()
{
    // basic
    CALC_UNIT::procPrev();

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
        for (int k = 0; k < m_cfg->sizUnitZ; ++k) {
            for (int j = 0; j < m_cfg->sizUnitY; ++j) {
                for (int i = 0; i < m_cfg->sizUnitX; ++i)
                    (*m_datInp1)[k][j][i] = rand();
            }
        }
    }
}

// procCore
void CALC_ADD::procCore()
{
    procCoreAdd();
}

// procPost
//void CALC_ADD::procPost()
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
