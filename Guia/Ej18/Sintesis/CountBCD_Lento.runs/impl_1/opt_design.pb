
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-349h px� 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px� 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px� 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:04 ; elapsed = 00:00:05 . Memory (MB): peak = 1842.371 ; gain = 64.031 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px� 
i

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px� 
;
&Phase 1 Retarget | Checksum: eba65982
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.11 ; elapsed = 00:00:00.18 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
02default:default2
02default:defaultZ31-389h px� 
u

Phase %s%s
101*constraints2
2 2default:default2(
Constant propagation2default:defaultZ18-101h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
G
2Phase 2 Constant propagation | Checksum: eba65982
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.12 ; elapsed = 00:00:00.18 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
02default:default2
02default:defaultZ31-389h px� 
f

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101h px� 
9
$Phase 3 Sweep | Checksum: 1748aecd6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.13 ; elapsed = 00:00:00.19 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
02default:default2
02default:defaultZ31-389h px� 
r

Phase %s%s
101*constraints2
4 2default:default2%
BUFG optimization2default:defaultZ18-101h px� 
E
0Phase 4 BUFG optimization | Checksum: 1748aecd6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.13 ; elapsed = 00:00:00.20 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2%
BUFG optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px� 
O
:Phase 5 Shift Register Optimization | Checksum: 1748aecd6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.13 ; elapsed = 00:00:00.20 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
x

Phase %s%s
101*constraints2
6 2default:default2+
Post Processing Netlist2default:defaultZ18-101h px� 
K
6Phase 6 Post Processing Netlist | Checksum: 1748aecd6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.14 ; elapsed = 00:00:00.20 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2+
Post Processing Netlist2default:default2
02default:default2
02default:defaultZ31-389h px� 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
J
5Ending Logic Optimization Task | Checksum: 1748aecd6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.14 ; elapsed = 00:00:00.20 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px� 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px� 
J
5Ending Power Optimization Task | Checksum: 14bd50ee4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.05 ; elapsed = 00:00:00.06 . Memory (MB): peak = 1913.371 ; gain = 0.000 ; free physical = 1573 ; free virtual = 78682default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
272default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px� 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
opt_design: 2default:default2
00:00:042default:default2
00:00:052default:default2
1913.3712default:default2
135.0312default:default2
15732default:default2
78682default:defaultZ17-722h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.102default:default2
00:00:00.032default:default2
1945.3872default:default2
0.0002default:default2
15732default:default2
78692default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2
k/home/raxt/CESE_Workspace/CLP_workspace/Guia/Ej18/Sintesis/CountBCD_Lento.runs/impl_1/countBCDLento_opt.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2�
yExecuting : report_drc -file countBCDLento_drc_opted.rpt -pb countBCDLento_drc_opted.pb -rpx countBCDLento_drc_opted.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
lreport_drc -file countBCDLento_drc_opted.rpt -pb countBCDLento_drc_opted.pb -rpx countBCDLento_drc_opted.rpx2default:defaultZ4-113h px� 
>
Refreshing IP repositories
234*coregenZ19-234h px� 
G
"No user IP repositories specified
1154*coregenZ19-1704h px� 
~
"Loaded Vivado IP repository '%s'.
1332*coregen25
!/opt/Xilinx/Vivado/2018.1/data/ip2default:defaultZ19-2313h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
q/home/raxt/CESE_Workspace/CLP_workspace/Guia/Ej18/Sintesis/CountBCD_Lento.runs/impl_1/countBCDLento_drc_opted.rptq/home/raxt/CESE_Workspace/CLP_workspace/Guia/Ej18/Sintesis/CountBCD_Lento.runs/impl_1/countBCDLento_drc_opted.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
report_drc: 2default:default2
00:00:092default:default2
00:00:102default:default2
1977.4022default:default2
32.0162default:default2
15452default:default2
78412default:defaultZ17-722h px� 


End Record