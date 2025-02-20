//------------------------------------------------------------------------------
    //
    //  Filename       : msc_flt.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : filter related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_FLT_HPP__
#define __MSC_FLT_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_unit.hpp"


//*** DEFINE *******************************************************************


//*** CLASS ********************************************************************
// MSC_FLT
class MSC_FLT: public MSC_UNIT
{
//--- PRIVATE ENUMERATOR ---------------
private:


//--- PRIVATE VARIABLE -----------------
private:
    // connection
        MSC_UNIT *m_unitPrev;

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
        virtual void loadPipe();
        //virtual void loadFile();
        //virtual void loadRand();

    // process
        //virtual void procPrev();
        virtual void procCore();
        virtual void procPost();

        inline void procCoreFlt() {
            for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
                int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
                for (int j = 0; j < m_cfg->sizUnitY >> datShift; ++j) {
                    for (int i = 0; i < m_cfg->sizUnitX >> datShift; ++i) {
                        // core
                        (*m_datOut)[k][j][i] = msc_getDatFlt(
                            m_cfg->fltDatCoe[0][0],
                            m_cfg->fltDatCoe[0][1],
                            m_cfg->fltDatCoe[0][2],
                            m_cfg->fltDatCoe[1][0],
                            m_cfg->fltDatCoe[1][1],
                            m_cfg->fltDatCoe[1][2],
                            m_cfg->fltDatCoe[2][0],
                            m_cfg->fltDatCoe[2][1],
                            m_cfg->fltDatCoe[2][2],
                            (*m_datIn)[k][j + 0][i + 0],
                            (*m_datIn)[k][j + 0][i + 1],
                            (*m_datIn)[k][j + 0][i + 2],
                            (*m_datIn)[k][j + 1][i + 0],
                            (*m_datIn)[k][j + 1][i + 1],
                            (*m_datIn)[k][j + 1][i + 2],
                            (*m_datIn)[k][j + 2][i + 0],
                            (*m_datIn)[k][j + 2][i + 1],
                            (*m_datIn)[k][j + 2][i + 2]
                        );
                        // log
                        if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::COMMON) {
                            printf("    %02d-%04d-%04d: 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x -> 0x%02x\n", k, j, i,
                                (*m_datIn )[k][1 + j + 0][1 + i + 0],
                                (*m_datIn )[k][1 + j + 0][1 + i + 1],
                                (*m_datIn )[k][1 + j + 0][1 + i + 2],
                                (*m_datIn )[k][1 + j + 1][1 + i + 0],
                                (*m_datIn )[k][1 + j + 1][1 + i + 1],
                                (*m_datIn )[k][1 + j + 1][1 + i + 2],
                                (*m_datIn )[k][1 + j + 2][1 + i + 0],
                                (*m_datIn )[k][1 + j + 2][1 + i + 1],
                                (*m_datIn )[k][1 + j + 2][1 + i + 2],
                                (*m_datOut)[k][j][i]
                            );
                        }
                    }
                }
            }
        }

    // dump
        //virtual void dumpFile();


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        MSC_FLT();
        //~MSC_FLT();
        virtual void connect(msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp, MSC_UNIT &unitPrev);
};

#endif /* __MSC_FLT_HPP__ */
