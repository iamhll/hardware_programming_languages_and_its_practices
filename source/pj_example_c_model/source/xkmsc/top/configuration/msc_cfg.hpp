//------------------------------------------------------------------------------
    //
    //  Filename       : msc_cfg.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related header
    //
//------------------------------------------------------------------------------

#ifndef __MSC_CFG_HPP__
#define __MSC_CFG_HPP__

//*** INCLUDE ******************************************************************
    #include "msc_cfg_type.hpp"


//*** DEFINITION ***************************************************************
    #define MSC_CFG_ENUM_LVL_RLS    (msc_enmLvlCfg_t::DETAILED)


//*** TYPE *********************************************************************
    // msc_enmLvlCfg_t
        enum class msc_enmLvlCfg_t {
            ROUGH = 0,
            DETAILED
        };


//*** FUNCTION *****************************************************************
    // written manually
        int  msc_cfgIni        (msc_cfg_t *cfg, int numArg, char *strArg[]);
        int  msc_cfgIniFromFile(msc_cfg_t *cfg, int numArg, char *strArg[]);
        int  msc_cfgIniFromCli (msc_cfg_t *cfg, int numArg, char *strArg[]);
        void msc_cfgDmp        (msc_cfg_t *cfg);

    // written by scripts
        void msc_cfgRst   (msc_cfg_t *cfg);
        void msc_cfgHlp   (msc_cfg_t *cfg);
        void msc_cfgMap   (msc_cfg_t *cfg, const string *strKey, const string *strDat);
        void msc_cfgL2X   (msc_cfg_t *cfg);
        int  msc_cfgChk   (msc_cfg_t *cfg);
        int  msc_cfgChkMan(msc_cfg_t *cfg);
        void msc_cfgLog   (msc_cfg_t *cfg);

#endif /* __MSC_CFG_HPP__ */
