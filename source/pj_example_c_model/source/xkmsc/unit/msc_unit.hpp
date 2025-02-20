//------------------------------------------------------------------------------
    //
    //  Filename       : msc_unit.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_UNIT_HPP__
#define __MSC_UNIT_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_common.hpp"
    #include "msc_fth.hpp"
    #include "msc_dmp.hpp"


//*** CLASS ********************************************************************
// MSC_UNIT
class MSC_UNIT
{
//--- PROTECTED ENUMERATOR -------------
protected:
    // enmFunc_t
        enum class enmFunc_t {
            MAIN = 0,
            MISC_0,
            MISC_1,
            MISC_2,
            MISC_3,
            MISC_4,
            MISC_5,
            MISC_6,
            MISC_7,
            NUMB
        };


//--- PROTECTED VARIABLE ---------------
protected:
    // identification
        string m_strTag = "MSC_UNIT";

    // connection
        const msc_cfg_t *m_cfg;
        msc_cfg_t       *m_cfgWritable;
        MSC_FTH         *m_fth;
        MSC_DMP         *m_dmp;

    // configuration
        bool          m_cfgFlgProc = (bool)         0;
        msc_enmLoad_t m_cfgEnmLoad = (msc_enmLoad_t)0;

    // data (in, out)
        //                   [channel index      ][vertical index     ][horizontal index   ]
        msc_pxl_t (*m_datIn )[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX];
        msc_pxl_t (*m_datOut)[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX];

    // time
        #ifdef MSC_KNOB_TIME
        #ifdef __linux__
        timespec      m_datTic [(int)enmFunc_t::NUMB];
        timespec      m_datToc [(int)enmFunc_t::NUMB];
        unsigned long m_datTAcc[(int)enmFunc_t::NUMB] = {0};
        #endif
        #endif


//--- PROTECTED FUNCTION ---------------
protected:
    // oneShot
        void load();
        void proc();
        void dump();

    // load
        virtual void loadPipe();
        virtual void loadFile();
        virtual void loadRand();

    // process
        void procMain();
        virtual void procPrev();
        virtual void procCore();
        virtual void procPost();

    // dump
        virtual void dumpFile();
        virtual void dumpDatIn (); bool m_dmpDatInFlg ; FILE *m_dmpDatInFpt ;
                void dumpDatOut(); bool m_dmpDatOutFlg; FILE *m_dmpDatOutFpt;

    // tool
        //...


//--- PROTECTED INLINE -----------------
protected:
    #include "msc_unit_tool_time.hpp"


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        MSC_UNIT();
        ~MSC_UNIT();
        virtual void connect(msc_cfg_t &cfg, MSC_FTH &fth, MSC_DMP &dmp);
        void oneShot();


//--- PUBLIC INLINE --------------------
public:
    // cpyDatOut
        inline void cpyDatOut(void *dst)
        {
            memcpy(dst, m_datOut, sizeof(*m_datOut));
        }

    // dspRunTime
        inline void dspRunTime()
        {
            #ifdef MSC_KNOB_TIME
            #ifdef __linux__
            cout << "run time of PROC CORE M" << m_strTag.c_str() + MSC_SIZE_PREFIX << " is " << setprecision(3) << (double)m_datTAcc[0] / 1000 << " s" << endl;
            for (int i = 1; i < (int)enmFunc_t::NUMB; ++i) {
                if (m_datTAcc[i] > 0)
                    cout << "run time of PROC CORE M" << m_strTag.c_str() + MSC_SIZE_PREFIX << " MISC" << i - 1 << setprecision(3) << (double)m_datTAcc[i] / 1000 << " s" << endl;
            }
            #endif
            #endif
        }
};

#endif /* __MSC_UNIT_HPP__ */
