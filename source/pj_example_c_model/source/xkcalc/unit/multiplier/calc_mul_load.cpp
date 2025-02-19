//------------------------------------------------------------------------------
    //
    //  Filename       : calc_mul_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : multiplier related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_mul.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void CALC_MUL::loadPipe()
{
    // basic
    CALC_UNIT::loadPipe();

    // data
    m_unitPrev->cpyDatOut(*m_datInp1);
}

// loadFile
//void CALC_MUL::loadFile()
//{
//    // basic
//    CALC_UNIT::loadFile();
//
//    //...
//}

//// loadRand
//void CALC_MUL::loadRand()
//{
//    // basic
//    CALC_UNIT::loadRand();
//
//    //...
//}
