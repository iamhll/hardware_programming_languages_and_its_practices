//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related headers
    //
//------------------------------------------------------------------------------

#ifndef __CALC_KNL_HPP__
#define __CALC_KNL_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_fth.hpp"
    #include "calc_add.hpp"
    #include "calc_sub.hpp"
    #include "calc_mul.hpp"
    #include "calc_div.hpp"
    #include "calc_dmp.hpp"


//*** CLASS ********************************************************************
// CALC_KNL
class CALC_KNL
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
        calc_cfg_t *m_cfg;

    // dat (inp, out)
        calc_dat_t (*m_datInp)[CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX];
        calc_dat_t (*m_datOut)[CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX];

    // time
        #ifdef CALC_KNOB_TIME
        #ifdef __linux__
        timespec m_datTic      [(int)enmFunc_t::NUMB];
        timespec m_datToc      [(int)enmFunc_t::NUMB];
        unsigned long m_datTAcc[(int)enmFunc_t::NUMB] = {0};
        #endif
        #endif

    // module
        CALC_FTH m_fth;
        CALC_ADD m_add;
        CALC_SUB m_sub;
        CALC_MUL m_mul;
        CALC_DIV m_div;
        CALC_DMP m_dmp;


//--- PRIVATE FUNCTION -----------------
private:
    // oneShot
        void load();
        void proc();
        void dump();

    // load
        void loadFile();
        void loadFileInp(); bool m_loadFileInpFlg = 0; FILE *m_loadFileInpFpt;
        void loadRand();
        void loadRandInp();

    // process
        void procMain();

        void procPrev();
        void procCore();
        void procPost();

        void procCoreCfg();

    // dump
        void dumpFile();
        void dumpFileOut(); bool m_dumpFileOutFlg = 0; FILE *m_dumpFileOutFpt;

    // tool
        //...

    // debug
        //...


//--- PRIVATE INLINE -------------------
private:
    #include "calc_knl_proc.hpp"


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        CALC_KNL();
        ~CALC_KNL();
        void connect(calc_cfg_t &cfg);
        void oneShot();

    // display
        void dspRunTime();


//--- PUBLIC INLINE --------------------
public:
    // copy
    //...
};

#endif /* __CALC_KNL_HPP__ */
