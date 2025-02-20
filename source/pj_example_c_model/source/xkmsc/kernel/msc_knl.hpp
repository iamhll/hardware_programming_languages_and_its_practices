//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_KNL_HPP__
#define __MSC_KNL_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_fth.hpp"
    #include "msc_scl.hpp"
    #include "msc_flt.hpp"
    #include "msc_osd.hpp"
    #include "msc_dmp.hpp"


//*** CLASS ********************************************************************
// MSC_KNL
class MSC_KNL
{
//--- PRIVATE ENUMERATOR ---------------
private:
    // enmFunc_t
        enum class enmFunc_t {
            LOAD = 0,
            PROC,
            PROC_PREV,
            PROC_CORE,
            PROC_CORE_MISC,
            PROC_POST,
            DUMP,
            NUMB
        };


//--- PRIVATE VARIABLE -----------------
private:
    // identification
        string m_strTag;

    // cfg
        msc_cfg_t *m_cfg;

    // dat (in, out)
        msc_pxl_t (*m_datIn )[MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];
        msc_pxl_t (*m_datOut)[MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];

    // osd
        msc_osd_t (*m_datOsd)[MSC_OSD_NUMB_MAX][MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];

    // time
        #ifdef MSC_KNOB_TIME
        #ifdef __linux__
        timespec m_datTic      [(int)enmFunc_t::NUMB];
        timespec m_datToc      [(int)enmFunc_t::NUMB];
        unsigned long m_datTAcc[(int)enmFunc_t::NUMB] = {0};
        #endif
        #endif

    // module
        MSC_FTH m_fth;
        MSC_SCL m_scl;
        MSC_FLT m_flt;
        MSC_OSD m_osd;
        MSC_DMP m_dmp;


//--- PRIVATE FUNCTION -----------------
private:
    // oneShot
        void load();
        void proc();
        void dump();

    // load
        void loadFile();
        void loadRand();

        void loadFileIn (); bool m_loadFileInFlg  = 0; FILE *m_loadFileInFpt                   ;
        void loadFileOsd(); bool m_loadFileOsdFlg = 0; FILE *m_loadFileOsdFpt[MSC_OSD_NUMB_MAX];

        void loadRandIn();

    // process
        void procMain();

        void procPrev();
        void procCore();
        void procPost();

        void procCoreCfg();

    // dump
        void dumpFile();

        void dumpFileOut(); bool m_dumpFileOutFlg = 0; FILE *m_dumpFileOutFpt;

        void dumpDatOsd     (          ); bool m_dumpDatOsdFlg     [8] = {0}; FILE *m_dumpDatOsdFpt     [8];
        void dumpDatOriFrame(int idxChn); bool m_dumpDatOriFrameFlg[6] = {0}; FILE *m_dumpDatOriFrameFpt[6];

    // tool
        //...

    // debug
        //...


//--- PRIVATE INLINE -------------------
private:
    #include "msc_knl_proc.hpp"


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        MSC_KNL();
        ~MSC_KNL();
        void connect(msc_cfg_t &cfg);
        void oneShot();

    // display
        void dspRunTime();


//--- PUBLIC INLINE --------------------
public:
    // copy
    //...
};

#endif /* __MSC_KNL_HPP__ */
