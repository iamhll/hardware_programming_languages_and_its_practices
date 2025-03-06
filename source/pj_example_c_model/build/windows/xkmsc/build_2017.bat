::------------------------------------------------------------------------------
    ::
    ::  Filename       : build.bat
    ::  Author         : Huang Leilei
    ::  Status         : draft
    ::  Created        : 2025-02-18
    ::  Description    : create a windows building environment for xkmsc
    ::
::------------------------------------------------------------------------------

::*** MAIN BODY ****************************************************************
cmake ../../../source/xkmsc/top -G "Visual Studio 15 2017"
pause
