//------------------------------------------------------------------------------
    //
    //  Filename       : calc_div_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : divider related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_div.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void CALC_DIV::loadPipe()
{
    // basic
    CALC_UNIT::loadPipe();

    // data
    m_unitPrev->cpyDatOut(*m_datInp1);
}

// loadFile
//void CALC_DIV::loadFile()
//{
//    // basic
//    CALC_UNIT::loadFile();
//
//    //...
//}

//// loadRand
//void CALC_DIV::loadRand()
//{
//    // basic
//    CALC_UNIT::loadRand();
//
//    //...
//}
