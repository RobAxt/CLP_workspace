#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/opt/Xilinx/SDK/2018.1/bin:/opt/Xilinx/Vivado/2018.1/ids_lite/ISE/bin/lin64:/opt/Xilinx/Vivado/2018.1/bin
else
  PATH=/opt/Xilinx/SDK/2018.1/bin:/opt/Xilinx/Vivado/2018.1/ids_lite/ISE/bin/lin64:/opt/Xilinx/Vivado/2018.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2018.1/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2018.1/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/raxt/CESE_Workspace/CLP_workspace/Guia/Ej18/Sintesis/CountBCD_Lento.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log countBCDLento.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source countBCDLento.tcl -notrace


