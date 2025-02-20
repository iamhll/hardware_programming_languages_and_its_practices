//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_fth.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : fetcher related codes
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_fth.hpp"


//*** FUNCTION *****************************************************************
// MSC_FTH
//MSC_FTH::MSC_FTH()
//{
//}

// MSC_FTH
//MSC_FTH::~MSC_FTH()
//{
//}

// connect
void MSC_FTH::connect(
msc_pxl_t (*datIn )                   [MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX],
msc_osd_t (*datOsd) [MSC_OSD_NUMB_MAX][MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX])
{
    m_datIn = datIn;
    m_datOsd = datOsd;
}

// cpyDatIn
void MSC_FTH::cpyDatIn(msc_pxl_t datIn[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX],
const msc_cfg_t &cfg)
{
    // loop channels
    for (int k = 0; k < cfg.sizFrameZ; ++k) {
        int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
        // !!! - MSC_FLT_SIZE & + MSC_FLT_SIZE are introduced by the filtering operation
        int idxDstXBgn =  cfg.idxUnitX      * (cfg.sizUnitX >> datShift)     - MSC_FLT_SIZE;
        int idxDstXEnd = (cfg.idxUnitX + 1) * (cfg.sizUnitX >> datShift) - 1 + MSC_FLT_SIZE;
        int idxDstYBgn =  cfg.idxUnitY      * (cfg.sizUnitY >> datShift)     - MSC_FLT_SIZE;
        int idxDstYEnd = (cfg.idxUnitY + 1) * (cfg.sizUnitY >> datShift) - 1 + MSC_FLT_SIZE;
        // !!! floor operation cannot be removed,
        // !!! since "idxDstXBgn * cfg.datScalerX" may be lesser than 0,
        // !!! while the implicit "int" casting is truncated towards 0
        // !!! - 1 & + 2 are introduced by the 4-tap scaling
        int idxSrcXBgn = floor(idxDstXBgn * cfg.datScalerX) - 1;
        int idxSrcXEnd =       idxDstXEnd * cfg.datScalerX  + 2;
        int idxSrcYBgn = floor(idxDstYBgn * cfg.datScalerY) - 1;
        int idxSrcYEnd =       idxDstYEnd * cfg.datScalerY  + 2;
        int idxSrcXDlt = idxSrcXEnd - idxSrcXBgn + 1;
        int idxSrcYDlt = idxSrcYEnd - idxSrcYBgn + 1;
        assert(idxSrcXDlt                  <= MSC_SIZE_UNIT_X_MAX);
        assert(idxSrcYDlt - idxSrcYBgn + 1 <= MSC_SIZE_UNIT_Y_MAX);

        // copy
        for (int j = 0; j < idxSrcYDlt; ++j) {
            for (int i = 0; i < idxSrcXDlt; ++i) {
                int idxI = MSC_FUNC_MAX(MSC_FUNC_MIN(idxSrcXBgn + i, (cfg.sizFrameX >> datShift) - 1), 0);
                int idxJ = MSC_FUNC_MAX(MSC_FUNC_MIN(idxSrcYBgn + j, (cfg.sizFrameY >> datShift) - 1), 0);
                datIn[k][j][i] = (*m_datIn)[k][idxJ][idxI];
            }
        }

        // !!! hack codes to avoid the fetch of extra pixels introduced by 4-tap scaling
      //for (int j = 0; j < idxSrcYDlt; ++j) {
      //    datIn[k][j][0             ] = datIn[k][j][1             ];
      //    datIn[k][j][idxSrcXDlt - 1] = datIn[k][j][idxSrcXDlt - 2];
      //}
      //for (int i = 0; i < idxSrcXDlt; ++i) {
      //    datIn[k][0             ][i] = datIn[k][1             ][i];
      //    datIn[k][idxSrcYDlt - 1][i] = datIn[k][idxSrcYDlt - 2][i];
      //}
    }
}

// cpyDatOsd
void MSC_FTH::cpyDatOsd(msc_osd_t datOsd[MSC_SIZE_UNIT_Z_MAX + 1][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX],
const msc_cfg_t &cfg, int idxOsd)
{
    const int (*osdDatLutCur)[4][4] = NULL;
    switch (idxOsd) {
    case 0: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut0[0][0]; break;
    case 1: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut1[0][0]; break;
    case 2: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut2[0][0]; break;
    case 3: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut3[0][0]; break;
    case 4: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut4[0][0]; break;
    case 5: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut5[0][0]; break;
    case 6: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut6[0][0]; break;
    case 7: osdDatLutCur = (int (*)[4][4])&cfg.osdDatLut7[0][0]; break;
    };
    switch ((msc_osdEnmMode_t)cfg.osdEnmMode[idxOsd]) {
    case msc_osdEnmMode_t::DATA_YUV420: {
        for (int k = 0; k < cfg.sizFrameZ; ++k) {
            int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
            for (int j = 0; j < cfg.sizUnitY >> datShift; ++j) {
                for (int i = 0; i < cfg.sizUnitX >> datShift; ++i) {
                    int idxOsdX = (((cfg.idxUnitX * cfg.sizUnitX - cfg.osdPosFrameX[idxOsd]) >> datShift) + i) / cfg.osdDatScl[idxOsd][0];
                    int idxOsdY = (((cfg.idxUnitY * cfg.sizUnitY - cfg.osdPosFrameY[idxOsd]) >> datShift) + j) / cfg.osdDatScl[idxOsd][1];
                    datOsd[k][j][i] = (*m_datOsd)[idxOsd][k][idxOsdY][idxOsdX];
                }
            }
        }
        for (int j = 0; j < cfg.sizUnitY; ++j) {
            for (int i = 0; i < cfg.sizUnitX; ++i)
                datOsd[cfg.sizFrameZ][j][i] = (*osdDatLutCur)[0][0];
        }
    break;}
    case msc_osdEnmMode_t::DATA_AYUV1555:
    case msc_osdEnmMode_t::DATA_ARGB1555: {
        for (int j = 0; j < cfg.sizUnitY; ++j) {
            for (int i = 0; i < cfg.sizUnitX; ++i) {
                // AYUV1555
                int idxOsdX = (cfg.idxUnitX * cfg.sizUnitX - cfg.osdPosFrameX[idxOsd] + i) / cfg.osdDatScl[idxOsd][0];
                int idxOsdY = (cfg.idxUnitY * cfg.sizUnitY - cfg.osdPosFrameY[idxOsd] + j) / cfg.osdDatScl[idxOsd][1];
                msc_osd_t datTmp = (*m_datOsd)[idxOsd][0][idxOsdY][idxOsdX];
                msc_pxl_t datY, datU, datV;
                if ((msc_osdEnmMode_t)cfg.osdEnmMode[idxOsd] == msc_osdEnmMode_t::DATA_AYUV1555) {
                    datY = ((datTmp >> 10) & 0x1f) << 3;
                    datU = ((datTmp >> 5 ) & 0x1f) << 3;
                    datV = ((datTmp >> 0 ) & 0x1f) << 3;
                }
                else {
                    msc_pxl_t datR, datG, datB;
                    datR = ((datTmp >> 10) & 0x1f) << 3;
                    datG = ((datTmp >> 5 ) & 0x1f) << 3;
                    datB = ((datTmp >> 0 ) & 0x1f) << 3;
                    getDatYuvFromDatRgb(datR, datG, datB, datY, datU, datV);
                }
                // alpha
                datOsd[3][j][i] = (*osdDatLutCur)[(datTmp >> 15) & 0x1][0];
                // Y
                datOsd[0][j][i] = datY;
                // U & V
                if (i % 2 == 0 && j % 2 == 0) {
                datOsd[1][j >> MSC_DATA_SHIFT_CH][i >> MSC_DATA_SHIFT_CH] = datU;
                datOsd[2][j >> MSC_DATA_SHIFT_CH][i >> MSC_DATA_SHIFT_CH] = datV;
                }
            }
        }
    break;}
    case msc_osdEnmMode_t::INDX_2:
    case msc_osdEnmMode_t::INDX_4: {
        for (int j = 0; j < cfg.sizUnitY; ++j) {
            for (int i = 0; i < cfg.sizUnitX; ++i) {
                // AYUV1555
                int idxOsdX = (cfg.idxUnitX * cfg.sizUnitX - cfg.osdPosFrameX[idxOsd] + i) / cfg.osdDatScl[idxOsd][0];
                int idxOsdY = (cfg.idxUnitY * cfg.sizUnitY - cfg.osdPosFrameY[idxOsd] + j) / cfg.osdDatScl[idxOsd][1];
                msc_osd_t datTmp = (*m_datOsd)[idxOsd][0][idxOsdY][idxOsdX];
                // alpha
                datOsd[3][j][i] = (*osdDatLutCur)[datTmp][0];
                // Y
                datOsd[0][j][i] = (*osdDatLutCur)[datTmp][1];
                // U & V
                if (i % 2 == 0 && j % 2 == 0) {
                datOsd[1][j >> MSC_DATA_SHIFT_CH][i >> MSC_DATA_SHIFT_CH] = (*osdDatLutCur)[datTmp][2];
                datOsd[2][j >> MSC_DATA_SHIFT_CH][i >> MSC_DATA_SHIFT_CH] = (*osdDatLutCur)[datTmp][3];
                }
            }
        }
    break;}
    }
}
