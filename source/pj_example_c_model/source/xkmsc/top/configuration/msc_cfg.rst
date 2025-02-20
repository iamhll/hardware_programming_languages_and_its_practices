=================== ===================== ====== =========== ======== =============== =============== =========== =========================================================================================================================
 domain              name                  size   short key   type     minimum value   maximum value   precision   description
=================== ===================== ====== =========== ======== =============== =============== =========== =========================================================================================================================
 virtual             strFileCfg            /      c           /        /               /               /           location of the configuration file
 virtual             help                  /      /           /        /               /               /           to print help information
 virtual             show                  /      /           /        /               /               /           to show configuration value
 virtual             dryRun                /      /           /        /               /               /           to check input without running
 changeable          idxFrame              1      /           int      /               /               /           index of the current frame
 changeable          idxUnitX              1      /           int      /               /               /           index of the current unit in 1st dimension
 changeable          idxUnitY              1      /           int      /               /               /           index of the current unit in 2nd dimension
 top                 strFileIn             1      i           string   /               /               /           full location of the input file
 top                 strFileOut            1      o           string   /               /               /           full location of the output file
 top                 strPrefixDump         1      /           string   /               /               /           dump prefix for debug data
 top                 strPrefixLoad         1      /           string   /               /               /           load prefix for debug data
 top                 numFrame              1      /           int      /               /               /           number of the frames to be processed
 top                 sizFrameX             1      /           int      1               4096            /           size of frames in 1st dimension
 top                 sizFrameY             1      /           int      1               4096            /           size of frames in 2nd dimension
 top                 sizFrameZ             1      /           int      1               3               /           size of frames in 3rd dimension
 top                 enmFormatIn           1      /           int      0               1               /           enumerator for input format (<value> 0: yuv420p 1: nv12)
 top                 enmProc               1      /           int      0               1               /           enumerator for processing behavior (<value> 0: software 1: hardware)
 top                 enmInfo               1      /           int      0               4               /           enumerator for information level (<value> 0: none 1: system 2: top 3: module 4: common)
 top                 enmLoad               1      /           int      0               2               /           enumerator for load source (<value> 0: pipeline 1: file 2: random)
 top                 enmDump               1      /           int      0               2               /           enumerator for dump level (<value> 0: none 1: inout 2: intermediate)
 top                 datSeed               1      r           int      /               /               /           value of random seed
 top                 sizUnitX              1      /           int      1               64              /           size of units' 1st dimension
 top                 sizUnitY              1      /           int      1               64              /           size of units' 2nd dimension
 scaler              sclFlgProc            1      /           bool     /               /               /           enable flag for processing
 scaler              sclNumTap             1      /           int      2               4               /           number of filter tap (<value> 0: 2 1: 4)
 scaler              sclSizFrameX          1      /           int      1               8192            /           size of frames in 1st dimension
 scaler              sclSizFrameY          1      /           int      1               8192            /           size of frames in 2nd dimension
 scaler              sclEnmMode            1      /           int      0               1               /           enumerator for mode (<value> 0: bilinear 1: bicubic)
 scaler              sclEnmLoad            1      /           int      0               2               /           enumerator for load source (<value> 0: pipeline 1: file 2: random)
 scaler              sclEnmDump            1      /           int      0               2               /           enumerator for dump level (<value> 0: none 1: inout 2: intermediate)
 scaler              sclDatThreshold2      1      /           double   0               1               8           threshold for 2-tap filter
 scaler              sclDatThreshold4      1      /           int      0               255             /           threshold for 4-tap filter
 filter              fltFlgProc            1      /           bool     /               /               /           enable flag for processing
 filter              fltEnmLoad            1      /           int      0               2               /           enumerator for load source (<value> 0: pipeline 1: file 2: random)
 filter              fltEnmDump            1      /           int      0               2               /           enumerator for dump level (<value> 0: none 1: inout 2: intermediate)
 filter              fltDatCoe             3x3    /           double   -16             15.9375         4           coefficient data (<index> Y(0/1/2)~X(0/1/2): value of the coefficient positioned at Y(-1/0/1)~X(-1/0/1))
 on-screen-display   osdFlgProc            1      /           bool     /               /               /           enable flag for processing
 on-screen-display   osdStrFile0           1      i           string   /               /               /           location of the 0th OSD file
 on-screen-display   osdStrFile1           1      i           string   /               /               /           location of the 1st OSD file
 on-screen-display   osdStrFile2           1      i           string   /               /               /           location of the 2nd OSD file
 on-screen-display   osdStrFile3           1      i           string   /               /               /           location of the 3rd OSD file
 on-screen-display   osdStrFile4           1      i           string   /               /               /           location of the 4th OSD file
 on-screen-display   osdStrFile5           1      i           string   /               /               /           location of the 5th OSD file
 on-screen-display   osdStrFile6           1      i           string   /               /               /           location of the 6th OSD file
 on-screen-display   osdStrFile7           1      i           string   /               /               /           location of the 7th OSD file
 on-screen-display   osdFlg                8      /           bool     /               /               /           enable flags for OSD (<index> N: the Nth OSD)
 on-screen-display   osdSizFrameX          8      /           int      1               4096            /           size of OSD frames in 1st dimension (<index> N: the Nth OSD)
 on-screen-display   osdSizFrameY          8      /           int      1               4096            /           size of OSD frames in 2nd dimension (<index> N: the Nth OSD)
 on-screen-display   osdPosFrameX          8      /           int      0               4095            /           position of OSD frames in 1st dimension (<index> N: the Nth OSD)
 on-screen-display   osdPosFrameY          8      /           int      0               4095            /           position of OSD frames in 2nd dimension (<index> N: the Nth OSD)
 on-screen-display   osdEnmLoad            1      /           int      0               2               /           enumerator for load source (<value> 0: pipeline 1: file 2: random)
 on-screen-display   osdEnmMode            8      /           int      0               4               /           enumerator for work mode (<index> N: the Nth OSD) (<value> 0: YUV420; 1: AYUV1555; 2: index 2; 3: index 4; 4: ARGB1555)
 on-screen-display   osdEnmDump            1      /           int      0               2               /           enumerator for dump level (<value> 0: none 1: inout 2: intermediate)
 on-screen-display   osdDatScl             8x2    /           int      1               4               /           scaler data (<index> N-A(0/1): axis A(X/Y) of the Nth OSD)
 on-screen-display   osdDatLut0            4x4    /           int      /               /               /           data of 0th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut1            4x4    /           int      /               /               /           data of the 1st OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut2            4x4    /           int      /               /               /           data of the 2nd OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut3            4x4    /           int      /               /               /           data of the 3rd OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut4            4x4    /           int      /               /               /           data of the 4th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut5            4x4    /           int      /               /               /           data of the 5th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut6            4x4    /           int      /               /               /           data of the 6th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 on-screen-display   osdDatLut7            4x4    /           int      /               /               /           data of the 7th OSD's LUT (<index> N~C(0/1/2/3): value of channal C(alpha/Y/U/V) of the Nth data)
 example             exampleDatInt         1      /           int      0               1               /           an example for int (scalar)
 example             exampleDatDouble      1      /           double   0               0.875           8           an example for double (scalar)
 example             exampleDatVector      2      /           int      0               1               /           an example for (int) vector
 example             exampleDatArray       2x3    /           int      0               1               /           an example for (int) array
 derived             numUnitX              1      /           int      /               /               /           number of units in 1st dimension
 derived             numUnitY              1      /           int      /               /               /           number of units in 2nd dimension
 derived             datScalerX            1      /           double   /               /               16          scaler data in 1st dimension
 derived             datScalerY            1      /           double   /               /               16          scaler data in 2nd dimension
 derived             sclDatThreshold2Inv   1      /           double   /               /               8           threshold for 2-tap filter divided by 1
=================== ===================== ====== =========== ======== =============== =============== =========== =========================================================================================================================
