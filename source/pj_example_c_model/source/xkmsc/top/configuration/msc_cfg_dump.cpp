//------------------------------------------------------------------------------
    //
    //  Filename       : msc_cfg_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related codes (dump)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_cfg.hpp"


//*** DEFINE *******************************************************************


//*** FUNCTION *****************************************************************
// msc_cfgDmp
void msc_cfgDmp(
msc_cfg_t *cfg)
{
    string str = cfg->strPrefixDump
        +        "dut_setting.vh"
    ;
    FILE *fpt = fopen(str.c_str(), "w");
    assert(fpt != NULL);

    // HEADER
    fprintf(fpt, "// skip checkFileHeader\n");

    // MSC_TOP
    fprintf(fpt, "\n");
    fprintf(fpt, "// MSC_TOP\n");
    fprintf(fpt, "`define DUT_MSC_NUMB_FRAME    'd%d\n", cfg->numFrame );

    // MSC_KNL
    fprintf(fpt, "\n");
    fprintf(fpt, "// MSC_KNL\n");
    fprintf(fpt, "`define DUT_MSC_SIZE_FRAME_X            'd%d\n", cfg->sizFrameX);
    fprintf(fpt, "`define DUT_MSC_SIZE_FRAME_Y            'd%d\n", cfg->sizFrameY);
    fprintf(fpt, "`define DUT_MSC_SIZE_FRAME_X_FOR_REG    'd%d\n", cfg->sizFrameX - 1);
    fprintf(fpt, "`define DUT_MSC_SIZE_FRAME_Y_FOR_REG    'd%d\n", cfg->sizFrameY - 1);

    // MSC_SCL
    fprintf(fpt, "\n");
    fprintf(fpt, "// MSC_SCL\n");
    fprintf(fpt, "`define DUT_MSC_SCL_FLAG                    'b%d\n", cfg->sclFlgProc);
    fprintf(fpt, "`define DUT_MSC_SCL_SIZE_FRAME_X            'd%d\n", cfg->sclSizFrameX);
    fprintf(fpt, "`define DUT_MSC_SCL_SIZE_FRAME_Y            'd%d\n", cfg->sclSizFrameY);
    fprintf(fpt, "`define DUT_MSC_SCL_ENUM_TAP               1'd%d\n", cfg->sclNumTap == 2 ? 0 : 1);
    fprintf(fpt, "`define DUT_MSC_SCL_DATA_SCALER_X         17'd%d\n", (int)(cfg->datScalerX          * (1 << 16)));
    fprintf(fpt, "`define DUT_MSC_SCL_DATA_SCALER_Y         17'd%d\n", (int)(cfg->datScalerY          * (1 << 16)));
    fprintf(fpt, "`define DUT_MSC_SCL_DATA_THRESHOLD         9'd%d\n",       cfg->sclNumTap == 2
                                                                     ? (int)(cfg->sclDatThreshold2    * (1 <<  8))
                                                                     :       cfg->sclDatThreshold4
    );
    fprintf(fpt, "`define DUT_MSC_SCL_DATA_THRESHOLD_INV    16'd%d\n",       cfg->sclNumTap == 2
                                                                     ? (int)(cfg->sclDatThreshold2Inv * (1 <<  8))
                                                                     :       0
    );

    // MSC_OSD
    fprintf(fpt, "\n");
    fprintf(fpt, "// MSC_OSD\n");
    fprintf(fpt, "`define DUT_MSC_OSD_FLAG                 %d'b", MSC_OSD_NUMB_MAX);
    for (int i = 0; i < MSC_OSD_NUMB_MAX; ++i)
        fprintf(fpt, "%d", cfg->osdFlg[MSC_OSD_NUMB_MAX - 1 - i]);
    fprintf(fpt, "\n");
    for (int idxOsd = 0; idxOsd < MSC_OSD_NUMB_MAX; ++idxOsd) {
        fprintf(fpt, "`define DUT_MSC_OSD_%d_INDX_LCU_BGN_X     8'd%d\n", idxOsd, cfg->osdPosFrameX[idxOsd] / cfg->sizUnitX);
        fprintf(fpt, "`define DUT_MSC_OSD_%d_INDX_LCU_BGN_Y     8'd%d\n", idxOsd, cfg->osdPosFrameY[idxOsd] / cfg->sizUnitY);
        fprintf(fpt, "`define DUT_MSC_OSD_%d_INDX_LCU_END_X     8'd%d\n", idxOsd, (cfg->osdSizFrameX[idxOsd] * cfg->osdDatScl[idxOsd][0] + cfg->osdPosFrameX[idxOsd]) / cfg->sizUnitX);
        fprintf(fpt, "`define DUT_MSC_OSD_%d_INDX_LCU_END_Y     8'd%d\n", idxOsd, (cfg->osdSizFrameY[idxOsd] * cfg->osdDatScl[idxOsd][1] + cfg->osdPosFrameY[idxOsd]) / cfg->sizUnitY);
        fprintf(fpt, "`define DUT_MSC_OSD_%d_ENUM_MODE          2'd%d\n", idxOsd, (msc_osdEnmMode_t)cfg->osdEnmMode[idxOsd] == msc_osdEnmMode_t::INDX_2        ? 0
                                                                                : (msc_osdEnmMode_t)cfg->osdEnmMode[idxOsd] == msc_osdEnmMode_t::INDX_4        ? 1
                                                                                : (msc_osdEnmMode_t)cfg->osdEnmMode[idxOsd] == msc_osdEnmMode_t::DATA_AYUV1555 ? 2
                                                                                : 0
        );
        fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_SCL_X         2'd%d\n", idxOsd, cfg->osdDatScl[idxOsd][0] - 1);
        fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_SCL_Y         2'd%d\n", idxOsd, cfg->osdDatScl[idxOsd][1] - 1);
        for (int idxLut = 0; idxLut < 4; ++idxLut) {
            for (int idxChn = 0; idxChn < 4; ++idxChn) {
                switch (idxOsd) {
                case 0: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut0[idxLut][idxChn]); break;
                case 1: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut1[idxLut][idxChn]); break;
                case 2: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut2[idxLut][idxChn]); break;
                case 3: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut3[idxLut][idxChn]); break;
                case 4: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut4[idxLut][idxChn]); break;
                case 5: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut5[idxLut][idxChn]); break;
                case 6: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut6[idxLut][idxChn]); break;
                case 7: fprintf(fpt, "`define DUT_MSC_OSD_%d_DATA_LUT_%d_%d       8'h%x\n", idxOsd, idxLut, idxChn, cfg->osdDatLut7[idxLut][idxChn]); break;
                }
            }
        }
    }
}
