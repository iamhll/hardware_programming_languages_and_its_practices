//------------------------------------------------------------------------------
    //
    //  Filename       : calc_unit_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related codes (dump)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_unit.hpp"


//*** FUNCTION *****************************************************************
// dumpFile
void CALC_UNIT::dumpFile()
{
    // dmpDatInp0
    if (   ((calc_enmDump_t)m_cfg->addEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_ADD")
        || ((calc_enmDump_t)m_cfg->subEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_SUB")
        || ((calc_enmDump_t)m_cfg->mulEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_MUL")
        || ((calc_enmDump_t)m_cfg->divEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_DIV")
    ) {
        dumpDatInp0();
    }

    // dumpDatInp1
    if (   ((calc_enmDump_t)m_cfg->addEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_ADD")
        || ((calc_enmDump_t)m_cfg->subEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_SUB")
        || ((calc_enmDump_t)m_cfg->mulEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_MUL")
        || ((calc_enmDump_t)m_cfg->divEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_DIV")
    ) {
        dumpDatInp1();
    }

    // dumpDatOut0
    if (   ((calc_enmDump_t)m_cfg->addEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_ADD")
        || ((calc_enmDump_t)m_cfg->subEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_SUB")
        || ((calc_enmDump_t)m_cfg->mulEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_MUL")
        || ((calc_enmDump_t)m_cfg->divEnmDump >= calc_enmDump_t::INOUT && m_strTag == "CALC_DIV")
    ) {
        dumpDatOut();
    }
}

// dumpDatInp0
void CALC_UNIT::dumpDatInp0()
{
    string strTag = m_strTag;
    string strObj = "dumpDatInp0";
    string strIdx = "";
    string strTyp = "S1I16F0";
    string strPst = "dat";
    int    datMsk = 0xffff;
    string strFmt = "%04x";
    int    sizX   = m_cfg->sizUnitX;
    int    sizY   = m_cfg->sizUnitY;
    int    sizZ   = m_cfg->sizUnitZ;
    int    idxDlt = 1;
    CALC_FUNC_DMP_D_3(m_cfg
        ,             m_dmpDatInp0Flg
        ,             m_dmpDatInp0Fpt
        ,             strTag, strObj, strIdx, strTyp, strPst
        ,             (*m_datInp0)
        ,             datMsk, strFmt
        ,             sizZ, idxDlt
        ,             sizY, idxDlt
        ,             sizX, idxDlt
    );
}

// dumpDatInp1
void CALC_UNIT::dumpDatInp1()
{
    string strTag = m_strTag;
    string strObj = "dumpDatInp1";
    string strIdx = "";
    string strTyp = "S1I16F0";
    string strPst = "dat";
    int    datMsk = 0xffff;
    string strFmt = "%04x";
    int    sizX   = m_cfg->sizUnitX;
    int    sizY   = m_cfg->sizUnitY;
    int    sizZ   = m_cfg->sizUnitZ;
    int    idxDlt = 1;
    CALC_FUNC_DMP_D_3(m_cfg
        ,             m_dmpDatInp1Flg
        ,             m_dmpDatInp1Fpt
        ,             strTag, strObj, strIdx, strTyp, strPst
        ,             (*m_datInp1)
        ,             datMsk, strFmt
        ,             sizZ, idxDlt
        ,             sizY, idxDlt
        ,             sizX, idxDlt
    );
}

// dumpDatOut
void CALC_UNIT::dumpDatOut()
{
    string strTag = m_strTag;
    string strObj = "dumpDatOut";
    string strIdx = "";
    string strTyp = "S1I16F0";
    string strPst = "dat";
    int    datMsk = 0xffff;
    string strFmt = "%04x";
    int    sizX   = m_cfg->sizUnitX;
    int    sizY   = m_cfg->sizUnitY;
    int    sizZ   = m_cfg->sizUnitZ;
    int    idxDlt = 1;
    CALC_FUNC_DMP_D_3(m_cfg
        ,             m_dmpDatOutFlg
        ,             m_dmpDatOutFpt
        ,             strTag, strObj, strIdx, strTyp, strPst
        ,             (*m_datOut)
        ,             datMsk, strFmt
        ,             sizZ, idxDlt
        ,             sizY, idxDlt
        ,             sizX, idxDlt
    );
}
