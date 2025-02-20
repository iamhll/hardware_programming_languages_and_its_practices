//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_load.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related codes (load)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "msc_knl.hpp"


//*** FUNCTION *****************************************************************
// loadFile
void MSC_KNL::loadFile()
{
    loadFileIn();
    loadFileOsd();
}

// loadFileIn
void MSC_KNL::loadFileIn()
{
    // open file
    if (!m_loadFileInFlg) {
        m_loadFileInFlg = 1;
        m_loadFileInFpt = fopen(m_cfg->strFileIn.c_str(), "rb");
        if (m_loadFileInFpt == NULL) {
            cerr << "[error from c model] cannot open input file [" << m_cfg->strFileIn.c_str() << "]!" << endl;
            assert(0);
        }
    }

    // read data
    switch ((msc_enmFormatIn_t)m_cfg->enmFormatIn) {
    case msc_enmFormatIn_t::YUV420p:
        for (int k = 0; k < 3; ++k) {
            int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
            for (int j = 0; j < m_cfg->sizFrameY >> datShift; ++j) {
                for (int i = 0; i < m_cfg->sizFrameX >> datShift; ++i)
                    assert(fread(&((*m_datIn)[k][j][i]), sizeof(msc_pxl_t), 1, m_loadFileInFpt) == 1);
            }
        }
    break;
    case msc_enmFormatIn_t::NV12:
        // Y
        for (int j = 0; j < m_cfg->sizFrameY; ++j) {
            for (int i = 0; i < m_cfg->sizFrameX; ++i)
                assert(fread(&((*m_datIn)[0][j][i]), sizeof(msc_pxl_t), 1, m_loadFileInFpt) == 1);
        }
        // UV
        for (int j = 0; j < m_cfg->sizFrameY >> MSC_DATA_SHIFT_CH; ++j) {
            for (int i = 0; i < m_cfg->sizFrameX >> MSC_DATA_SHIFT_CH; ++i) {
                for (int k = 1; k < 3; ++k)
                    assert(fread(&((*m_datIn)[k][j][i]), sizeof(msc_pxl_t), 1, m_loadFileInFpt) == 1);
            }
        }
    break;
    }
}

// loadFileOsd
void MSC_KNL::loadFileOsd()
{
    if (m_cfg->osdFlgProc) {
        // open file
        if (!m_loadFileOsdFlg) {
            for (int idxOsd = 0; idxOsd < MSC_OSD_NUMB_MAX; ++idxOsd) {
                string *osdStrFileCur = NULL;
                switch (idxOsd) {
                case 0: osdStrFileCur = &m_cfg->osdStrFile0; break;
                case 1: osdStrFileCur = &m_cfg->osdStrFile1; break;
                case 2: osdStrFileCur = &m_cfg->osdStrFile2; break;
                case 3: osdStrFileCur = &m_cfg->osdStrFile3; break;
                case 4: osdStrFileCur = &m_cfg->osdStrFile4; break;
                case 5: osdStrFileCur = &m_cfg->osdStrFile5; break;
                case 6: osdStrFileCur = &m_cfg->osdStrFile6; break;
                case 7: osdStrFileCur = &m_cfg->osdStrFile7; break;
                };
                if (m_cfg->osdFlg[idxOsd]) {
                    m_loadFileOsdFpt[idxOsd] = fopen(osdStrFileCur->c_str(), "rb");
                    assert(m_loadFileOsdFpt[idxOsd] != NULL);
                }
            }
            m_loadFileOsdFlg = 1;
        }

        // read data
        for (int idxOsd = 0; idxOsd < MSC_OSD_NUMB_MAX; ++idxOsd) {
            if (m_cfg->osdFlg[idxOsd]) {
                switch((msc_osdEnmMode_t)m_cfg->osdEnmMode[idxOsd]) {
                case msc_osdEnmMode_t::DATA_YUV420: {
                    for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
                        int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
                        for (int j = 0; j < m_cfg->osdSizFrameY[idxOsd] >> datShift; ++j) {
                            for (int i = 0; i < m_cfg->osdSizFrameX[idxOsd] >> datShift; ++i)
                                assert(fread(&((*m_datOsd)[idxOsd][k][j][i]), sizeof(msc_pxl_t), 1, m_loadFileOsdFpt[idxOsd]) == 1);
                        }
                    }
                break;}
                case msc_osdEnmMode_t::DATA_AYUV1555:
                case msc_osdEnmMode_t::DATA_ARGB1555: {
                    for (int j = 0; j < m_cfg->osdSizFrameY[idxOsd]; ++j) {
                        for (int i = 0; i < m_cfg->osdSizFrameX[idxOsd]; ++i)
                            assert(fread(&((*m_datOsd)[idxOsd][0][j][i]), sizeof(msc_osd_t), 1, m_loadFileOsdFpt[idxOsd]) == 1);
                    }
                break;}
                case msc_osdEnmMode_t::INDX_2:
                case msc_osdEnmMode_t::INDX_4: {
                    int siz = (msc_osdEnmMode_t)m_cfg->osdEnmMode[idxOsd] == msc_osdEnmMode_t::INDX_2 ? 2 : 4;
                    for (int j = 0; j < m_cfg->osdSizFrameY[idxOsd]; ++j) {
                        for (int i = 0; i < m_cfg->osdSizFrameX[idxOsd]; ++i) {
                            assert(fread(&((*m_datOsd)[idxOsd][0][j][i]), sizeof(uint8_t), 1, m_loadFileOsdFpt[idxOsd]) == 1);
                            assert((*m_datOsd)[idxOsd][0][j][i] < siz);
                        }
                    }
                break;}
                }
            }
        }
    }
}

// loadRand
void MSC_KNL::loadRand()
{
    loadRandIn();
}

// loadRandIn
void MSC_KNL::loadRandIn()
{
    // read data
    for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
        int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
        for (int j = 0; j < m_cfg->sizFrameY >> datShift; ++j) {
            for (int i = 0; i < m_cfg->sizFrameX >> datShift; ++i)
                (*m_datIn)[k][j][i] = rand();
        }
    }
}
