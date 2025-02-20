//------------------------------------------------------------------------------
    //
    //  Filename       : msc_osd.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : on-screen-display related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_OSD_HPP__
#define __MSC_OSD_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_unit.hpp"


//*** DEFINE *******************************************************************


//*** CLASS ********************************************************************
// MSC_OSD
class MSC_OSD: public MSC_UNIT
{
//--- PRIVATE ENUMERATOR ---------------
private:


//--- PRIVATE VARIABLE -----------------
private:
    // connection
        MSC_UNIT *m_unitPrev;

    // information
        bool m_flgRun;
        int  m_idxRun;

    // data
        //                   [channel index          ][vertical index     ][horizontal index   ]
        msc_osd_t (*m_datOsd)[MSC_SIZE_UNIT_Z_MAX + 1][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX];

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

        inline void procCoreOsd() {
            for (int k = 0; k < m_cfg->sizFrameZ; ++k) {
                int datShift = k == 0 ? 0 : MSC_DATA_SHIFT_CH;
                for (int j = 0; j < m_cfg->sizUnitY >> datShift; ++j) {
                    for (int i = 0; i < m_cfg->sizUnitX >> datShift; ++i) {
                        // core
                        if (m_flgRun) {
                            (*m_datOut)[k][j][i] = msc_getDatOsd(
                                // !!! index of alpha should be rescaled back
                                (*m_datOsd)[m_cfg->sizFrameZ][j << datShift][i << datShift],
                                (*m_datIn )[k][j][i],
                                (*m_datOsd)[k][j][i]
                            );
                        }
                        else {
                            (*m_datOut)[k][j][i] = (*m_datIn)[k][j][i];
                        }
                        // log
                        if (m_flgRun) {
                            if ((msc_enmInfo_t)m_cfg->enmInfo >= msc_enmInfo_t::COMMON) {
                                printf("    %02d-%04d-%04d: 0x%02x, 0x%02x -> 0x%02x\n", k, j, i,
                                    (*m_datIn )[k][j][i],
                                    (*m_datOsd)[k][j][i],
                                    (*m_datOut)[k][j][i]
                                );
                            }
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
        MSC_OSD();
        ~MSC_OSD();
        virtual void connect(msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp, MSC_UNIT &unitPrev);
};

#endif /* __MSC_OSD_HPP__ */
