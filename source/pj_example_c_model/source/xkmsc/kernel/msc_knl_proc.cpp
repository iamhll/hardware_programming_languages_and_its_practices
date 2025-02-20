//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_knl.hpp"


//*** FUNCTION *****************************************************************
// procMain
void MSC_KNL::procMain()
{
    updTic(enmFunc_t::PROC_PREV); procPrev(); updToc(enmFunc_t::PROC_PREV);
    updTic(enmFunc_t::PROC_CORE); procCore(); updToc(enmFunc_t::PROC_CORE);
    updTic(enmFunc_t::PROC_POST); procPost(); updToc(enmFunc_t::PROC_POST);
}

// procPrev
void MSC_KNL::procPrev()
{
    // log
    if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::KERNEL)
        cout << "processing frame " << setw(4) << setfill('0') << m_cfg->idxFrame << endl;
}

// procCore
void MSC_KNL::procCore()
{
    // loop each unit
    for (m_cfg->idxUnitY = 0; m_cfg->idxUnitY < m_cfg->numUnitY; ++m_cfg->idxUnitY) {
        for (m_cfg->idxUnitX = 0; m_cfg->idxUnitX < m_cfg->numUnitX; ++m_cfg->idxUnitX) {
            // scl
            m_scl.oneShot();

            // flt
            m_flt.oneShot();

            // osd
            m_osd.oneShot();
        }
    }
}

// procPost
void MSC_KNL::procPost()
{
    // log
    if (   ((msc_enmInfo_t)m_cfg->enmInfo == msc_enmInfo_t::KERNEL && (m_cfg->idxFrame == m_cfg->numFrame - 1))
        ||  (msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::UNIT
    ) {
        cout << endl;
    }
}
