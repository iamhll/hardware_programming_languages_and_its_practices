.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about xkmscSessionTest
   ..
.. -----------------------------------------------------------------------------

xkmscSessionTest
=================

*xkmsc* is a light-weighting tool to scale YUV images,
while *sessionTest* is the corresponding test environment for it,
which could do regression test to check the validity and performance (PSNR)


Contents
--------

   sessionTest includes

   .. table::
      :align: left
      :widths: auto

      ====================== =========================================================
       File Name              Descriptions
      ====================== =========================================================
       runXkmsc.sh            regression script
       xkmsc                  executable file
       xkmsc.cfg              configuration file
       xkmsc.html.tar         this document
       script/getPsnr.py      python script to calculate PSNR (both wrapper and core)
       script/getPsnr.m       matlab script to calculate PSNR (wrapper)
       script/getPsnrCore.m   matlab script to calculate PSNR (core)
       dump/runs.log          md5sum of all the generated YUV files
       dump/results.log       PSNR of all the genrated bitsteams
      ====================== =========================================================


Function
--------

   For each YUV, sessionTest

   #. extracts *CSTR_VECT* (YUV name), *NUMB_FRAME* (frame number), *SIZE_FRAME_X* (frame width) and *SIZE_FRAME_Y* (frame height) from parameter *CSTR_INFO_VECT_ALL* (vector list)
   #. derives *SIZE_FRAME_SCALED_X* (scaled frame width) and *SIZE_FRAME_SCALED_Y* (scaled frame height) from *SIZE_FRAME_X* and *SIZE_FRAME_Y* and *DATA_SCALER*
   #. finds the original YUV (noted as YUVori) according to *CSTR_VECT* and *CSTR_DIR_VECT* (vector directory)
   #. scales YUVori (from *SIZE_FRAME_X* × *SIZE_FRAME_Y* to *SIZE_FRAME_SCALED_X* × *SIZE_FRAME_SCALED_Y*)
   #. notes down the md5sum of scaled YUV (noted as YUVtmp)
   #. scales YUVtmp (from *SIZE_FRAME_SCALED_X* × *SIZE_FRAME_SCALED_Y* to *SIZE_FRAME_X* × *SIZE_FRAME_Y*)
   #. notes down the md5sum of scaled YUV (noted as YUVfnl)
   #. calculates and notes down PSNR between YUVtmp and YUVfnl

   Key parameters are listed below

   .. table::
      :align: left
      :widths: auto

      ==================== ==============
       Parameter            Descriptions
      ==================== ==============
       CSTR_DIR_VECT        vector directory
       CSTR_INFO_VECT_ALL   vector list
       FLAG_FFMPEG          | enable flags for using ffmpeg
                            | **by setting it, sessionTest calls ffmpeg instead of xkmsc**
       ENUM_METHOD_FFMPEG   enumerator for the scaling method used by ffmpeg
       DATA_SCALER          scaler data
      ==================== ==============


Dependency
----------

   sessionTest requires

   .. table::
      :align: left
      :widths: auto

      ============================ ==============
       Platform or Tool             Descriptions
      ============================ ==============
       linux                        my version is Ubuntu 20.04.3 LTS
       ffmpeg                       my version is ffmpeg version 4.2.4-1ubuntu0.1
       md5sum                       my version is md5sum GNU coreutils 8.30
       python3 with sys and numpy   my version is Python 3.8.10 (default, Sep 28 2021, 16:10:42)
       octave                       my version is GNU Octave, version 5.2.0
      ============================ ==============


Usage
-----

simple help
```````````

   #. execute

      ::

         ./xkmsc --help

      You will see

      .. image:: usage_simpleHelp.png
         :width: 1000

      Detailed configuration interface is also listed here.

      .. table::
         :align: left
         :widths: auto

         .. include:: ../../../../source/xkmsc/top/configuration/msc_cfg.rst

simple run
``````````

   #. change the contents of xkmsc.cfg according to your requests

   #. execute

      ::

         ./xkmsc -c xkmsc.cfg

      You will see something like

      .. image:: usage_singleRun.png
         :width: 350

      The scaled YUV file is named as *scaled.yuv* by default.

   #. Sure, you can also pass configurations through command line, for example,

      ::

         ./xkmsc -c xkmsc.cfg --numFrame 5 --sizFrameScaledX 1000 --sizFrameScaledY 500

regression run
``````````````

   #. change the contents of xkmsc.cfg according to your requests

   #. change the parameters in runXkmsc.sh according to your requests

   #. execute

      ::

         ./runXkmsc.sh

      You will see something like

      .. image:: usage_regressionRun.png
         :width: 800

   #. Sure, you can also pass configurations through command line, for example,

      ::

         ./runXkmsc --enmProc 1


Preliminary Results
-------------------

   .. table:: scaled from 1 to 1.317, then rescaled to 1 (software)
      :align: left
      :widths: auto

      ================ ============ ============= ============== ========================== ========================== ==========================
       Sequence Name    Frame Numer  Frame Width   Frame Height   xkmsc (default)            ffpmeg (bicubic)           fmpeg (bilinear)
      ================ ============ ============= ============== ========================== ========================== ==========================
       BasketballPass   8            416           240            42.474 / 51.634 / 50.498   35.709 / 45.464 / 43.665   41.546 / 51.044 / 50.102
       BQSquare         8            416           240            35.644 / 52.808 / 53.620   27.993 / 47.257 / 47.770   34.061 / 52.099 / 52.976
       BlowingBubbles   8            416           240            40.227 / 49.259 / 51.748   33.436 / 42.713 / 45.363   39.492 / 49.056 / 51.442
       RaceHorses       8            416           240            43.213 / 50.925 / 50.712   35.026 / 43.425 / 42.607   43.604 / 51.257 / 51.193
       BasketballDrill  8            832           480            44.152 / 50.426 / 50.941   36.687 / 43.730 / 43.987   43.653 / 49.660 / 50.356
       BQMall           8            832           480            40.473 / 52.141 / 54.231   33.382 / 46.131 / 48.057   39.423 / 51.294 / 53.396
       PartyScene       8            832           480            36.475 / 47.995 / 48.761   29.590 / 41.578 / 42.268   35.519 / 47.316 / 48.150
       RaceHorsesC      8            832           480            42.998 / 52.140 / 53.520   35.475 / 44.917 / 45.787   42.486 / 52.543 / 54.083
       FourPeople       8            1280          720            48.492 / 58.778 / 61.039   40.016 / 52.402 / 54.449   48.539 / 57.324 / 59.035
       Johnny           8            1280          720            50.666 / 60.705 / 62.186   42.770 / 53.670 / 55.196   50.278 / 58.603 / 59.865
       KristenAndSara   8            1280          720            48.951 / 59.485 / 61.027   39.918 / 52.691 / 54.269   48.209 / 57.814 / 58.981
       Kimono           8            1920          1080           52.215 / 56.508 / 59.356   47.030 / 51.056 / 53.058   51.397 / 56.050 / 59.175
       ParkScene        8            1920          1080           47.903 / 53.402 / 54.471   40.559 / 46.985 / 48.211   47.636 / 53.312 / 54.200
       Cactus           8            1920          1080           45.738 / 50.101 / 53.034   38.340 / 44.365 / 46.838   45.346 / 49.241 / 52.076
       BasketballDrive  8            1920          1080           46.677 / 54.508 / 55.728   39.997 / 49.003 / 49.330   45.476 / 52.989 / 54.282
       BQTerrace        8            1920          1080           41.570 / 51.231 / 53.692   33.534 / 45.466 / 48.010   40.708 / 50.377 / 52.610
       Traffic          8            2560          1600           50.349 / 50.933 / 54.271   41.954 / 44.927 / 47.952   50.396 / 50.001 / 53.594
       PeopleOnStreet   8            2560          1600           50.043 / 57.190 / 56.866   41.083 / 51.074 / 50.944   50.276 / 56.600 / 55.977
      ================ ============ ============= ============== ========================== ========================== ==========================

   .. table:: scaled from 1 to 1.317, then rescaled to 1 (hardware)
      :align: left
      :widths: auto

      ================ ============ ============= ============== ==========================
       Sequence Name    Frame Numer  Frame Width   Frame Height   xkmsc (hardware)
      ================ ============ ============= ============== ==========================
       BasketballPass   8            416           240            42.595 	51.703 	50.611
       BQSquare         8            416           240            35.770 	52.874 	53.705
       BlowingBubbles   8            416           240            40.356 	49.376 	51.861
       RaceHorses       8            416           240            43.422 	51.084 	50.894
       BasketballDrill  8            832           480            44.318 	50.547 	51.084
       BQMall           8            832           480            40.616 	52.242 	54.334
       PartyScene       8            832           480            36.621 	48.122 	48.892
       RaceHorsesC      8            832           480            43.172 	52.297 	53.700
       FourPeople       8            1280          720            48.670 	58.662 	60.871
       Johnny           8            1280          720            50.789 	60.544 	61.979
       KristenAndSara   8            1280          720            49.093 	59.389 	60.876
       Kimono           8            1920          1080           52.253 	56.553 	59.420
       ParkScene        8            1920          1080           48.021 	53.494 	54.556
       Cactus           8            1920          1080           45.858 	50.172 	53.099
       BasketballDrive  8            1920          1080           46.769 	54.550 	55.800
       BQTerrace        8            1920          1080           41.698 	51.304 	53.751
       Traffic          8            2560          1600           50.379 	50.990 	54.289
       PeopleOnStreet   8            2560          1600           50.006 	57.131 	56.806
      ================ ============ ============= ============== ==========================


Other Function
--------------

default
```````

*  default value of related settings

   .. table::
      :align: left
      :widths: auto

      ================== =======
       configuration      value
      ================== =======
       strFileIn          /mnt/e/DOWNLOAD/SEQUENCE/HM/BasketballPass/BasketballPass.yuv
       strFileOut         out.yuv
       numFrame           10
       sizFrameX          416
       sizFrameY          240
       sizFrameZ          3
       enmFormatIn        0
       enmProc            0
       enmInfo            2
       enmLoad            0
       enmDump            0
       datSeed            0
       sizUnitX           16
       sizUnitY           16

       sclFlgProc         1
       sclNumTap          4
       sclSizFrameX       548
       sclSizFrameY       316
       sclEnmMode         0
       sclEnmLoad         0
       sclEnmDump         0
       sclDatThreshold2   0.5
       sclDatThreshold4   128
      ================== =======

*  after executing

   ::

      ./run.sh

   you will get default yuv (1ade311a00d7eb83bd683a80e9678dee)

   .. image:: otherFunction_default.png
      :width: 800

filtering
`````````

*  default value of related settings

   .. table::
      :align: left
      :widths: auto

      =============== =======
       configuration   value
      =============== =======
       fltFlgProc      0
       fltEnmLoad      0
       fltEnmDump      0
       fltDatCoe_0_0   0
       fltDatCoe_0_1   0
       fltDatCoe_0_2   0
       fltDatCoe_1_0   0
       fltDatCoe_1_1   1
       fltDatCoe_1_2   0
       fltDatCoe_2_0   0
       fltDatCoe_2_1   0
       fltDatCoe_2_2   0
      =============== =======

*  after executing

   ::

      ./run.sh -R "--fltFlgProc 1 --fltDatCoe_0_1 -1 --fltDatCoe_1_0 -1 --fltDatCoe_1_1 5 --fltDatCoe_1_2 -1  --fltDatCoe_2_1 -1"

   you will get filtered yuv (2d53b9b6f4592e8b59eb3cae9f689079)

   .. image:: otherFunction_filtering0.png
      :width: 800


*  after executing

   ::

      ./run.sh -R "--fltFlgProc 1 --fltDatCoe_0_0 0.1 --fltDatCoe_0_1 0.1 --fltDatCoe_0_2 0.1 --fltDatCoe_1_0 0.1 --fltDatCoe_1_1 0.2 --fltDatCoe_1_2 0.1 --fltDatCoe_2_0 0.1 --fltDatCoe_2_1 0.1 --fltDatCoe_2_2 0.1"

   you will get filtered yuv (88ef56131f551f47dfa6c4aaf4b8c52a)

   .. image:: otherFunction_filtering1.png
      :width: 800

on-screen-display
`````````````````

*  default value of related settings

   .. table::
      :align: left
      :widths: auto

      ================ =======
       configuration    value
      ================ =======
       osdFlgProc       0
       osdStrFile0      /mnt/e/DOWNLOAD/SEQUENCE/HM/BasketballPass/BasketballPass.yuv
       osdStrFile1      /mnt/e/DOWNLOAD/SEQUENCE/HM_AYUV1555/BasketballPass/BasketballPass.yuv
       osdStrFile2      /mnt/e/DOWNLOAD/SEQUENCE/HM_INDX2/BasketballPass/BasketballPass.yuv
       osdStrFile3      /mnt/e/DOWNLOAD/SEQUENCE/HM_INDX4/BasketballPass/BasketballPass.yuv
       osdStrFile4      /mnt/e/DOWNLOAD/SEQUENCE/HM_ARGB1555/BasketballPass/BasketballPass.yuv
       osdStrFile5      osd5.yuv
       osdStrFile6      osd6.yuv
       osdStrFile7      osd7.yuv
       osdFlg_0         0
       osdFlg_1         0
       osdFlg_2         0
       osdFlg_3         0
       osdFlg_4         0
       osdFlg_5         0
       osdFlg_6         0
       osdFlg_7         0
       osdSizFrameX_0   416
       osdSizFrameX_1   416
       osdSizFrameX_2   416
       osdSizFrameX_3   416
       osdSizFrameX_4   416
       osdSizFrameX_5   16
       osdSizFrameX_6   16
       osdSizFrameX_7   16
       osdSizFrameY_0   240
       osdSizFrameY_1   240
       osdSizFrameY_2   240
       osdSizFrameY_3   240
       osdSizFrameY_4   240
       osdSizFrameY_5   16
       osdSizFrameY_6   16
       osdSizFrameY_7   16
       osdPosFrameX_0   16
       osdPosFrameX_1   32
       osdPosFrameX_2   64
       osdPosFrameX_3   128
       osdPosFrameX_4   256
       osdPosFrameX_5   0
       osdPosFrameX_6   0
       osdPosFrameX_7   0
       osdPosFrameY_0   0
       osdPosFrameY_1   16
       osdPosFrameY_2   32
       osdPosFrameY_3   64
       osdPosFrameY_4   128
       osdPosFrameY_5   0
       osdPosFrameY_6   0
       osdPosFrameY_7   0
       osdEnmLoad       0
       osdEnmMode_0     0
       osdEnmMode_1     1
       osdEnmMode_2     2
       osdEnmMode_3     3
       osdEnmMode_4     4
       osdEnmMode_5     0
       osdEnmMode_6     0
       osdEnmMode_7     0
       osdEnmDump       0
       osdDatScl_0_0    1
       osdDatScl_0_1    1
       osdDatScl_1_0    1
       osdDatScl_1_1    1
       osdDatScl_2_0    1
       osdDatScl_2_1    1
       osdDatScl_3_0    1
       osdDatScl_3_1    1
       osdDatScl_4_0    1
       osdDatScl_4_1    1
       osdDatScl_5_0    1
       osdDatScl_5_1    1
       osdDatScl_6_0    1
       osdDatScl_6_1    1
       osdDatScl_7_0    1
       osdDatScl_7_1    1
       osdDatLut0_0_0   192
       osdDatLut0_0_1   81
       osdDatLut0_0_2   90
       osdDatLut0_0_3   240
       osdDatLut0_1_0   128
       osdDatLut0_1_1   145
       osdDatLut0_1_2   54
       osdDatLut0_1_3   34
       osdDatLut0_2_0   64
       osdDatLut0_2_1   41
       osdDatLut0_2_2   240
       osdDatLut0_2_3   110
       osdDatLut0_3_0   110
       osdDatLut0_3_1   53
       osdDatLut0_3_2   22
       osdDatLut0_3_3   127
       osdDatLut1_0_0   192
       osdDatLut1_0_1   81
       osdDatLut1_0_2   90
       osdDatLut1_0_3   240
       osdDatLut1_1_0   128
       osdDatLut1_1_1   145
       osdDatLut1_1_2   54
       osdDatLut1_1_3   34
       osdDatLut1_2_0   64
       osdDatLut1_2_1   41
       osdDatLut1_2_2   240
       osdDatLut1_2_3   110
       osdDatLut1_3_0   110
       osdDatLut1_3_1   53
       osdDatLut1_3_2   22
       osdDatLut1_3_3   127
       osdDatLut2_0_0   192
       osdDatLut2_0_1   81
       osdDatLut2_0_2   90
       osdDatLut2_0_3   240
       osdDatLut2_1_0   128
       osdDatLut2_1_1   145
       osdDatLut2_1_2   54
       osdDatLut2_1_3   34
       osdDatLut2_2_0   64
       osdDatLut2_2_1   41
       osdDatLut2_2_2   240
       osdDatLut2_2_3   110
       osdDatLut2_3_0   110
       osdDatLut2_3_1   53
       osdDatLut2_3_2   22
       osdDatLut2_3_3   127
       osdDatLut3_0_0   192
       osdDatLut3_0_1   81
       osdDatLut3_0_2   90
       osdDatLut3_0_3   240
       osdDatLut3_1_0   128
       osdDatLut3_1_1   145
       osdDatLut3_1_2   54
       osdDatLut3_1_3   34
       osdDatLut3_2_0   64
       osdDatLut3_2_1   41
       osdDatLut3_2_2   240
       osdDatLut3_2_3   110
       osdDatLut3_3_0   110
       osdDatLut3_3_1   53
       osdDatLut3_3_2   22
       osdDatLut3_3_3   127
       osdDatLut4_0_0   192
       osdDatLut4_0_1   81
       osdDatLut4_0_2   90
       osdDatLut4_0_3   240
       osdDatLut4_1_0   128
       osdDatLut4_1_1   145
       osdDatLut4_1_2   54
       osdDatLut4_1_3   34
       osdDatLut4_2_0   64
       osdDatLut4_2_1   41
       osdDatLut4_2_2   240
       osdDatLut4_2_3   110
       osdDatLut4_3_0   110
       osdDatLut4_3_1   53
       osdDatLut4_3_2   22
       osdDatLut4_3_3   127
       osdDatLut5_0_0   0
       osdDatLut5_0_1   0
       osdDatLut5_0_2   0
       osdDatLut5_0_3   0
       osdDatLut5_1_0   0
       osdDatLut5_1_1   0
       osdDatLut5_1_2   0
       osdDatLut5_1_3   0
       osdDatLut5_2_0   0
       osdDatLut5_2_1   0
       osdDatLut5_2_2   0
       osdDatLut5_2_3   0
       osdDatLut5_3_0   0
       osdDatLut5_3_1   0
       osdDatLut5_3_2   0
       osdDatLut5_3_3   0
       osdDatLut6_0_0   0
       osdDatLut6_0_1   0
       osdDatLut6_0_2   0
       osdDatLut6_0_3   0
       osdDatLut6_1_0   0
       osdDatLut6_1_1   0
       osdDatLut6_1_2   0
       osdDatLut6_1_3   0
       osdDatLut6_2_0   0
       osdDatLut6_2_1   0
       osdDatLut6_2_2   0
       osdDatLut6_2_3   0
       osdDatLut6_3_0   0
       osdDatLut6_3_1   0
       osdDatLut6_3_2   0
       osdDatLut6_3_3   0
       osdDatLut7_0_0   0
       osdDatLut7_0_1   0
       osdDatLut7_0_2   0
       osdDatLut7_0_3   0
       osdDatLut7_1_0   0
       osdDatLut7_1_1   0
       osdDatLut7_1_2   0
       osdDatLut7_1_3   0
       osdDatLut7_2_0   0
       osdDatLut7_2_1   0
       osdDatLut7_2_2   0
       osdDatLut7_2_3   0
       osdDatLut7_3_0   0
       osdDatLut7_3_1   0
       osdDatLut7_3_2   0
       osdDatLut7_3_3   0
      ================ =======

*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_0 1"

   you will get "osded" yuv (ca5ce09481508cff7497d1e30895148b)

   .. image:: otherFunction_osd0.png
      :width: 800


*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_1 1"

   you will get "osded" yuv (2b2831a83c8f7c055789ef8e3c9319a1)

   .. image:: otherFunction_osd1.png
      :width: 800

*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_2 1"

   you will get "osded" yuv (f0bec17f41af347b432c5ed3a512b25f)

   .. image:: otherFunction_osd2.png
      :width: 800

*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_3 1"

   you will get "osded" yuv (06cf8e2cc973ff535f2652da5ff17cbe)

   .. image:: otherFunction_osd3.png
      :width: 800

*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_4 1"

   you will get "osded" yuv (a3e1ebccc616f371665378871da64107)

   .. image:: otherFunction_osd4.png
      :width: 800

*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_0 1 --osdDatScl_0_0 2 --osdDatScl_0_1 3"

   you will get "osded" yuv (04ed64b5998d83098cb05b5883318114)

   .. image:: otherFunction_osd5.png
      :width: 800

*  after executing

   ::

      ./run.sh -R "--osdFlgProc 1 --osdFlg_0 1 --osdFlg_1 1 --osdFlg_2 1 --osdFlg_3 1 --osdFlg_4 1"

   you will get "osded" yuv (8f56d1c8df99514eeceb44ebf8294eaa)

   .. image:: otherFunction_osd6.png
      :width: 800

*  those "osdStrFile" can be reproduced with script/get/get*FromYuv420p
