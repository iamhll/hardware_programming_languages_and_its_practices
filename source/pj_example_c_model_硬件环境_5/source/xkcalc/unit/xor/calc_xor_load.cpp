//------------------------------------------------------------------------------
    //
    //  Filename       : calc_xor_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2026-03-03
    //  Description    : xor related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_xor.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void CALC_XOR::loadPipe()
{
    // basic
    CALC_UNIT::loadPipe();

    // data
    m_unitPrev->cpyDatOut(*m_datInp1);
}

// loadFile
//void CALC_XOR::loadFile()
//{
//    // basic
//    CALC_UNIT::loadFile();
//
//    //...
//}

//// loadRand
//void CALC_XOR::loadRand()
//{
//    // basic
//    CALC_UNIT::loadRand();
//
//    //...
//}
