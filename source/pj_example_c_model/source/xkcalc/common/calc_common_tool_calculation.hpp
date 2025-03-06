//------------------------------------------------------------------------------
    //
    //  Filename       : calc_common_tool_general.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : common related inline functions (NOT headers) (calculation tool)
    //
//------------------------------------------------------------------------------

//*** INLINE *******************************************************************
// calc_getDatAdd
inline calc_dat_t calc_getDatAdd(
bool flgSaturation, calc_dat_t datInp0, calc_dat_t datInp1
)
{
    calc_datFul_t datTmp = datInp0 + datInp1;
    if (flgSaturation && datTmp > CALC_DATA_MAX)
        return CALC_DATA_MAX;
    else if (flgSaturation && datTmp < CALC_DATA_MIN)
        return CALC_DATA_MIN;
    else
        return datTmp;
}

// calc_getDatSub
inline calc_dat_t calc_getDatSub(
bool flgSaturation, calc_dat_t datInp0, calc_dat_t datInp1
)
{
    calc_datFul_t datTmp = datInp0 - datInp1;
    if (flgSaturation && datTmp > CALC_DATA_MAX)
        return CALC_DATA_MAX;
    else if (flgSaturation && datTmp < CALC_DATA_MIN)
        return CALC_DATA_MIN;
    else
        return datTmp;
}

// calc_getDatMul
inline calc_dat_t calc_getDatMul(
bool flgSaturation, calc_dat_t datInp0, calc_dat_t datInp1
)
{
    calc_datFul_t datTmp = datInp0 * datInp1;
    if (flgSaturation && datTmp > CALC_DATA_MAX)
        return CALC_DATA_MAX;
    else if (flgSaturation && datTmp < CALC_DATA_MIN)
        return CALC_DATA_MIN;
    else
        return datTmp;
}

// calc_getDatDiv
inline calc_dat_t calc_getDatDiv(
bool flgSaturation, calc_dat_t datInp0, calc_dat_t datInp1
)
{
    calc_datFul_t datTmp = datInp1 == 0 ? 0 : datInp0 * 0x10000 / datInp1;
    if (flgSaturation && datTmp > CALC_DATA_MAX)
        return CALC_DATA_MAX;
    else if (flgSaturation && datTmp < CALC_DATA_MIN)
        return CALC_DATA_MIN;
    else
        return datTmp;
}
