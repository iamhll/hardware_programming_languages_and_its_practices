//------------------------------------------------------------------------------
    //
    //  Filename       : msc_dmp.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : dumper related headers
    //
//------------------------------------------------------------------------------

#ifndef __MSC_DMP_HPP__
#define __MSC_DMP_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_common.hpp"


//*** CLASS ********************************************************************
class MSC_DMP
{
//--- PRIVATE VARIABLE -----------------
private:
    // data
        msc_pxl_t (*m_datOut)[MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX];


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        //MSC_DMP();
        //~MSC_DMP();
        void connect(msc_pxl_t (*datOut) [MSC_SIZE_FRAME_Z_MAX][MSC_SIZE_FRAME_Y_MAX][MSC_SIZE_FRAME_X_MAX]);

    // set
        void setDatOut(const msc_cfg_t &cfg, msc_pxl_t datOut[MSC_SIZE_UNIT_Z_MAX][MSC_SIZE_UNIT_Y_MAX][MSC_SIZE_UNIT_X_MAX]);
};

#endif /* __MSC_DMP_HPP__ */
