.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : 环境搭建
   ..
.. -----------------------------------------------------------------------------

第00练 - 硬件环境
--------------------------------------------------------------------------------

1. 按照 *Before Everything* 准备相关环境，搜索相关资料并回答：

   a. 新安装工具的功能是什么？

#. 请按照 *About Reference Model* 使用参考模型环境，搜索相关资料并回答：

   a. 测试用例是如何生成的？
   #. 如何添加新的测试用例？

#. 请按照 *About Simulation* 使用仿真环境（仅需尝试WSL环境下支持的那部分命令），搜索相关资料并回答：

   a. 编译和仿真是如何进行的？
   #. 回归是如何进行的？
   #. testbench是如何组织的？

#. |  请仿照pj_example_rtl/source/xkcalc/kernel/adder/calc_add_knl.v设计pj_example_rtl/source/xkcalc/kernel/substrator/calc_sub_knl.v；
   |  仿照pj_example_rtl/simulation/rtl/rtl_calc_add_knl构建pj_example_rtl/simulation/rtl/rtl_calc_sub_knl；
   |  并进行用例生成、编译、仿真和回归。

#. |  请仿照pj_example_c_model/source/xkcalc/unit/adder创建pj_example_c_model/source/xkcalc/unit/xor；
   |  集成到xkcalc中，
   |  并设计pj_example_rtl/source/xkcalc/kernel/xor/calc_xor_knl.v；
   |  构建pj_example_rtl/simulation/rtl/rtl_calc_xor_knl；
   |  再进行用例生成、编译、仿真和回归。


.. toctree::
   :maxdepth: 2

   ../../pj_example_rtl/document/description/rst_example/source/C00_beforeEverything/index
   ../../pj_example_rtl/document/description/rst_example/source/C01_introduction/index
   ../../pj_example_rtl/document/description/rst_example/source/C02_aboutDocument/index
   ../../pj_example_rtl/document/description/rst_example/source/C03_aboutReferenceModel/index
   ../../pj_example_rtl/document/description/rst_example/source/C04_aboutSource/index
   ../../pj_example_rtl/document/description/rst_example/source/C05_aboutInclude/index
   ../../pj_example_rtl/document/description/rst_example/source/C06_aboutLibrary/index
   ../../pj_example_rtl/document/description/rst_example/source/C07_aboutScript/index
   ../../pj_example_rtl/document/description/rst_example/source/C08_aboutSimulation/index
   ../../pj_example_rtl/document/description/rst_example/source/C09_aboutCheck/index
   ../../pj_example_rtl/document/description/rst_example/source/C10_aboutSynthesis/index
   ../../pj_example_rtl/document/description/rst_example/source/C11_codingStyle/index
   ../../pj_example_rtl/document/description/rst_example/source/C12_template/index
   ../../pj_example_rtl/document/description/rst_example/source/C13_versionControl/index
   ../../pj_example_rtl/document/description/rst_example/source/C14_checkList/index
   ../../pj_example_rtl/document/description/rst_example/source/C15_what's/index
