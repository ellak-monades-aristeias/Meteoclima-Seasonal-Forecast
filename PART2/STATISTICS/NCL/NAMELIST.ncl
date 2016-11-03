if stmm.eq.6 then
WHEN="JUNE 2015     "
else if stmm.eq.7 then
WHEN="JULY 2015     "
else if	stmm.eq.8 then
WHEN="AUGUST 2015     "
end if
end if
end if
AREA="GLOBAL70"
VNAME="MSLP" ;; use the respective name
north=70
south=-70
west=-180
east=180

CASE="GWRF"
OUT="GWRF"

if RUN.eq.2 then
version="SEASONAL_"+VNAME+"_"+stmm+"_"+stnn+"_-180_180_-70_70_Deg_0.5"
resol=1.4
end if

testrun=version
