//------------------------------------------------------------------------------
    //
    //  Filename       : msc_unit_tool_time.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : lcu related inline functions (NOT headers) (time tool)
    //
//------------------------------------------------------------------------------

//*** INLINE *******************************************************************
// updTic
inline void updTic(
enmFunc_t idx)
{
    #ifdef MSC_KNOB_TIME
    #ifdef __linux__
    clock_gettime(CLOCK_MONOTONIC, &m_datTic[(int)idx]);
    #endif
    #endif
}

// updToc
inline void updToc(
enmFunc_t idx)
{
    #ifdef MSC_KNOB_TIME
    #ifdef __linux__
    clock_gettime(CLOCK_MONOTONIC, &m_datToc[(int)idx]);
    m_datTAcc[(int)idx] += m_datToc[(int)idx].tv_sec * 1000 + m_datToc[(int)idx].tv_nsec / 1000 / 1000
        -                  m_datTic[(int)idx].tv_sec * 1000 - m_datTic[(int)idx].tv_nsec / 1000 / 1000
    ;
    #endif
    #endif
}
