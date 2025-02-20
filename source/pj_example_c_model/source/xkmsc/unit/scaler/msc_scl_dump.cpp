//------------------------------------------------------------------------------
    //
    //  Filename       : msc_scl_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : scaler related codes (dump)
    //
//------------------------------------------------------------------------------

// TODO: split dump of Y U and V


//*** INCLUDE ******************************************************************
#include "msc_scl.hpp"


//*** FUNCTION *****************************************************************
// dumpFile
//void MSC_SCL::dumpFile()
//{
//    // basic
//    MSC_UNIT::dumpFile();
//
//    //...
//}

// dumpDatIn
void MSC_SCL::dumpDatIn()
{
    string strTag = m_strTag;
    string strObj = "dumpDatIn";
    string strIdx = "";
    string strTyp = "S1I16F0";
    string strPst = "dat";
    int    datMsk = 0xff;
    string strFmt = "%02x";
    // !!! up to 3 extra pixels would be introduced to the 4 tap scaling
    int    sizX   = m_cfg->sizUnitX + 3;
    int    sizY   = m_cfg->sizUnitY + 3;
    int    sizZ   = m_cfg->sizFrameZ;
    int    idxDlt = 1;
    MSC_FUNC_DMP_D_3(m_cfg
        ,            m_dmpDatInFlg
        ,            m_dmpDatInFpt
        ,            strTag, strObj, strIdx, strTyp, strPst
        ,            ((msc_pxl_t (*)[MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX])&(*m_datIn)[0][0][0])
        ,            datMsk, strFmt
        ,            sizZ, idxDlt
        ,            sizY, idxDlt
        ,            sizX, idxDlt
    );
}
