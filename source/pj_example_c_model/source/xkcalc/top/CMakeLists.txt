#-------------------------------------------------------------------------------
    #
    #  Filename       : CMakeLists.txt
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : input list for cmake
    #
#-------------------------------------------------------------------------------

#*** GENERAL *******************************************************************
    cmake_minimum_required(VERSION 3.16)

    project(calc)

    set(CMAKE_C_FLAGS      "${CMAKE_C_FLAGS}              -g -Wall -O3 -static -fno-strict-aliasing -pthread")
    set(CMAKE_CXX_FLAGS    "${CMAKE_CXX_FLAGS} -std=c++11 -g -Wall -O3 -static -fno-strict-aliasing -pthread")


#*** DEFINITION ****************************************************************


#*** INCLUDE *******************************************************************
    include_directories(.                   )
    include_directories(../top/configuration)
    include_directories(../kernel           )
    include_directories(../kernel/fetcher   )
    include_directories(../kernel/dumper    )
    include_directories(../unit             )
    include_directories(../unit/adder       )
    include_directories(../unit/substrator  )
    include_directories(../unit/multiplier  )
    include_directories(../unit/divider     )
    include_directories(../common/unit      )
    include_directories(../common           )


#*** SOURCE ********************************************************************
    aux_source_directory(.                    SOURCE)
    aux_source_directory(../top/configuration SOURCE)
    aux_source_directory(../kernel            SOURCE)
    aux_source_directory(../kernel/fetcher    SOURCE)
    aux_source_directory(../kernel/dumper     SOURCE)
    aux_source_directory(../unit              SOURCE)
    aux_source_directory(../unit/adder        SOURCE)
    aux_source_directory(../unit/substrator   SOURCE)
    aux_source_directory(../unit/multiplier   SOURCE)
    aux_source_directory(../unit/divider      SOURCE)
    aux_source_directory(../common/unit       SOURCE)
    aux_source_directory(../common            SOURCE)


#*** EXECUTION *****************************************************************
    add_executable(xkcalc ${SOURCE})
