//------------------------------------------------------------------------------
    //
    //  Filename       : calc_cfg_type.hpp
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

#ifndef __CALC_CFG_TYPE_HPP__
#define __CALC_CFG_TYPE_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_common.hpp"


//*** TYPE *********************************************************************
    struct calc_cfg_t {
        // changeable
        int         idxFrame;
        int         idxUnitX;
        int         idxUnitY;

        // top
        string      strFileInp;
        string      strFileOut;
        string      strPrefixDump;
        string      strPrefixLoad;
        int         numFrame;
        int         sizFrameX;
        int         sizFrameY;
        int         sizFrameZ;
        int         enmProc;
        int         enmInfo;
        int         enmLoad;
        int         datSeed;
        int         sizUnitX;
        int         sizUnitY;
        int         sizUnitZ;

        // adder
        bool        addFlgProc;
        bool        addFlgSaturation;
        int         addEnmLoad;
        int         addEnmDump;

        // substrator
        bool        subFlgProc;
        bool        subFlgSaturation;
        int         subEnmLoad;
        int         subEnmDump;

        // multiplier
        bool        mulFlgProc;
        bool        mulFlgSaturation;
        int         mulEnmLoad;
        int         mulEnmDump;

        // divider
        bool        divFlgProc;
        bool        divFlgSaturation;
        int         divEnmLoad;
        int         divEnmDump;

        // example
        int         exampleDatInt;
        double      exampleDatDouble;
        int         exampleDatVector[2];
        int         exampleDatArray[2][3];

        // derived
        int         numUnitX;
        int         numUnitY;

        // =
        calc_cfg_t &operator=(const calc_cfg_t &cfg) {
            // changeable
            idxFrame               = cfg.idxFrame        ;
            idxUnitX               = cfg.idxUnitX        ;
            idxUnitY               = cfg.idxUnitY        ;

            // top
            strFileInp             = cfg.strFileInp      ;
            strFileOut             = cfg.strFileOut      ;
            strPrefixDump          = cfg.strPrefixDump   ;
            strPrefixLoad          = cfg.strPrefixLoad   ;
            numFrame               = cfg.numFrame        ;
            sizFrameX              = cfg.sizFrameX       ;
            sizFrameY              = cfg.sizFrameY       ;
            sizFrameZ              = cfg.sizFrameZ       ;
            enmProc                = cfg.enmProc         ;
            enmInfo                = cfg.enmInfo         ;
            enmLoad                = cfg.enmLoad         ;
            datSeed                = cfg.datSeed         ;
            sizUnitX               = cfg.sizUnitX        ;
            sizUnitY               = cfg.sizUnitY        ;
            sizUnitZ               = cfg.sizUnitZ        ;

            // adder
            addFlgProc             = cfg.addFlgProc      ;
            addFlgSaturation       = cfg.addFlgSaturation;
            addEnmLoad             = cfg.addEnmLoad      ;
            addEnmDump             = cfg.addEnmDump      ;

            // substrator
            subFlgProc             = cfg.subFlgProc      ;
            subFlgSaturation       = cfg.subFlgSaturation;
            subEnmLoad             = cfg.subEnmLoad      ;
            subEnmDump             = cfg.subEnmDump      ;

            // multiplier
            mulFlgProc             = cfg.mulFlgProc      ;
            mulFlgSaturation       = cfg.mulFlgSaturation;
            mulEnmLoad             = cfg.mulEnmLoad      ;
            mulEnmDump             = cfg.mulEnmDump      ;

            // divider
            divFlgProc             = cfg.divFlgProc      ;
            divFlgSaturation       = cfg.divFlgSaturation;
            divEnmLoad             = cfg.divEnmLoad      ;
            divEnmDump             = cfg.divEnmDump      ;

            // example
            exampleDatInt          = cfg.exampleDatInt   ;
            exampleDatDouble       = cfg.exampleDatDouble;
            memcpy(exampleDatVector, cfg.exampleDatVector, sizeof(exampleDatVector));
            memcpy(exampleDatArray , cfg.exampleDatArray , sizeof(exampleDatArray ));

            // derived
            numUnitX               = cfg.numUnitX        ;
            numUnitY               = cfg.numUnitY        ;
            return *this;
        }
    };

#endif /* __CALC_CFG_TYPE_HPP__ */
