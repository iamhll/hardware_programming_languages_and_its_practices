//------------------------------------------------------------------------------
    //
    //  Filename       : msc_common_tool_general.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2026-03-03
    //  Description    : common related inline functions (NOT headers) (general tool)
    //
//------------------------------------------------------------------------------

//*** INLINE *******************************************************************
// msc_getDatRound
inline double msc_getDatRound(
double dat, int numBitFrc)
{
    double datScl = pow(2, numBitFrc);
    return round(dat * datScl) / datScl;
}

// msc_getDatFloor
inline double msc_getDatFloor(
double dat, int numBitFrc)
{
    double datScl = pow(2, numBitFrc);
    return floor(dat * datScl) / datScl;
}
