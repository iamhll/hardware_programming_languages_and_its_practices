//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_fth.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : fetcher related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_FTH_HPP__
#define __MSC_FTH_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_common.hpp"


//*** CLASS ********************************************************************
class MSC_FTH
{
//--- PRIVATE VARIABLE -----------------
private:
    // data
        msc_pxl_t (*m_datIn)[MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];

    // osd
        msc_osd_t (*m_datOsd)[MSC_OSD_NUMB_MAX][MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        //MSC_FTH();
        //~MSC_FTH();
        void connect(msc_pxl_t (*datIn )                   [MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX],
                     msc_osd_t (*datOsd) [MSC_OSD_NUMB_MAX][MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX]
        );

    // copy
        void cpyDatIn (msc_pxl_t datIn [MSC_SIZE_UNIT_Z_MAX    ][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX], const msc_cfg_t &cfg);
        void cpyDatOsd(msc_osd_t datOsd[MSC_SIZE_UNIT_Z_MAX + 1][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX], const msc_cfg_t &cfg, int idxOsd);
};

#endif /* __MSC_FTH_HPP__ */
