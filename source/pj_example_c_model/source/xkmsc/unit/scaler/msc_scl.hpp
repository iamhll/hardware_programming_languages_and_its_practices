//------------------------------------------------------------------------------
    //
    //  Filename       : msc_scl.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : scaler related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_SCL_HPP__
#define __MSC_SCL_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_unit.hpp"


//*** DEFINE *******************************************************************


//*** CLASS ********************************************************************
// SCL
class MSC_SCL: public MSC_UNIT
{
//--- PRIVATE ENUMERATOR ---------------
private:


//--- PRIVATE VARIABLE -----------------
private:
    // information
        //...

    // data
        //...

    // cost
        //...

    // debug
        //...


//--- PRIVATE FUNCTION -----------------
private:
    // load
        //virtual void loadPipe();
        //virtual void loadFile();
        //virtual void loadRand();

    // process
        //virtual void procPrev();
        virtual void procCore();
        virtual void procPost();

        inline void procCoreScl() {
            for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
                int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
                int idxDstXBase = m_cfg->idxUnitX * (m_cfg->sizUnitX >> datShift) - MSC_FLT_SIZE;
                int idxDstYBase = m_cfg->idxUnitY * (m_cfg->sizUnitY >> datShift) - MSC_FLT_SIZE;
                // !!! floor operation cannot be removed, since the corresponding logic in function cpyDatIn adopts it
                int idxSrcXBase = floor(idxDstXBase * m_cfg->datScalerX);
                int idxSrcYBase = floor(idxDstYBase * m_cfg->datScalerY);
                for (int j = -MSC_FLT_SIZE; j < (m_cfg->sizUnitY >> datShift) + MSC_FLT_SIZE; ++j) {
                    for (int i = -MSC_FLT_SIZE; i < (m_cfg->sizUnitX >> datShift) + MSC_FLT_SIZE; ++i) {
                        // index
                        int idxDstX = idxDstXBase + MSC_FLT_SIZE + i;
                        int idxDstY = idxDstYBase + MSC_FLT_SIZE + j;
                        double idxSrcX = idxDstX * m_cfg->datScalerX - idxSrcXBase;
                        double idxSrcY = idxDstY * m_cfg->datScalerY - idxSrcYBase;
                        int idxSrcXInt = idxSrcX;
                        int idxSrcYInt = idxSrcY;
                        double idxSrcXFrc = idxSrcX - idxSrcXInt;
                        double idxSrcYFrc = idxSrcY - idxSrcYInt;
                        if ((msc_enmProc_t)m_cfg->enmProc == msc_enmProc_t::HARDWARE) {
                            idxSrcXFrc = msc_getDatFloor(idxSrcXFrc, 8);
                            idxSrcYFrc = msc_getDatFloor(idxSrcYFrc, 8);
                        }
                        // core
                        switch ((msc_sclEnmMode_t)m_cfg->sclEnmMode) {
                        case msc_sclEnmMode_t::BILINEAR: {
                            if (m_cfg->sclNumTap == 2) {
                                (*m_datOut)[k][MSC_FLT_SIZE + j][MSC_FLT_SIZE + i] = msc_getDatSclBL2x2(
                                    (msc_enmProc_t)m_cfg->enmProc == msc_enmProc_t::HARDWARE,
                                    idxSrcXFrc,
                                    idxSrcYFrc,
                                    m_cfg->sclDatThreshold2,
                                    m_cfg->sclDatThreshold2Inv,
                                    (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 1],
                                    (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 2],
                                    (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 1],
                                    (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 2]
                                );
                            }
                            else {
                                (*m_datOut)[k][MSC_FLT_SIZE + j][MSC_FLT_SIZE + i] = msc_getDatSclBL4x4(
                                    (msc_enmProc_t)m_cfg->enmProc == msc_enmProc_t::HARDWARE,
                                    idxSrcXFrc,
                                    idxSrcYFrc,
                                    m_cfg->sclDatThreshold4,
                                    (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 0],
                                    (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 1],
                                    (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 2],
                                    (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 3],
                                    (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 0],
                                    (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 1],
                                    (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 2],
                                    (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 3],
                                    (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 0],
                                    (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 1],
                                    (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 2],
                                    (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 3],
                                    (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 0],
                                    (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 1],
                                    (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 2],
                                    (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 3]
                                );
                            }
                        break;}
                        case msc_sclEnmMode_t::BICUBIC: {
                            (*m_datOut)[k][MSC_FLT_SIZE + j][MSC_FLT_SIZE + i] = msc_getDatSclBC4x4(
                                (msc_enmProc_t)m_cfg->enmProc == msc_enmProc_t::HARDWARE,
                                idxSrcXFrc,
                                idxSrcYFrc,
                                (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 0],
                                (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 1],
                                (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 2],
                                (*m_datIn)[k][idxSrcYInt + 0][idxSrcXInt + 3],
                                (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 0],
                                (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 1],
                                (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 2],
                                (*m_datIn)[k][idxSrcYInt + 1][idxSrcXInt + 3],
                                (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 0],
                                (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 1],
                                (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 2],
                                (*m_datIn)[k][idxSrcYInt + 2][idxSrcXInt + 3],
                                (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 0],
                                (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 1],
                                (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 2],
                                (*m_datIn)[k][idxSrcYInt + 3][idxSrcXInt + 3]
                            );
                        break;}
                        }
                        // log
                        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::COMMON) {
                            printf("    %02d-%04d-%04d: %.2f, %.2f, 0x%02x, 0x%02x, 0x%02x, 0x%02x -> 0x%02x\n", k, j, i,
                                idxSrcXFrc,
                                idxSrcYFrc,
                                (*m_datIn )[k][idxSrcYInt + 0][idxSrcXInt + 0],
                                (*m_datIn )[k][idxSrcYInt + 0][idxSrcXInt + 1],
                                (*m_datIn )[k][idxSrcYInt + 1][idxSrcXInt + 0],
                                (*m_datIn )[k][idxSrcYInt + 1][idxSrcXInt + 1],
                                (*m_datOut)[k][MSC_FLT_SIZE + j][MSC_FLT_SIZE + i] & 0xff
                            );
                        }
                    }
                }
            }
        }

    // dump
        //virtual void dumpFile();
        virtual void dumpDatIn();


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        MSC_SCL();
      //~MSC_SCL();
        virtual void connect(msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp);
};

#endif /* __MSC_SCL_HPP__ */
