//------------------------------------------------------------------------------
    //
    //  Filename       : calc_cfg.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related header
    //
//------------------------------------------------------------------------------

#ifndef __CALC_CFG_HPP__
#define __CALC_CFG_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_cfg_type.hpp"


//*** DEFINITION ***************************************************************
    #define CALC_CFG_ENUM_LVL_RLS    (calc_enmLvlCfg_t::DETAILED)


//*** TYPE *********************************************************************
    // calc_enmLvlCfg_t
        enum class calc_enmLvlCfg_t {
            ROUGH = 0,
            DETAILED
        };


//*** FUNCTION *****************************************************************
    // written manually
        int  calc_cfgIni        (calc_cfg_t *cfg, int numArg, char *strArg[]);
        int  calc_cfgIniFromFile(calc_cfg_t *cfg, int numArg, char *strArg[]);
        int  calc_cfgIniFromCli (calc_cfg_t *cfg, int numArg, char *strArg[]);
        void calc_cfgDmp        (calc_cfg_t *cfg);

    // written by scripts
        void calc_cfgRst   (calc_cfg_t *cfg);
        void calc_cfgHlp   (calc_cfg_t *cfg);
        void calc_cfgMap   (calc_cfg_t *cfg, const string *strKey, const string *strDat);
        void calc_cfgL2X   (calc_cfg_t *cfg);
        int  calc_cfgChk   (calc_cfg_t *cfg);
        int  calc_cfgChkMan(calc_cfg_t *cfg);
        void calc_cfgLog   (calc_cfg_t *cfg);

#endif /* __CALC_CFG_HPP__ */
