//------------------------------------------------------------------------------
    //
    //  Filename       : msc_unit_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related codes (dump)
    //
//------------------------------------------------------------------------------

// TODO: split Y U and V


//*** INCLUDE ******************************************************************
#include "msc_unit.hpp"


//*** FUNCTION *****************************************************************
// dumpFile
void MSC_UNIT::dumpFile()
{
    // dmpDatIn
    if (   ((msc_enmDump_t)m_cfg->sclEnmDump >= msc_enmDump_t::INOUT && m_strTag == "MSC_SCL")
        || ((msc_enmDump_t)m_cfg->fltEnmDump >= msc_enmDump_t::INOUT && m_strTag == "MSC_FLT")
        || ((msc_enmDump_t)m_cfg->osdEnmDump >= msc_enmDump_t::INOUT && m_strTag == "MSC_OSD")
    ) {
        dumpDatIn();
    }

    // dumpDatOut
    if (   ((msc_enmDump_t)m_cfg->sclEnmDump >= msc_enmDump_t::INOUT && m_strTag == "MSC_SCL")
        || ((msc_enmDump_t)m_cfg->fltEnmDump >= msc_enmDump_t::INOUT && m_strTag == "MSC_FLT")
        || ((msc_enmDump_t)m_cfg->osdEnmDump >= msc_enmDump_t::INOUT && m_strTag == "MSC_OSD")
    ) {
        dumpDatOut();
    }
}

// dumpDatIn
void MSC_UNIT::dumpDatIn()
{
    string strTag = m_strTag;
    string strObj = "dumpDatIn";
    string strIdx = "";
    string strTyp = "S1I16F0";
    string strPst = "dat";
    int    datMsk = 0xff;
    string strFmt = "%02x";
    int    sizX   = m_cfg->sizUnitX;
    int    sizY   = m_cfg->sizUnitY;
    int    sizZ   = m_cfg->sizFrameZ;
    int    idxDlt = 1;
    MSC_FUNC_DMP_D_3(m_cfg
        ,            m_dmpDatInFlg
        ,            m_dmpDatInFpt
        ,            strTag, strObj, strIdx, strTyp, strPst
        ,            (*m_datIn)
        ,            datMsk, strFmt
        ,            sizZ, idxDlt
        ,            sizY, idxDlt
        ,            sizX, idxDlt
    );
}

// dumpDatOut
void MSC_UNIT::dumpDatOut()
{
    string strTag = m_strTag;
    string strObj = "dumpDatOut";
    string strIdx = "";
    string strTyp = "S1I16F0";
    string strPst = "dat";
    int    datMsk = 0xff;
    string strFmt = "%02x";
    int    sizX   = m_cfg->sizUnitX;
    int    sizY   = m_cfg->sizUnitY;
    int    sizZ   = m_cfg->sizFrameZ;
    int    idxDlt = 1;
    MSC_FUNC_DMP_D_3(m_cfg
        ,            m_dmpDatOutFlg
        ,            m_dmpDatOutFpt
        ,            strTag, strObj, strIdx, strTyp, strPst
        ,            (*m_datOut)
        ,            datMsk, strFmt
        ,            sizZ, idxDlt
        ,            sizY, idxDlt
        ,            sizX, idxDlt
    );
}
