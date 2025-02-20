#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runListUpdate.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : push list
    #
#-------------------------------------------------------------------------------

#*** MAIN BODY *****************************************************************
git push -f origin master
git push -f aliyun master
#git checkout masterGithub ; git push -f github HEAD:master ; git checkout master
