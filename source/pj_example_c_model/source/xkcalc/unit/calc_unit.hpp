//------------------------------------------------------------------------------
    //
    //  Filename       : calc_unit.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : unit related headers
    //
//------------------------------------------------------------------------------

#ifndef __CALC_UNIT_HPP__
#define __CALC_UNIT_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_common.hpp"
    #include "calc_fth.hpp"
    #include "calc_dmp.hpp"


//*** CLASS ********************************************************************
// CALC_UNIT
class CALC_UNIT
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
        string m_strTag = "CDC_UNIT";

    // connection
        const calc_cfg_t *m_cfg;
        calc_cfg_t       *m_cfgWritable;
        CALC_FTH         *m_fth;
        CALC_DMP         *m_dmp;

    // configuration
        bool           m_cfgFlgProc = (bool)          0;
        calc_enmLoad_t m_cfgEnmLoad = (calc_enmLoad_t)0;

    // data (inp0, inp1, out)
        //                     [channel index       ][vertical index      ][horizontal index    ]
        calc_dat_t (*m_datInp0)[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX];
        calc_dat_t (*m_datInp1)[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX];
        calc_dat_t (*m_datOut )[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX];

    // time
        #ifdef CALC_KNOB_TIME
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
        void dumpDatInp0(); bool m_dmpDatInp0Flg; FILE *m_dmpDatInp0Fpt;
        void dumpDatInp1(); bool m_dmpDatInp1Flg; FILE *m_dmpDatInp1Fpt;
        void dumpDatOut (); bool m_dmpDatOutFlg ; FILE *m_dmpDatOutFpt ;

    // tool
        //...


//--- PROTECTED INLINE -----------------
protected:
    #include "calc_unit_tool_time.hpp"


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        CALC_UNIT();
        ~CALC_UNIT();
        virtual void connect(calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp);
        void oneShot();


//--- PUBLIC INLINE --------------------
public:
    // cpyDatOut
        inline void cpyDatOut(void *datDst)
        {
            memcpy(datDst, m_datOut, sizeof(*m_datOut));
        }

    // dspRunTime
        inline void dspRunTime()
        {
            #ifdef CALC_KNOB_TIME
            #ifdef __linux__
            cout << "run time of PROC CORE M" << m_strTag.c_str() + CALC_SIZE_PREFIX << " is " << setprecision(3) << (double)m_datTAcc[0] / 1000 << " s" << endl;
            for (int i = 1; i < (int)enmFunc_t::NUMB; ++i) {
                if (m_datTAcc[i] > 0)
                    cout << "run time of PROC CORE M" << m_strTag.c_str() + CALC_SIZE_PREFIX << " MISC" << i - 1 << setprecision(3) << (double)m_datTAcc[i] / 1000 << " s" << endl;
            }
            #endif
            #endif
        }
};

#endif /* __CALC_UNIT_HPP__ */
