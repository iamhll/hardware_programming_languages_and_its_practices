//------------------------------------------------------------------------------
    //
    //  Filename       : calc_fth.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : fetcher related headers
    //
//------------------------------------------------------------------------------

#ifndef __CALC_FTH_HPP__
#define __CALC_FTH_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_common.hpp"


//*** CLASS ********************************************************************
class CALC_FTH
{
//--- PRIVATE VARIABLE -----------------
private:
    // data
        calc_dat_t (*m_datInp)[CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX];


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        //CALC_FTH();
        //~CALC_FTH();
        void connect(calc_dat_t (*datInp) [CALC_SIZE_FRAME_Z_MAX][CALC_SIZE_FRAME_Y_MAX][CALC_SIZE_FRAME_X_MAX]);

    // copy
        void cpyDatInp(calc_dat_t datInp[CALC_SIZE_UNIT_Z_MAX][CALC_SIZE_UNIT_Y_MAX][CALC_SIZE_UNIT_X_MAX], const calc_cfg_t &cfg);
};

#endif /* __CALC_FTH_HPP__ */
