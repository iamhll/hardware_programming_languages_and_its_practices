//------------------------------------------------------------------------------
    //
    //  Filename       : calc_cfg_dump.cpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : configuration related codes (dump)
    //
//------------------------------------------------------------------------------

//*** INCLUDE ******************************************************************
#include "calc_cfg.hpp"


//*** DEFINE *******************************************************************


//*** FUNCTION *****************************************************************
// calc_cfgDmp
void calc_cfgDmp(
calc_cfg_t *cfg)
{
    string str = cfg->strPrefixDump
        +        "dut_setting.vh"
    ;
    FILE *fpt = fopen(str.c_str(), "w");
    if (fpt == NULL) {
        cerr << "[error from c model] cannot open configuration file [" << str.c_str() << "] (dumped for hardware simulation)!" << endl;
        assert(0);
    }

    fprintf(fpt, "// KERNEL\n");
    fprintf(fpt, "`define CALC_SIZE_FRAME_X    'd%d\n", cfg->sizFrameX);
    fprintf(fpt, "`define CALC_SIZE_FRAME_Y    'd%d\n", cfg->sizFrameY);
    fprintf(fpt, "`define CALC_SIZE_FRAME_Z    'd%d\n", cfg->sizFrameZ);
    fprintf(fpt, "\n");

    fprintf(fpt, "// UNIT\n");
    fprintf(fpt, "`define CALC_SIZE_UNIT_X    'd%d\n", cfg->sizUnitX);
    fprintf(fpt, "`define CALC_SIZE_UNIT_Y    'd%d\n", cfg->sizUnitY);
    fprintf(fpt, "`define CALC_SIZE_UNIT_Z    'd%d\n", cfg->sizUnitZ);
    fprintf(fpt, "\n");

    fprintf(fpt, "// UNIT ADD\n");
    fprintf(fpt, "`define CALC_ADD_FLAG_SATURATION    'd%d\n", cfg->addFlgSaturation);
    fprintf(fpt, "\n");

    fprintf(fpt, "// UNIT SUB\n");
    fprintf(fpt, "`define CALC_SUB_FLAG_SATURATION    'd%d\n", cfg->subFlgSaturation);
    fprintf(fpt, "\n");

    fprintf(fpt, "// UNIT DIV\n");
    fprintf(fpt, "`define CALC_DIV_FLAG_SATURATION    'd%d\n", cfg->divFlgSaturation);
    fprintf(fpt, "\n");

    fprintf(fpt, "// UNIT MUL\n");
    fprintf(fpt, "`define CALC_MUL_FLAG_SATURATION    'd%d\n", cfg->mulFlgSaturation);
}
