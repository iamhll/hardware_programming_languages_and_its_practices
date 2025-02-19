%------------------------------------------------------------------------------
    %
    %  Filename       : getPsnr.m
    %  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    %  Description    : calculate PSNR
    %
%-------------------------------------------------------------------------------

%*** PARAMETER *****************************************************************
CSTR_YUV_REF = '/mnt/e/DOWNLOAD/SEQUENCE/HM/BasketballPass/BasketballPass.yuv';    %REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
CSTR_YUV_DUT = '../../../build/linux/xkcdc/xkcdc.yuv';                             %REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
FLAG_VERBOSE = 1;                                                                  %REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
NUMB_FRAME   = 100;                                                                %REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
SIZE_FRAME_X = 416;                                                                %REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
SIZE_FRAME_Y = 240;                                                                %REVERT_THIS_ITEM_BEFORE_YOU_COMMIT


%*** MAIN BODY *****************************************************************
getPsnrCore(CSTR_YUV_REF    ...
    ,       CSTR_YUV_DUT    ...
    ,       FLAG_VERBOSE    ...
    ,       NUMB_FRAME      ...
    ,       SIZE_FRAME_X    ...
    ,       SIZE_FRAME_Y    ...
);
