//------------------------------------------------------------------------------
    //
    //  Filename       : msc_unit_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_unit.hpp"


//*** FUNCTION *****************************************************************
// loadPipe
void MSC_UNIT::loadPipe()
{
    // datIn
    m_fth->cpyDatIn(*m_datIn, *m_cfg);
}

// loadFile
void MSC_UNIT::loadFile()
{
    //...
}

// loadRand
void MSC_UNIT::loadRand()
{
    //...
}
