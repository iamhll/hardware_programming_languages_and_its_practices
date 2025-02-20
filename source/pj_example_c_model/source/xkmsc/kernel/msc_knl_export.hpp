//------------------------------------------------------------------------------
    //
    //  Filename       : msc_knl_export.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : kernel related headers (export)
    //
//------------------------------------------------------------------------------

#ifndef __MSC_KNL_EXPORT_HPP__
#define __MSC_KNL_EXPORT_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_cfg.hpp"


//*** CLASS ********************************************************************
// MSC_KNL
class MSC_KNL;

// MSC_KNL_EXPORT
class MSC_KNL_EXPORT
{
//--- PRIVATE VARIABLE -----------------
private:
    // module
        MSC_KNL *m_knl;


//--- PUBLIC FUNCTION ------------------
public:
    // basic
    MSC_KNL_EXPORT();
    ~MSC_KNL_EXPORT();
    void connect(msc_cfg_t &cfg);
    void oneShot();

    // display
    void dspRunTime();
};

#endif /* __MSC_KNL_EXPORT_HPP__ */
