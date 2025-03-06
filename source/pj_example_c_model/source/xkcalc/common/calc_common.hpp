//------------------------------------------------------------------------------
    //
    //  Filename       : calc_common.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : common related headers
    //
//------------------------------------------------------------------------------

#ifndef __CALC_COMMON_HPP__
#define __CALC_COMMON_HPP__

//*** INCLUDE ******************************************************************
    #ifdef   NDEBUG
    #undef   NDEBUG
    #include <assert.h>
    #define  NDEBUG
    #else
    #include <assert.h>
    #endif
    #include <cstring>
    #include <fstream>
    #include <iomanip>
    #include <iostream>
    #include <math.h>
    #ifdef CALC_KNOB_TIME
    #ifdef __linux__
    #include <sys/time.h>
    #endif
    #endif


//*** NAMESPACE ****************************************************************
    using std::cout;
    using std::cerr;
    using std::endl;
    using std::fstream;
    using std::setw;
    using std::setfill;
    using std::setprecision;
    using std::string;


//*** DEFINITION ***************************************************************
//--- TOP ------------------------------
    // FUNCTION
        #define CALC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)           \
        {                                                                                              \
            if (!flg) {                                                                                \
                flg = 1;                                                                               \
                string strFul = cfg->strPrefixDump                                                     \
                    +           strTag                                                                 \
                    +           (strObj != "" ? "_" + strObj : "")                                     \
                    +           (strIdx != "" ? "_" + strIdx : "")                                     \
                    +           (strTyp != "" ? "_" + strTyp : "")                                     \
                    +                           "." + strPst                                           \
                ;                                                                                      \
                fpt = fopen(strFul.c_str(), "w");                                                      \
                if (fpt == NULL) {                                                                     \
                    cerr << "[error from c model] cannot open dump file" << strFul.c_str() << endl;    \
                    assert(0);                                                                         \
                }                                                                                      \
            }                                                                                          \
        }
        #define CALC_FUNC_DMP_D_0(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt)    \
        {                                                                                                        \
            CALC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                         \
            string strFmtFul = strFmt + "\n";                                                                    \
            fprintf(fpt, strFmtFul.c_str(), dat & datMsk);                                                       \
        }
        #define CALC_FUNC_DMP_D_1(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz0, idxDlt0)    \
        {                                                                                                                       \
            CALC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                        \
            string strFmtFul = " " + strFmt;                                                                                    \
            for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                  \
                if (idx0 == 0)                                                                                                  \
                    fprintf(fpt,    strFmt.c_str(), dat[idx0] & datMsk);                                                        \
                else                                                                                                            \
                    fprintf(fpt, strFmtFul.c_str(), dat[idx0] & datMsk);                                                        \
            }                                                                                                                   \
            fprintf(fpt, "\n");                                                                                                 \
        }
        #define CALC_FUNC_DMP_D_2(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz1, idxDlt1, siz0, idxDlt0)    \
        {                                                                                                                                      \
            CALC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                                       \
            string strFmtFul = " " + strFmt;                                                                                                   \
            for (int idx1 = 0; idx1 < siz1; idx1 += idxDlt1) {                                                                                 \
                for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                             \
                    if (idx0 == 0)                                                                                                             \
                        fprintf(fpt,    strFmt.c_str(), (int)dat[idx1][idx0] & datMsk);                                                        \
                    else                                                                                                                       \
                        fprintf(fpt, strFmtFul.c_str(), (int)dat[idx1][idx0] & datMsk);                                                        \
                }                                                                                                                              \
                fprintf(fpt, "\n");                                                                                                            \
            }                                                                                                                                  \
        }
        #define CALC_FUNC_DMP_D_3(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz2, idxDlt2, siz1, idxDlt1, siz0, idxDlt0)    \
        {                                                                                                                                                     \
            CALC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                                                      \
            string strFmtFul = " " + strFmt;                                                                                                                  \
            for (int idx2 = 0; idx2 < siz2; idx2 += idxDlt2) {                                                                                                \
                for (int idx1 = 0; idx1 < siz1; idx1 += idxDlt1) {                                                                                            \
                    for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                                        \
                        if (idx0 == 0)                                                                                                                        \
                            fprintf(fpt,    strFmt.c_str(), dat[idx2][idx1][idx0] & datMsk);                                                                  \
                        else                                                                                                                                  \
                            fprintf(fpt, strFmtFul.c_str(), dat[idx2][idx1][idx0] & datMsk);                                                                  \
                    }                                                                                                                                         \
                    fprintf(fpt, "\n");                                                                                                                       \
                }                                                                                                                                             \
            }                                                                                                                                                 \
        }
        #define CALC_FUNC_DMP_D_4(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz3, idxDlt3, siz2, idxDlt2, siz1, idxDlt1, siz0, idxDlt0)    \
        {                                                                                                                                                                    \
            CALC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                                                                     \
            string strFmtFul = " " + strFmt;                                                                                                                                 \
            for (int idx3 = 0; idx3 < siz3; idx3 += idxDlt3) {                                                                                                               \
                for (int idx2 = 0; idx2 < siz2; idx2 += idxDlt2) {                                                                                                           \
                    for (int idx1 = 0; idx1 < siz1; idx1 += idxDlt1) {                                                                                                       \
                        for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                                                   \
                            if (idx0 == 0)                                                                                                                                   \
                                fprintf(fpt,    strFmt.c_str(), dat[idx3][idx2][idx1][idx0] & datMsk);                                                                       \
                            else                                                                                                                                             \
                                fprintf(fpt, strFmtFul.c_str(), dat[idx3][idx2][idx1][idx0] & datMsk);                                                                       \
                        }                                                                                                                                                    \
                        fprintf(fpt, "\n");                                                                                                                                  \
                    }                                                                                                                                                        \
                }                                                                                                                                                            \
            }                                                                                                                                                                \
        }

    // KNOB
        #define CALC_KNOB_TIME

    // SIZE
        #define CALC_SIZE_PREFIX    5


//--- KERNEL ---------------------------
    // SIZE
        #define CALC_SIZE_FRAME_X_MAX    1024
        #define CALC_SIZE_FRAME_Y_MAX    1024
        #define CALC_SIZE_FRAME_Z_MAX    16


//--- UNIT -----------------------------
    // SIZE
        #define CALC_SIZE_UNIT_X_MAX    32
        #define CALC_SIZE_UNIT_Y_MAX    32
        #define CALC_SIZE_UNIT_Z_MAX    CALC_SIZE_FRAME_Z_MAX


//--- COMMON ---------------------------
    // FUNC
        #define CALC_FUNC_LOG2(dat)    \
        (     (dat <= 1 <<  0) ?  0    \
            : (dat <= 1 <<  1) ?  1    \
            : (dat <= 1 <<  2) ?  2    \
            : (dat <= 1 <<  3) ?  3    \
            : (dat <= 1 <<  4) ?  4    \
            : (dat <= 1 <<  5) ?  5    \
            : (dat <= 1 <<  6) ?  6    \
            : (dat <= 1 <<  7) ?  7    \
            : (dat <= 1 <<  8) ?  8    \
            : (dat <= 1 <<  9) ?  9    \
            : (dat <= 1 << 10) ? 10    \
            : (dat <= 1 << 11) ? 11    \
            : (dat <= 1 << 12) ? 12    \
            : (dat <= 1 << 13) ? 13    \
            : (dat <= 1 << 14) ? 14    \
            : (dat <= 1 << 15) ? 15    \
            : (dat <= 1 << 16) ? 16    \
            : (dat <= 1 << 17) ? 17    \
            : (dat <= 1 << 18) ? 18    \
            : (dat <= 1 << 19) ? 19    \
            : (dat <= 1 << 20) ? 20    \
            : (dat <= 1 << 21) ? 21    \
            : (dat <= 1 << 22) ? 22    \
            : (dat <= 1 << 23) ? 23    \
            : (dat <= 1 << 24) ? 24    \
            : (dat <= 1 << 25) ? 25    \
            : (dat <= 1 << 26) ? 26    \
            : (dat <= 1 << 27) ? 27    \
            : (dat <= 1 << 28) ? 28    \
            : (dat <= 1 << 29) ? 29    \
            : (dat <= 1 << 30) ? 30    \
            : (dat <= 1 << 31) ? 31    \
            :                    32    \
        )
        #define CALC_FUNC_MIN(datX, datY)             ((datX) < (datY) ? (datX) : (datY))
        #define CALC_FUNC_MAX(datX, datY)             ((datX) > (datY) ? (datX) : (datY))
        #define CALC_FUNC_ROUND(dat, datPrc)          ((int)((dat) / (datPrc) + 0.5f) * (datPrc))
        #define CALC_FUNC_CLP(datMin, datMax, dat)    (((dat) < (datMin)) ? (datMin) : (((dat) > (datMax)) ? (datMax) : (dat)))
        #define CALC_FUNC_ABS(dat)                    (((dat) >= 0) ? (dat) : -(dat))

    // DATA
        #define CALC_DATA_WD     16
        #define CALC_DATA_MAX    (  (1 << (CALC_DATA_WD - 1)) - 1)
        #define CALC_DATA_MIN    (- (1 << (CALC_DATA_WD - 1))    )


//*** TYPEDEF ******************************************************************
//--- COMMON ---------------------------
    // calc_dat_t
        typedef int16_t    calc_dat_t ;

    // calc_datFul_t
        typedef int32_t    calc_datFul_t ;


//*** ENUMERATOR ***************************************************************
//--- UNIT -----------------------------
    // calc_enmLoad_t
        enum class calc_enmLoad_t {
            PIPE = 0,
            FILE,
            RANDOM
        };

    // calc_enmProc_t
        enum class calc_enmProc_t {
            SOFTWARE = 0,
            HARDWARE
        };

    // calc_enmInfo_t
        enum class calc_enmInfo_t {
            NONE = 0,
            TOP,
            KERNEL,
            UNIT,
            COMMON
        };

    // calc_enmDump_t
        enum class calc_enmDump_t {
            NONE = 0,
            INOUT,
            INTERMEDIATE
        };


//*** STRUCT *******************************************************************
//--- TOP ------------------------------
    // calc_cfg_t
        #include "calc_cfg_type.hpp"


//*** INLINE *******************************************************************
//--- COMMON ---------------------------
    #include "calc_common_tool_general.hpp"
    #include "calc_common_tool_calculation.hpp"

#endif /* __CALC_COMMON_HPP__ */
