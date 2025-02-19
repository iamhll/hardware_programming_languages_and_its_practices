//------------------------------------------------------------------------------
    //
    //  Filename       : calc_dmp.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : dumper related headers
    //
//------------------------------------------------------------------------------

#ifndef __CALC_DMP_HPP__
#define __CALC_DMP_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_common.hpp"


//*** CLASS ********************************************************************
class CALC_DMP
{
//--- PRIVATE VARIABLE -----------------
private:
    // data
        calc_dat_t (*m_datOut)[CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX];


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        //CALC_DMP();
        //~CALC_DMP();
        void connect(calc_dat_t (*datOut) [CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX]);

    // set
        void setDatOut(const calc_cfg_t &cfg, calc_dat_t datOut[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX]);
};

#endif /* __CALC_DMP_HPP__ */
