//------------------------------------------------------------------------------
    //
    //  Filename       : calc_sub_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : substrator related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_sub.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void CALC_SUB::loadPipe()
{
    // basic
    CALC_UNIT::loadPipe();

    // data
    m_unitPrev->cpyDatOut(*m_datInp1);
}

// loadFile
//void CALC_SUB::loadFile()
//{
//    // basic
//    CALC_UNIT::loadFile();
//
//    //...
//}

//// loadRand
//void CALC_SUB::loadRand()
//{
//    // basic
//    CALC_UNIT::loadRand();
//
//    //...
//}
