@echo off
set xv_path=C:\\Users\\MrW\\Documents\\vivado2015.2\\Vivado\\2015.2\\bin
call %xv_path%/xsim CPU_sim_behav -key {Behavioral:sim_1:Functional:CPU_sim} -tclbatch CPU_sim.tcl -view E:/VivadoProjects/MultiCycleCPU/CPU_sim_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
