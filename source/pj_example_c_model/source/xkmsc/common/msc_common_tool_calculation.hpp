//------------------------------------------------------------------------------
    //
    //  Filename       : msc_common_tool_general.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : common related inline functions (NOT headers) (calculation tool)
    //
//------------------------------------------------------------------------------

//*** INLINE *******************************************************************
// msc_getDatSclBC4x4
inline msc_pxl_t msc_getDatSclBC4x4(
bool flgHardware,
double datFrcX,
double datFrcY,
msc_pxl_t dat_0_0,
msc_pxl_t dat_0_1,
msc_pxl_t dat_0_2,
msc_pxl_t dat_0_3,
msc_pxl_t dat_1_0,
msc_pxl_t dat_1_1,
msc_pxl_t dat_1_2,
msc_pxl_t dat_1_3,
msc_pxl_t dat_2_0,
msc_pxl_t dat_2_1,
msc_pxl_t dat_2_2,
msc_pxl_t dat_2_3,
msc_pxl_t dat_3_0,
msc_pxl_t dat_3_1,
msc_pxl_t dat_3_2,
msc_pxl_t dat_3_3
)
{
    // dat_map_0_0, dat_map_0_1, dat_map_0_2, dat_map_0_3
    // dat_map_1_0, dat_map_1_1, dat_map_1_2, dat_map_1_3
    // dat_map_2_0, dat_map_2_1, dat_map_2_2, dat_map_2_3
    // dat_map_3_0, dat_map_3_1, dat_map_3_2, dat_map_3_3
    double dat_map_0_0 = dat_1_1;
    double dat_map_0_1 = -.5 * dat_1_0 + .5 * dat_1_2;
    double dat_map_0_2 = dat_1_0 - 2.5 * dat_1_1 + 2 * dat_1_2 - .5 * dat_1_3;
    double dat_map_0_3 = -.5 * dat_1_0 + 1.5 * dat_1_1 - 1.5 * dat_1_2 + .5 * dat_1_3;
    double dat_map_1_0 = -.5 * dat_0_1 + .5 * dat_2_1;
    double dat_map_1_1 = .25 * dat_0_0 - .25 * dat_0_2 - .25 * dat_2_0 + .25 * dat_2_2;
    double dat_map_1_2 = -.5 * dat_0_0 + 1.25 * dat_0_1 - dat_0_2 + .25 * dat_0_3 + .5 * dat_2_0 - 1.25 * dat_2_1 + dat_2_2 - .25 * dat_2_3;
    double dat_map_1_3 = .25 * dat_0_0 - .75 * dat_0_1 + .75 * dat_0_2 - .25 * dat_0_3 - .25 * dat_2_0 + .75 * dat_2_1 - .75 * dat_2_2 + .25 * dat_2_3;
    double dat_map_2_0 = dat_0_1 - 2.5 * dat_1_1 + 2 * dat_2_1 - .5 * dat_3_1;
    double dat_map_2_1 = -.5 * dat_0_0 + .5 * dat_0_2 + 1.25 * dat_1_0 - 1.25 * dat_1_2 - dat_2_0 + dat_2_2 + .25 * dat_3_0 - .25 * dat_3_2;
    double dat_map_2_2 = dat_0_0 - 2.5 * dat_0_1 + 2 * dat_0_2 - .5 * dat_0_3 - 2.5 * dat_1_0 + 6.25 * dat_1_1 - 5 * dat_1_2 + 1.25 * dat_1_3 + 2 * dat_2_0 - 5 * dat_2_1 + 4 * dat_2_2 - dat_2_3 - .5 * dat_3_0 + 1.25 * dat_3_1 - dat_3_2 + .25 * dat_3_3;
    double dat_map_2_3 = -.5 * dat_0_0 + 1.5 * dat_0_1 - 1.5 * dat_0_2 + .5 * dat_0_3 + 1.25 * dat_1_0 - 3.75 * dat_1_1 + 3.75 * dat_1_2 - 1.25 * dat_1_3 - dat_2_0 + 3 * dat_2_1 - 3 * dat_2_2 + dat_2_3 + .25 * dat_3_0 - .75 * dat_3_1 + .75 * dat_3_2 - .25 * dat_3_3;
    double dat_map_3_0 = -.5 * dat_0_1 + 1.5 * dat_1_1 - 1.5 * dat_2_1 + .5 * dat_3_1;
    double dat_map_3_1 = .25 * dat_0_0 - .25 * dat_0_2 - .75 * dat_1_0 + .75 * dat_1_2 + .75 * dat_2_0 - .75 * dat_2_2 - .25 * dat_3_0 + .25 * dat_3_2;
    double dat_map_3_2 = -.5 * dat_0_0 + 1.25 * dat_0_1 - dat_0_2 + .25 * dat_0_3 + 1.5 * dat_1_0 - 3.75 * dat_1_1 + 3 * dat_1_2 - .75 * dat_1_3 - 1.5 * dat_2_0 + 3.75 * dat_2_1 - 3 * dat_2_2 + .75 * dat_2_3 + .5 * dat_3_0 - 1.25 * dat_3_1 + dat_3_2 - .25 * dat_3_3;
    double dat_map_3_3 = .25 * dat_0_0 - .75 * dat_0_1 + .75 * dat_0_2 - .25 * dat_0_3 - .75 * dat_1_0 + 2.25 * dat_1_1 - 2.25 * dat_1_2 + .75 * dat_1_3 + .75 * dat_2_0 - 2.25 * dat_2_1 + 2.25 * dat_2_2 - .75 * dat_2_3 - .25 * dat_3_0 + .75 * dat_3_1 - .75 * dat_3_2 + .25 * dat_3_3;
    if (flgHardware) {
        dat_map_0_0 = msc_getDatRound(dat_map_0_0, 8);
        dat_map_0_1 = msc_getDatRound(dat_map_0_1, 8);
        dat_map_0_2 = msc_getDatRound(dat_map_0_2, 8);
        dat_map_0_3 = msc_getDatRound(dat_map_0_3, 8);
        dat_map_1_0 = msc_getDatRound(dat_map_1_0, 8);
        dat_map_1_1 = msc_getDatRound(dat_map_1_1, 8);
        dat_map_1_2 = msc_getDatRound(dat_map_1_2, 8);
        dat_map_1_3 = msc_getDatRound(dat_map_1_3, 8);
        dat_map_2_0 = msc_getDatRound(dat_map_2_0, 8);
        dat_map_2_1 = msc_getDatRound(dat_map_2_1, 8);
        dat_map_2_2 = msc_getDatRound(dat_map_2_2, 8);
        dat_map_2_3 = msc_getDatRound(dat_map_2_3, 8);
        dat_map_3_0 = msc_getDatRound(dat_map_3_0, 8);
        dat_map_3_1 = msc_getDatRound(dat_map_3_1, 8);
        dat_map_3_2 = msc_getDatRound(dat_map_3_2, 8);
        dat_map_3_3 = msc_getDatRound(dat_map_3_3, 8);
    }

    // datFrcXp2
    double datFrcXp2 = datFrcX * datFrcX;
    if (flgHardware)
        datFrcXp2 = msc_getDatRound(datFrcXp2, 8);

    // datFrcXp3
    double datFrcXp3 = datFrcXp2 * datFrcX;
    if (flgHardware)
        datFrcXp3 = msc_getDatRound(datFrcXp3, 8);

    // datFrcYp2
    double datFrcYp2 = datFrcY * datFrcY;
    if (flgHardware)
        datFrcYp2 = msc_getDatRound(datFrcYp2, 8);

    // datFrcYp3
    double datFrcYp3 = datFrcYp2 * datFrcY;
    if (flgHardware)
        datFrcYp3 = msc_getDatRound(datFrcYp3, 8);

    // dat_map_0_x, dat_map_1_x, dat_map_2_x, dat_map_3_x
    double dat_map_0_x = dat_map_0_0 + dat_map_0_1 * datFrcX + dat_map_0_2 * datFrcXp2 + dat_map_0_3 * datFrcXp3;
    double dat_map_1_x = dat_map_1_0 + dat_map_1_1 * datFrcX + dat_map_1_2 * datFrcXp2 + dat_map_1_3 * datFrcXp3;
    double dat_map_2_x = dat_map_2_0 + dat_map_2_1 * datFrcX + dat_map_2_2 * datFrcXp2 + dat_map_2_3 * datFrcXp3;
    double dat_map_3_x = dat_map_3_0 + dat_map_3_1 * datFrcX + dat_map_3_2 * datFrcXp2 + dat_map_3_3 * datFrcXp3;
    if (flgHardware) {
        dat_map_0_x = msc_getDatRound(dat_map_0_x, 8);
        dat_map_1_x = msc_getDatRound(dat_map_1_x, 8);
        dat_map_2_x = msc_getDatRound(dat_map_2_x, 8);
        dat_map_3_x = msc_getDatRound(dat_map_3_x, 8);
    }

    // dat_map_x_x
    double dat_map_x_x = dat_map_0_x + dat_map_1_x * datFrcY + dat_map_2_x * datFrcYp2 + dat_map_3_x * datFrcYp3;
    dat_map_x_x = MSC_FUNC_MAX(MSC_DATA_MIN, MSC_FUNC_MIN(MSC_DATA_MAX, dat_map_x_x));

    // return
    return dat_map_x_x;
}

// msc_getDatSclBL2x2
inline msc_pxl_t msc_getDatSclBL2x2(
bool flgHardware,
double datFrcX,
double datFrcY,
double datThreshold,
double datThresholdInv,
msc_pxl_t dat_0_0,
msc_pxl_t dat_0_1,
msc_pxl_t dat_1_0,
msc_pxl_t dat_1_1
)
{
    // datThresholdDiv2
    double datThresholdDiv2 = datThreshold * 0.5;
    if (flgHardware)
        datThresholdDiv2 = msc_getDatRound(datThresholdDiv2, 8);

    // datFrcX
    if (abs(datFrcX - 0.5) > datThresholdDiv2) {
        if (datFrcX < 0.5)
            datFrcX = 0;
        else
            datFrcX = 1;
    }
    else {
        datFrcX = (datFrcX - 0.5 + datThresholdDiv2) * datThresholdInv;
    }
    datFrcX = (datFrcX > 1) ? 1 : datFrcX;
    if (flgHardware)
        datFrcX = msc_getDatRound(datFrcX, 8);

    // datFrcY
    if (abs(datFrcY - 0.5) > datThresholdDiv2) {
        if (datFrcY < 0.5)
            datFrcY = 0;
        else
            datFrcY = 1;
    }
    else {
        datFrcY = (datFrcY - 0.5 + datThresholdDiv2) * datThresholdInv;
    }
    datFrcY = (datFrcY > 1) ? 1 : datFrcY;
    if (flgHardware)
        datFrcY = msc_getDatRound(datFrcY, 8);

    // dat_x_0, dat_x_1
    int dat_x_0 = round(dat_0_0 * (1 - datFrcY) + dat_1_0 * datFrcY);
    int dat_x_1 = round(dat_0_1 * (1 - datFrcY) + dat_1_1 * datFrcY);

    // dat_x_x
    int dat_x_x = round(dat_x_0 * (1 - datFrcX) + dat_x_1 * datFrcX);

    // return
    return dat_x_x;
}

// msc_getDatSclBL4x1
inline msc_pxl_t msc_getDatSclBL4x1(
bool flgHardware,
double datFrc,
msc_pxl_t datThreshold,
msc_pxl_t dat_0,
msc_pxl_t dat_1,
msc_pxl_t dat_2,
msc_pxl_t dat_3
)
{
    // datFrcTmp
    double datFrcTmp = (1 - datFrc) * datFrc;
    if (flgHardware)
        datFrcTmp = msc_getDatRound(datFrcTmp, 8);

    // datFrc0
    double datFrc0;
    datFrc0 = datFrcTmp * (1 - datFrc);
    if (flgHardware)
        datFrc0 = msc_getDatRound(datFrc0, 8);
    if (abs((int)dat_0 - dat_1) >= datThreshold)
        datFrc0 = datFrc0;
    else
        datFrc0 = datFrc0 / 2;
    if (flgHardware)
        datFrc0 = msc_getDatRound(datFrc0, 8);

    // datFrc1
    double datFrc1 = (1 - datFrc) + datFrc0;

    // datFrc3
    double datFrc3;
    datFrc3 = datFrcTmp * datFrc;
    if (flgHardware)
        datFrc3 = msc_getDatRound(datFrc3, 8);
    if (abs((int)dat_2 - dat_3) >= datThreshold)
        datFrc3 = datFrc3;
    else
        datFrc3 = datFrc3 / 2;
    if (flgHardware)
        datFrc3 = msc_getDatRound(datFrc3, 8);

    // datFrc2
    double datFrc2 = datFrc + datFrc3;

    // dat_sum_0, dat_sum_1
    double dat_sum_0 = dat_0 * datFrc0 + dat_3 * datFrc3;
    double dat_sum_1 = dat_1 * datFrc1 + dat_2 * datFrc2;

    // dat
    double dat = dat_sum_1 - dat_sum_0;
    dat = round(dat);
    dat = MSC_FUNC_MAX(MSC_DATA_MIN, MSC_FUNC_MIN(MSC_DATA_MAX, dat));

    // return
    return (msc_pxl_t)dat;
}

// msc_getDatSclBL4x4
inline msc_pxl_t msc_getDatSclBL4x4(
bool flgHardware,
double datFrcX,
double datFrcY,
msc_pxl_t datThreshold,
msc_pxl_t dat_0_0,
msc_pxl_t dat_0_1,
msc_pxl_t dat_0_2,
msc_pxl_t dat_0_3,
msc_pxl_t dat_1_0,
msc_pxl_t dat_1_1,
msc_pxl_t dat_1_2,
msc_pxl_t dat_1_3,
msc_pxl_t dat_2_0,
msc_pxl_t dat_2_1,
msc_pxl_t dat_2_2,
msc_pxl_t dat_2_3,
msc_pxl_t dat_3_0,
msc_pxl_t dat_3_1,
msc_pxl_t dat_3_2,
msc_pxl_t dat_3_3
)
{
    // dat_0_x, dat_1_x, dat_2_x, dat_3_x
    msc_pxl_t dat_0_x = msc_getDatSclBL4x1(flgHardware, datFrcY, datThreshold, dat_0_0, dat_1_0, dat_2_0, dat_3_0);
    msc_pxl_t dat_1_x = msc_getDatSclBL4x1(flgHardware, datFrcY, datThreshold, dat_0_1, dat_1_1, dat_2_1, dat_3_1);
    msc_pxl_t dat_2_x = msc_getDatSclBL4x1(flgHardware, datFrcY, datThreshold, dat_0_2, dat_1_2, dat_2_2, dat_3_2);
    msc_pxl_t dat_3_x = msc_getDatSclBL4x1(flgHardware, datFrcY, datThreshold, dat_0_3, dat_1_3, dat_2_3, dat_3_3);

    // dat_y
    msc_pxl_t dat_y   = msc_getDatSclBL4x1(flgHardware, datFrcX, datThreshold, dat_0_x, dat_1_x, dat_2_x, dat_3_x);

    // return
    return dat_y;

}

// msc_getDatFlt
inline msc_pxl_t msc_getDatFlt(
double datFlt0,
double datFlt1,
double datFlt2,
double datFlt3,
double datFlt4,
double datFlt5,
double datFlt6,
double datFlt7,
double datFlt8,
msc_pxl_t dat0,
msc_pxl_t dat1,
msc_pxl_t dat2,
msc_pxl_t dat3,
msc_pxl_t dat4,
msc_pxl_t dat5,
msc_pxl_t dat6,
msc_pxl_t dat7,
msc_pxl_t dat8
)
{
    // dat
    double dat = datFlt0 * dat0
        +        datFlt1 * dat1
        +        datFlt2 * dat2
        +        datFlt3 * dat3
        +        datFlt4 * dat4
        +        datFlt5 * dat5
        +        datFlt6 * dat6
        +        datFlt7 * dat7
        +        datFlt8 * dat8
    ;
    dat = MSC_FUNC_MAX(MSC_DATA_MIN, MSC_FUNC_MIN(MSC_DATA_MAX, dat));

    // return
    return dat;
}

// msc_getDatOsd
inline msc_pxl_t msc_getDatOsd(
int   datAlpha,
msc_pxl_t dat0,
msc_pxl_t dat1
)
{
    // dat
    double dat = (dat0 * (MSC_DATA_MAX - datAlpha) + dat1 * datAlpha) >> MSC_DATA_WD;

    // return
    return dat;
}

// getDatYuvFromDatRgb
inline void getDatYuvFromDatRgb(msc_pxl_t &datR, msc_pxl_t &datG, msc_pxl_t &datB,
msc_pxl_t &datY, msc_pxl_t &datU, msc_pxl_t &datV
)
{
    // datY, datU, datV
    datY =  0.257 * datR + 0.564 * datG + 0.098 * datB + 16;
    datU = -0.148 * datR - 0.291 * datG + 0.439 * datB + 128;
    datV =  0.439 * datR - 0.368 * datG - 0.071 * datB + 128;
}
