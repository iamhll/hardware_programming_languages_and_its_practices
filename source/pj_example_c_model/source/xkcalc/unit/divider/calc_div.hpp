//------------------------------------------------------------------------------
    //
    //  Filename       : calc_div.hpp
    //  Author         : Huang Leilei
    //  Status         : draft
    //  Created        : 2025-02-18
    //  Description    : divider related headers
    //
//------------------------------------------------------------------------------

#ifndef __CALC_DIV_HPP__
#define __CALC_DIV_HPP__

//*** INCLUDE ******************************************************************
    #include "calc_unit.hpp"


//*** DEFINE *******************************************************************


//*** CLASS ********************************************************************
// CALC_DIV
class CALC_DIV: public CALC_UNIT
{
//--- PRIVATE ENUMERATOR ---------------
private:


//--- PRIVATE VARIABLE -----------------
private:
    // connection
        CALC_UNIT *m_unitPrev;

    // information
        //...

    // data
        //...

    // cost
        //...

    // debug
        //...


//--- PRIVATE FUNCTION -----------------
private:
    // load
        virtual void loadPipe();
      //virtual void loadFile();
      //virtual void loadRand();

    // process
      //virtual void procPrev();
        virtual void procCore();
        virtual void procPost();

        inline void procCoreDiv() {
            for (int k = 0; k < m_cfg->sizUnitZ; ++k) {
                for (int j = 0; j < m_cfg->sizUnitY; ++j) {
                    for (int i = 0; i < m_cfg->sizUnitX; ++i) {
                        // core
                        (*m_datOut)[k][j][i] = calc_getDatDiv(m_cfg->addFlgSaturation, (*m_datInp0)[k][j][i], (*m_datInp1)[k][j][i]);
                        // log
                        if ((calc_enmInfo_t)m_cfg->enmInfo >= calc_enmInfo_t::COMMON) {
                            printf("    %02d-%04d-%04d: 0x%04x * 0x10000 / 0x%04x = 0x%04x\n", k, j, i,
                                (*m_datInp0)[k][j][i] & 0xffff,
                                (*m_datInp1)[k][j][i] & 0xffff,
                                (*m_datOut )[k][j][i] & 0xffff
                            );
                        }
                    }
                }
            }
        }

    // dump
      //virtual void dumpFile();


//--- PUBLIC FUNCTION ------------------
public:
    // basic
        CALC_DIV();
      //~CALC_DIV();
        virtual void connect(calc_cfg_t &cfg, CALC_FTH &fth, CALC_DMP &dmp, CALC_UNIT &unit);
};

#endif /* __CALC_DIV_HPP__ */
