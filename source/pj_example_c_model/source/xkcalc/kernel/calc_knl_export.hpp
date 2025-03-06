//------------------------------------------------------------------------------
    //
    //  Filename       : calc_knl_export.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related headers (export)
    //
//------------------------------------------------------------------------------

#ifndef __CALC_KNL_EXPORT_HPP__
#define __CALC_KNL_EXPORT_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_cfg.hpp"


//*** CLASS ********************************************************************
// CALC_KNL
class CALC_KNL;

// CALC_KNL_EXPORT
class CALC_KNL_EXPORT
{
//--- PRIVATE VARIABLE -----------------
private:
    // module
        CALC_KNL *m_knl;


//--- PUBLIC FUNCTION ------------------
public:
    // basic
    CALC_KNL_EXPORT();
    ~CALC_KNL_EXPORT();
    void connect(calc_cfg_t &cfg);
    void oneShot();

    // display
    void dspRunTime();
};

#endif /* __CALC_KNL_EXPORT_HPP__ */
