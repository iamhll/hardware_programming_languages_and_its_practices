//------------------------------------------------------------------------------
    //
    //  Filename       : msc_cfg_type.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related header (type)
    //
//------------------------------------------------------------------------------
    //
    //  *** auto-generated, please do NOT modify it mannually ***
    //
//------------------------------------------------------------------------------

#ifndef __MSC_CFG_TYPE_HPP__
#define __MSC_CFG_TYPE_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_common.hpp"


//*** TYPE *********************************************************************
    struct msc_cfg_t {
        // changeable
        int         idxFrame;
        int         idxUnitX;
        int         idxUnitY;

        // top
        string      strFileIn;
        string      strFileOut;
        string      strPrefixDump;
        string      strPrefixLoad;
        int         numFrame;
        int         sizFrameX;
        int         sizFrameY;
        int         sizFrameZ;
        int         enmFormatIn;
        int         enmProc;
        int         enmInfo;
        int         enmLoad;
        int         enmDump;
        int         datSeed;
        int         sizUnitX;
        int         sizUnitY;

        // scaler
        bool        sclFlgProc;
        int         sclNumTap;
        int         sclSizFrameX;
        int         sclSizFrameY;
        int         sclEnmMode;
        int         sclEnmLoad;
        int         sclEnmDump;
        double      sclDatThreshold2;
        int         sclDatThreshold4;

        // filter
        bool        fltFlgProc;
        int         fltEnmLoad;
        int         fltEnmDump;
        double      fltDatCoe[3][3];

        // on-screen-display
        bool        osdFlgProc;
        string      osdStrFile0;
        string      osdStrFile1;
        string      osdStrFile2;
        string      osdStrFile3;
        string      osdStrFile4;
        string      osdStrFile5;
        string      osdStrFile6;
        string      osdStrFile7;
        bool        osdFlg[8];
        int         osdSizFrameX[8];
        int         osdSizFrameY[8];
        int         osdPosFrameX[8];
        int         osdPosFrameY[8];
        int         osdEnmLoad;
        int         osdEnmMode[8];
        int         osdEnmDump;
        int         osdDatScl[8][2];
        int         osdDatLut0[4][4];
        int         osdDatLut1[4][4];
        int         osdDatLut2[4][4];
        int         osdDatLut3[4][4];
        int         osdDatLut4[4][4];
        int         osdDatLut5[4][4];
        int         osdDatLut6[4][4];
        int         osdDatLut7[4][4];

        // example
        int         exampleDatInt;
        double      exampleDatDouble;
        int         exampleDatVector[2];
        int         exampleDatArray[2][3];

        // derived
        int         numUnitX;
        int         numUnitY;
        double      datScalerX;
        double      datScalerY;
        double      sclDatThreshold2Inv;

        // =
        msc_cfg_t &operator=(const msc_cfg_t &cfg) {
            // changeable
            idxFrame                  = cfg.idxFrame           ;
            idxUnitX                  = cfg.idxUnitX           ;
            idxUnitY                  = cfg.idxUnitY           ;

            // top
            strFileIn                 = cfg.strFileIn          ;
            strFileOut                = cfg.strFileOut         ;
            strPrefixDump             = cfg.strPrefixDump      ;
            strPrefixLoad             = cfg.strPrefixLoad      ;
            numFrame                  = cfg.numFrame           ;
            sizFrameX                 = cfg.sizFrameX          ;
            sizFrameY                 = cfg.sizFrameY          ;
            sizFrameZ                 = cfg.sizFrameZ          ;
            enmFormatIn               = cfg.enmFormatIn        ;
            enmProc                   = cfg.enmProc            ;
            enmInfo                   = cfg.enmInfo            ;
            enmLoad                   = cfg.enmLoad            ;
            enmDump                   = cfg.enmDump            ;
            datSeed                   = cfg.datSeed            ;
            sizUnitX                  = cfg.sizUnitX           ;
            sizUnitY                  = cfg.sizUnitY           ;

            // scaler
            sclFlgProc                = cfg.sclFlgProc         ;
            sclNumTap                 = cfg.sclNumTap          ;
            sclSizFrameX              = cfg.sclSizFrameX       ;
            sclSizFrameY              = cfg.sclSizFrameY       ;
            sclEnmMode                = cfg.sclEnmMode         ;
            sclEnmLoad                = cfg.sclEnmLoad         ;
            sclEnmDump                = cfg.sclEnmDump         ;
            sclDatThreshold2          = cfg.sclDatThreshold2   ;
            sclDatThreshold4          = cfg.sclDatThreshold4   ;

            // filter
            fltFlgProc                = cfg.fltFlgProc         ;
            fltEnmLoad                = cfg.fltEnmLoad         ;
            fltEnmDump                = cfg.fltEnmDump         ;
            memcpy(fltDatCoe          , cfg.fltDatCoe          , sizeof(fltDatCoe          ));

            // on-screen-display
            osdFlgProc                = cfg.osdFlgProc         ;
            osdStrFile0               = cfg.osdStrFile0        ;
            osdStrFile1               = cfg.osdStrFile1        ;
            osdStrFile2               = cfg.osdStrFile2        ;
            osdStrFile3               = cfg.osdStrFile3        ;
            osdStrFile4               = cfg.osdStrFile4        ;
            osdStrFile5               = cfg.osdStrFile5        ;
            osdStrFile6               = cfg.osdStrFile6        ;
            osdStrFile7               = cfg.osdStrFile7        ;
            memcpy(osdFlg             , cfg.osdFlg             , sizeof(osdFlg             ));
            memcpy(osdSizFrameX       , cfg.osdSizFrameX       , sizeof(osdSizFrameX       ));
            memcpy(osdSizFrameY       , cfg.osdSizFrameY       , sizeof(osdSizFrameY       ));
            memcpy(osdPosFrameX       , cfg.osdPosFrameX       , sizeof(osdPosFrameX       ));
            memcpy(osdPosFrameY       , cfg.osdPosFrameY       , sizeof(osdPosFrameY       ));
            osdEnmLoad                = cfg.osdEnmLoad         ;
            memcpy(osdEnmMode         , cfg.osdEnmMode         , sizeof(osdEnmMode         ));
            osdEnmDump                = cfg.osdEnmDump         ;
            memcpy(osdDatScl          , cfg.osdDatScl          , sizeof(osdDatScl          ));
            memcpy(osdDatLut0         , cfg.osdDatLut0         , sizeof(osdDatLut0         ));
            memcpy(osdDatLut1         , cfg.osdDatLut1         , sizeof(osdDatLut1         ));
            memcpy(osdDatLut2         , cfg.osdDatLut2         , sizeof(osdDatLut2         ));
            memcpy(osdDatLut3         , cfg.osdDatLut3         , sizeof(osdDatLut3         ));
            memcpy(osdDatLut4         , cfg.osdDatLut4         , sizeof(osdDatLut4         ));
            memcpy(osdDatLut5         , cfg.osdDatLut5         , sizeof(osdDatLut5         ));
            memcpy(osdDatLut6         , cfg.osdDatLut6         , sizeof(osdDatLut6         ));
            memcpy(osdDatLut7         , cfg.osdDatLut7         , sizeof(osdDatLut7         ));

            // example
            exampleDatInt             = cfg.exampleDatInt      ;
            exampleDatDouble          = cfg.exampleDatDouble   ;
            memcpy(exampleDatVector   , cfg.exampleDatVector   , sizeof(exampleDatVector   ));
            memcpy(exampleDatArray    , cfg.exampleDatArray    , sizeof(exampleDatArray    ));

            // derived
            numUnitX                  = cfg.numUnitX           ;
            numUnitY                  = cfg.numUnitY           ;
            datScalerX                = cfg.datScalerX         ;
            datScalerY                = cfg.datScalerY         ;
            sclDatThreshold2Inv       = cfg.sclDatThreshold2Inv;
            return *this;
        }
    };

#endif /* __MSC_CFG_TYPE_HPP__ */
