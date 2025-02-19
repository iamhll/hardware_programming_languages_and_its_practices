//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl_proc.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (proc)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_knl.hpp"


//*** FUNCTION *****************************************************************
// procMain
void CALC_KNL::procMain()
{
    updTic(enmFunc_t::PROC_PREV); procPrev(); updToc(enmFunc_t::PROC_PREV);
    updTic(enmFunc_t::PROC_CORE); procCore(); updToc(enmFunc_t::PROC_CORE);
    updTic(enmFunc_t::PROC_POST); procPost(); updToc(enmFunc_t::PROC_POST);
}

// procPrev
void CALC_KNL::procPrev()
{
    // log
    if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::KERNEL)
        cout << "processing frame " << setw(4) << setfill('0') << m_cfg->idxFrame << endl;
}

// procCore
void CALC_KNL::procCore()
{
    // loop each unit
    for (m_cfg->idxUnitY = 0; m_cfg->idxUnitY < m_cfg->numUnitY; ++m_cfg->idxUnitY) {
        for (m_cfg->idxUnitX = 0; m_cfg->idxUnitX < m_cfg->numUnitX; ++m_cfg->idxUnitX) {
            // add
            m_add.oneShot();

            // sub
            m_sub.oneShot();

            // mul
            m_mul.oneShot();

            // div
            m_div.oneShot();
        }
    }
}

// procPost
void CALC_KNL::procPost()
{
    // log
    if (   ((calc_enmInfo_t)m_cfg->enmInfo == calc_enmInfo_t::KERNEL && (m_cfg->idxFrame == m_cfg->numFrame - 1))
        ||  (calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::UNIT
    ) {
        cout << endl;
    }
}
