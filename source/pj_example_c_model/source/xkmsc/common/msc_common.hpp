//------------------------------------------------------------------------------
    //
    //  Filename       : msc_common.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : common related headers
    //
//------------------------------------------------------------------------------

// TODO: optmize those comments to support both doxygen and vscode

#ifndef __MSC_COMMON_HPP__
#define __MSC_COMMON_HPP__

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
    #include <string>
    #ifdef   MSC_KNOB_TIME
    #ifdef   __linux__
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
    using std::to_string;


//*** DEFINITION ***************************************************************
//--- TOP ------------------------------
    // FUNCTION
        #define MSC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                     \
        {                                                                                                       \
            if (!flg) {                                                                                         \
                flg = 1;                                                                                        \
                string strFul = cfg->strPrefixDump                                                              \
                    +                                 (m_strTag.c_str() + MSC_SIZE_PREFIX)                      \
                    +           (strObj != "" ? "_" + strObj : "")                                              \
                    +           (strIdx != "" ? "_" + strIdx : "")                                              \
                    +           (strTyp != "" ? "_" + strTyp : "")                                              \
                    +                           "." + strPst                                                    \
                ;                                                                                               \
                fpt = fopen(strFul.c_str(), "w");                                                               \
                if (fpt == NULL) {                                                                              \
                    cerr << "[error from c model] cannot open dump file [" << strFul.c_str() << "]" << endl;    \
                    assert(0);                                                                                  \
                }                                                                                               \
            }                                                                                                   \
        }
        #define MSC_FUNC_DMP_D_0(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt)    \
        {                                                                                                       \
            MSC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                         \
            string strFmtFul = strFmt + "\n";                                                                   \
            fprintf(fpt, strFmtFul.c_str(), dat & datMsk);                                                      \
        }
        #define MSC_FUNC_DMP_D_1(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz0, idxDlt0)    \
        {                                                                                                                      \
            MSC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                        \
            string strFmtFul = " " + strFmt;                                                                                   \
            for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                 \
                if (idx0 == 0)                                                                                                 \
                    fprintf(fpt,    strFmt.c_str(), dat[idx0] & datMsk);                                                       \
                else                                                                                                           \
                    fprintf(fpt, strFmtFul.c_str(), dat[idx0] & datMsk);                                                       \
            }                                                                                                                  \
            fprintf(fpt, "\n");                                                                                                \
        }
        #define MSC_FUNC_DMP_D_2(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz1, idxDlt1, siz0, idxDlt0)    \
        {                                                                                                                                     \
            MSC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                                       \
            string strFmtFul = " " + strFmt;                                                                                                  \
            for (int idx1 = 0; idx1 < siz1; idx1 += idxDlt1) {                                                                                \
                for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                            \
                    if (idx0 == 0)                                                                                                            \
                        fprintf(fpt,    strFmt.c_str(), (int)dat[idx1][idx0] & datMsk);                                                       \
                    else                                                                                                                      \
                        fprintf(fpt, strFmtFul.c_str(), (int)dat[idx1][idx0] & datMsk);                                                       \
                }                                                                                                                             \
                fprintf(fpt, "\n");                                                                                                           \
            }                                                                                                                                 \
        }
        #define MSC_FUNC_DMP_D_3(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz2, idxDlt2, siz1, idxDlt1, siz0, idxDlt0)    \
        {                                                                                                                                                    \
            MSC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                                                      \
            string strFmtFul = " " + strFmt;                                                                                                                 \
            for (int idx2 = 0; idx2 < siz2; idx2 += idxDlt2) {                                                                                               \
                for (int idx1 = 0; idx1 < siz1; idx1 += idxDlt1) {                                                                                           \
                    for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                                       \
                        if (idx0 == 0)                                                                                                                       \
                            fprintf(fpt,    strFmt.c_str(), dat[idx2][idx1][idx0] & datMsk);                                                                 \
                        else                                                                                                                                 \
                            fprintf(fpt, strFmtFul.c_str(), dat[idx2][idx1][idx0] & datMsk);                                                                 \
                    }                                                                                                                                        \
                    fprintf(fpt, "\n");                                                                                                                      \
                }                                                                                                                                            \
            }                                                                                                                                                \
        }
        #define MSC_FUNC_DMP_D_4(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst, dat, datMsk, strFmt, siz3, idxDlt3, siz2, idxDlt2, siz1, idxDlt1, siz0, idxDlt0)    \
        {                                                                                                                                                                   \
            MSC_FUNC_INI_FPT_DMP(cfg, flg, fpt, strTag, strObj, strIdx, strTyp, strPst)                                                                                     \
            string strFmtFul = " " + strFmt;                                                                                                                                \
            for (int idx3 = 0; idx3 < siz3; idx3 += idxDlt3) {                                                                                                              \
                for (int idx2 = 0; idx2 < siz2; idx2 += idxDlt2) {                                                                                                          \
                    for (int idx1 = 0; idx1 < siz1; idx1 += idxDlt1) {                                                                                                      \
                        for (int idx0 = 0; idx0 < siz0; idx0 += idxDlt0) {                                                                                                  \
                            if (idx0 == 0)                                                                                                                                  \
                                fprintf(fpt,    strFmt.c_str(), dat[idx3][idx2][idx1][idx0] & datMsk);                                                                      \
                            else                                                                                                                                            \
                                fprintf(fpt, strFmtFul.c_str(), dat[idx3][idx2][idx1][idx0] & datMsk);                                                                      \
                        }                                                                                                                                                   \
                        fprintf(fpt, "\n");                                                                                                                                 \
                    }                                                                                                                                                       \
                }                                                                                                                                                           \
            }                                                                                                                                                               \
        }

    // KNOB
        #define MSC_KNOB_TIME

    // SIZE
        #define MSC_SIZE_PREFIX    4

    // DATA
        #define MSC_DATA_SHIFT_CH    1


//--- KERNEL ---------------------------
    // SIZE
        #define MSC_SIZE_FRAME_X_MAX    4096
        #define MSC_SIZE_FRAME_Y_MAX    4096
        #define MSC_SIZE_FRAME_Z_MAX    3


//--- UNIT -----------------------------
    // SIZE
        #define MSC_SIZE_UNIT_X_MAX    64
        #define MSC_SIZE_UNIT_Y_MAX    64
        #define MSC_SIZE_UNIT_Z_MAX    MSC_SIZE_FRAME_Z_MAX


//--- UNIT FLT -------------------------
    // SIZE
        #define MSC_FLT_SIZE    1


//--- UNIT OSD -------------------------
    // NUMB
        #define MSC_OSD_NUMB_MAX    8


//--- COMMON ---------------------------
    // FUNC
        #define MSC_FUNC_LOG2(dat)     \
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
        #define MSC_FUNC_MIN(datX, datY)             ((datX) < (datY) ? (datX) : (datY))
        #define MSC_FUNC_MAX(datX, datY)             ((datX) > (datY) ? (datX) : (datY))
        #define MSC_FUNC_ROUND(dat, datPrc)          ((int)((dat) / (datPrc) + 0.5f) * (datPrc))
        #define MSC_FUNC_CLP(datMin, datMax, dat)    (((dat) < (datMin)) ? (datMin) : (((dat) > (datMax)) ? (datMax) : (dat)))
        #define MSC_FUNC_ABS(dat)                    (((dat) >= 0) ? (dat) : -(dat))

    // DATA
        #define MSC_DATA_WD     8
        #define MSC_DATA_MAX    ((1 << MSC_DATA_WD) - 1)
        #define MSC_DATA_MIN    0


//*** TYPEDEF ******************************************************************
//--- COMMON ---------------------------
    // msc_pxl_t
        typedef uint8_t    msc_pxl_t ;


//--- UNIT -----------------------------
    // msc_osd_t
        typedef uint16_t    msc_osd_t ;


//*** ENUMERATOR ***************************************************************
//--- TOP ------------------------------
    // msc_enmFormatIn_t
        enum class msc_enmFormatIn_t {
            YUV420p = 0,
            NV12
        };

    // msc_enmLoad_t
        enum class msc_enmLoad_t {
            PIPE = 0,
            FILE,
            RANDOM
        };

    // msc_enmProc_t
        enum class msc_enmProc_t {
            SOFTWARE = 0,
            HARDWARE
        };

    // msc_enmInfo_t
        enum class msc_enmInfo_t {
            NONE = 0,
            TOP,
            KERNEL,
            UNIT,
            COMMON
        };

    // msc_enmDump_t
        enum class msc_enmDump_t {
            NONE = 0,
            INOUT,
            INTERMEDIATE
        };


//--- UNIT SCL -------------------------
    // msc_sclEnmMode_t
        enum class msc_sclEnmMode_t {
            BILINEAR = 0,
            BICUBIC
        };


//--- UNIT OSD -------------------------
    // msc_osdEnmMode_t
        enum class msc_osdEnmMode_t {
            DATA_YUV420 = 0,
            DATA_AYUV1555,
            INDX_2,
            INDX_4,
            DATA_ARGB1555
        };


//*** STRUCT *******************************************************************
//--- TOP ------------------------------
    // msc_cfg_t
        #include "msc_cfg_type.hpp"


//*** INLINE *******************************************************************
//--- COMMON ---------------------------
    #include "msc_common_tool_general.hpp"
    #include "msc_common_tool_calculation.hpp"

#endif /* __MSC_COMMON_HPP__ */
