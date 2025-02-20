//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (dump)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_knl.hpp"


//*** FUNCTION *****************************************************************
// dumpFile
void MSC_KNL::dumpFile()
{
    // dumpFileOut
    dumpFileOut();

    // dmpDatOriFrame
    if ((msc_enmDump_t)m_cfg->enmDump >= msc_enmDump_t::INOUT) {
        for (int c = 0; c < m_cfg->sizFrameZ; ++c)
            dumpDatOriFrame(c);
    }

    // dumpDatOsd
    if ((msc_enmDump_t)m_cfg->enmDump >= msc_enmDump_t::INOUT)
        dumpDatOsd();
}

// dumpFileOut
void MSC_KNL::dumpFileOut()
{
    if (m_cfg->strFileOut != "") {
        // open file
        if (m_dumpFileOutFlg == 0) {
            m_dumpFileOutFlg = 1;
            m_dumpFileOutFpt = fopen(m_cfg->strFileOut.c_str(), "wb");
            if (m_dumpFileOutFpt == NULL) {
                cerr << "[error from c model] cannot open output file [" << m_cfg->strFileOut.c_str() << "]!" << endl;
                assert(0);
            }
        }

        // dump data
        for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
            int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
            for (int j = 0; j < m_cfg->sclSizFrameY >> datShift; ++j) {
                for (int i = 0; i < m_cfg->sclSizFrameX >> datShift; ++i)
                    fwrite(&((*m_datOut)[k][j][i]), sizeof(msc_pxl_t), 1, m_dumpFileOutFpt);
            }
        }
    }
}

// dumpDatOriFrame
void MSC_KNL::dumpDatOriFrame(
int idxChn)
{
    int    datShift  = idxChn == 0 ? 0 : MSC_DATA_SHIFT_CH;
    int    idxTyp    = 0;
    string strObj    = "datOriFrame";
    string strIdx[3] = {"Y", "U", "V"};
    string strTyp    = "S0I8F0";
    string strPst    = "dat";
    int    datMsk    = 0xff;
    string strFmt    = "%02x";
    int    siz0      = m_cfg->sizFrameX >> datShift;
    int    siz1      = m_cfg->sizFrameY >> datShift;
    int    idxDlt    = 1;
    MSC_FUNC_DMP_D_2(m_cfg
        ,            m_dumpDatOriFrameFlg[idxTyp * 3 + idxChn]
        ,            m_dumpDatOriFrameFpt[idxTyp * 3 + idxChn]
        ,            "MSC_KNL"
        ,            strObj, strIdx[idxChn], strTyp, strPst
        ,            (*m_datIn)[idxChn]
        ,            datMsk, strFmt
        ,            siz1, idxDlt
        ,            siz0, idxDlt
    );
}

// dumpDatOsd
void MSC_KNL::dumpDatOsd() {
    for (int idxOsd = 0; idxOsd < MSC_OSD_NUMB_MAX; ++idxOsd) {
        string strObj = "datOsd";
        string strIdx = to_string(idxOsd);
        string strTyp = "W8";
        string strPst = "dat";
        MSC_FUNC_INI_FPT_DMP(m_cfg
            ,                m_dumpDatOsdFlg[idxOsd]
            ,                m_dumpDatOsdFpt[idxOsd]
            ,                "MSC_KNL"
            ,                strObj, strIdx, strTyp, strPst
        );
        if (m_cfg->osdFlg[idxOsd]) {
            switch((msc_osdEnmMode_t)m_cfg->osdEnmMode[idxOsd]) {
            case msc_osdEnmMode_t::DATA_YUV420: {
                assert(0);    // !!! DATA_YUV420 is not supported by hardware;
            break;}
            case msc_osdEnmMode_t::DATA_AYUV1555: {
                for (int j = 0; j < m_cfg->osdSizFrameY[idxOsd] / 16; ++j) {
                    for (int i = 0; i < m_cfg->osdSizFrameX[idxOsd] / 16; ++i) {
                        for (int k = 0; k < 256; ++k) {
                            int idxSubX = i * 16 + k % 16;
                            int idxSubY = j * 16 + k / 16;
                            if (k != 0)
                                fprintf(m_dumpDatOsdFpt[idxOsd], " ");
                            fprintf(m_dumpDatOsdFpt[idxOsd], "%02x %02x"
                                ,   ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX] >> 8) & 0xff
                                ,    (*m_datOsd)[idxOsd][0][idxSubY][idxSubX]       & 0xff
                            );
                        }
                        fprintf(m_dumpDatOsdFpt[idxOsd], "\n");
                    }
                }
            break;}
            case msc_osdEnmMode_t::INDX_2: {
                for (int j = 0; j < m_cfg->osdSizFrameY[idxOsd] / 16; ++j) {
                    for (int i = 0; i < m_cfg->osdSizFrameX[idxOsd] / 16; ++i) {
                        for (int k = 0; k < 32; ++k) {
                            int idxSubX = i * 16 + 8 * (k % 2);
                            int idxSubY = j * 16 +      k / 2 ;
                            if (k != 0)
                                fprintf(m_dumpDatOsdFpt[idxOsd], " ");
                            fprintf(m_dumpDatOsdFpt[idxOsd], "%02x"
                                ,   ( ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+0] << 7)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+1] << 6)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+2] << 5)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+3] << 4)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+4] << 3)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+5] << 2)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+6] << 1)
                                    + ((*m_datOsd)[idxOsd][0][idxSubY][idxSubX+7] << 0)
                                    ) & 0xff
                            );
                        }
                        fprintf(m_dumpDatOsdFpt[idxOsd], "\n");
                    }
                }
            break;}
            case msc_osdEnmMode_t::INDX_4: {
                for (int j = 0; j < m_cfg->osdSizFrameY[idxOsd] / 16; ++j) {
                    for (int i = 0; i < m_cfg->osdSizFrameX[idxOsd] / 16; ++i) {
                        for (int k = 0; k < 64; ++k) {
                            int tmp_x = i * 16 + 4 * (k % 4);
                            int tmp_y = j * 16 +      k / 4 ;
                            if (k != 0)
                                fprintf(m_dumpDatOsdFpt[idxOsd], " ");
                            fprintf(m_dumpDatOsdFpt[idxOsd], "%02x",
                                ( ((*m_datOsd)[idxOsd][0][tmp_y][tmp_x+0] << 6)
                                + ((*m_datOsd)[idxOsd][0][tmp_y][tmp_x+1] << 4)
                                + ((*m_datOsd)[idxOsd][0][tmp_y][tmp_x+2] << 2)
                                + ((*m_datOsd)[idxOsd][0][tmp_y][tmp_x+3] << 0)
                                ) & 0xff
                            );
                        }
                        fprintf(m_dumpDatOsdFpt[idxOsd], "\n");
                    }
                }
            break;}
            case msc_osdEnmMode_t::DATA_ARGB1555: {
                assert(0);    // !!! DATA_ARGB1555 is do not supported by hardware;
            break;}
            }
        }
    }
}
