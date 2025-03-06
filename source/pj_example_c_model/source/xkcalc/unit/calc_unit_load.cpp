//------------------------------------------------------------------------------
    //
    //  Filename       : calc_unit_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_unit.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void CALC_UNIT::loadPipe()
{
    // datInp
    m_fth->cpyDatInp(*m_datInp0, *m_cfg);
}

// loadFile
void CALC_UNIT::loadFile()
{
    //...
}

// loadRand
void CALC_UNIT::loadRand()
{
    //...
}
