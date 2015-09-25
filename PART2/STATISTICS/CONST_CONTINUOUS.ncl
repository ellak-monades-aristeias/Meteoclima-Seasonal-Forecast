PARAMETER=new((/4/),string)

if STATYPE.eq.1 then
nmodels=2
npar=4

obot1=1.0
mbot1=1.0
otop1=32.
mtop1=32.
obot2=0.0
mbot2=0.0
otop2=360.
mtop2=360.
obot3=0.2
mbot3=0.2
otop3=12.
mtop3=12.
obot4=0.0
mbot4=0.0
otop4=360.
mtop4=360.

PARAMETER(0)="WIND"
PARAMETER(1)="WINDDIR"
PARAMETER(2)="WAVE"
PARAMETER(3)="WAVEDIR"

else if STATYPE.eq.2 then

nmodels=1
npar=1

;obot1=240
;mbot1=240
;otop1=320
;mtop1=320

;obot1=0
;mbot1=0
;otop1=50
;mtop1=50

;obot1=900
;mbot1=900
;otop1=1060
;mtop1=1060

;prec
obot1=0
mbot1=0
otop1=2000
mtop1=2000

obot2=0.2
mbot2=0.2
otop2=12.
mtop2=12.
obot3=0.2 
mbot3=0.2
otop3=12.
mtop3=12.
obot4=0.2
mbot4=0.2
otop4=12.
mtop4=12.

PARAMETER(0)="WIND"
PARAMETER(1)="WAVE"

else

nmodels=2
npar=3

obot1=1.0
mbot1=1.0
otop1=40 ;32.
mtop1=40 ;32.
obot2=980 ;989.
mbot2=980 ;989.
otop2=1050 ;1043.
mtop2=1050 ;1043.
obot3=265 ;262.
mbot3=265; 262.
otop3=310; 302.
mtop3=310; 302.

PARAMETER(0)="WIND"
PARAMETER(1)="MSLP"
PARAMETER(2)="TEMP"
end if
end if

custom=0  ;; MIN - MAX at plots
dif=12.0 ;5.0 ;0.4  ;; if custom=0
plotstations=0 ;plots for stations
signif_test=0
timeplots=0
