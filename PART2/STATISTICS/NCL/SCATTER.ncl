if nm.eq.0 then

allobs@_FillValue = -999.
allmodel@_FillValue = -999.

xline=fspan(-10000,10000,20001)

PNG=1

outdir="./"
outfile =outdir+testrun

print(outfile)
if (PNG .eq. 1) then
  wks_type = "png"
  wks_type@wkWidth = 860
  wks_type@wkHeight = 860
  wks = gsn_open_wks(wks_type,outfile)
end if

 res = True
  res@gsnDraw         = False	; don't draw the plots, gsn_panel will draw them
  res@gsnFrame        = False	; don't advance the frame, gsn_panel will

  res@vpXF                = 0.13
  res@vpYF                = 0.87
  res@vpWidthF            = 0.55
  res@vpHeightF           = 0.57

if custom.eq.1 then

 res@trXMinF         = obot	; set minimum X-axis value
  res@trXMaxF         = otop	; set maximum X-axis value
 res@trYMinF         = obot	; set minimum X-axis value
  res@trYMaxF         = otop	; set maximum X-axis value
	
else

ymax=decimalPlaces(max(allmodel(:,par,:)),0,False)
ymin=decimalPlaces(min(allmodel(:,par,:)),0,False)
xmax=decimalPlaces(max(allobs(:,par)),0,False)
xmin=decimalPlaces(min(allobs(:,par)),0,False)

if (((ymin-dif).lt.0.or.(xmin-dif).lt.0).and.PARAMETER(par).ne."TEMP") then
if ymax.gt.xmax then

res@trXMaxF = ymax+dif
res@trYMaxF = ymax+dif
else
res@trXMaxF = xmax+dif
res@trYMaxF = xmax+dif
end if

if ymin.gt.xmin then

res@trXMinF = 0
res@trYMinF = 0
else
res@trXMinF = 0
res@trYMinF = 0
end if

else

if ymax.gt.xmax then

res@trXMaxF = ymax+dif
res@trYMaxF = ymax+dif
else
res@trXMaxF = xmax+dif
res@trYMaxF = xmax+dif
end if

if ymin.gt.xmin then

res@trXMinF = ymin-dif
res@trYMinF = ymin-dif
else
res@trXMinF = xmin-dif
res@trYMinF = xmin-dif
end if

end if
end if

  res@txFontHeightF   = 0.014	; set font height of gsn*String

res@tmYROn = False
res@tmXTOn = False
res@tmXMajorGrid= True
res@tmYMajorGrid= True

res@tmYRLabelsOn = False

rc1    = regline(allobs(:,par),allmodel(:,par,nm))
req1=rc1*(allobs(:,par)-rc1@xave) + rc1@yave
if (nm+1).lt.nmodels then
rc2    = regline(allobs(:,par),allmodel(:,par,nm+1))
req2=rc2*(allobs(:,par)-rc2@xave) + rc2@yave
end if
if (nm+2).lt.nmodels then
rc3    = regline(allobs(:,par),allmodel(:,par,nm+2))
req3=rc3*(allobs(:,par)-rc3@xave) + rc3@yave
end if
if (nm+3).lt.nmodels then
rc4    = regline(allobs(:,par),allmodel(:,par,nm+3))
req4=rc4*(allobs(:,par)-rc4@xave) + rc4@yave
end if

req5=xline

print(rc1)

res@tiYAxisString = "GWRF"
res@tiYAxisFontHeightF = 0.015
res@tiXAxisFontHeightF = 0.015
res@tiXAxisString = "GFS-ANL"

res@xyMarkLineMode    = (/"Markers"/)                ; choose to use markers
  res@xyMarkers         =  16                      ; choose type of marker  
  res@xyMarkerColor     = "Blue"               ; Marker color
  res@xyMarkerSizeF     = 0.0046                     ; Marker size (default 0.01)

res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.136             ; move units right
  res@pmLegendOrthogonalPosF = -0.345                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.18                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .016
res@xyExplicitLegendLabels=(/VNAME/)

plot1  = gsn_csm_xy (wks,allobs(:,par),allmodel(:,par,nm),res) ; create plot
  res@xyMarkLineMode    = (/"Lines"/)                ; choose to use markers
res@xyDashPatterns      = 0                      ; solid line 
 res@xyLineThicknesses   = (/4.8/)                ; set second line to 2
res@xyLineColor     = "Blue"               
 
plot2  = gsn_csm_xy (wks,allobs(:,par),req1,res) ; create plot

;;;;;;;;;;;;;;;;;;

if (nm+1).lt.nmodels then
res@xyMarkLineMode    = (/"Markers"/)                ; choose to use markers
  res@xyMarkers         =  16                      ; choose type of marker
  res@xyMarkerColor     = "red"
  res@xyMarkerSizeF     = 0.0036 
res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.23 ;1.1136 ;1.13                  ; move units right
  res@pmLegendOrthogonalPosF = -0.20                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.18                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .014
res@xyExplicitLegendLabels = (/"POS_AGG25"/)
plot3  = gsn_csm_xy (wks,allobs(:,par),allmodel(:,par,nm+1),res) ; create plot
  res@xyMarkLineMode    = (/"Lines"/)                ; choose to use markers
res@xyDashPatterns      = 0                      ; solid line 
 res@xyLineThicknesses   = (/3.3/)                ; set second line to 2
res@xyLineColor     = "red"
 plot4  = gsn_csm_xy (wks,allobs(:,par),req2,res) ; create plot
res@xyLineThicknesses   = (/4.0/)                ; set second line to 2
res@xyLineColor     = "Black"
res@pmLegendDisplayMode    = "Never"
end if

if nm+2.lt.nmodels then
res@xyMarkLineMode    = (/"Markers"/)                ; choose to use markers
  res@xyMarkers         =  16                      ; choose type of marker
  res@xyMarkerColor     = "green"  
  res@xyMarkerSizeF     = 0.0036
res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.19                  ; move units right
  res@pmLegendOrthogonalPosF = -0.25                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.18                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .018   
res@xyExplicitLegendLabels = (/"TRMM"/)
plot5  = gsn_csm_xy (wks,allobs(:,par),allmodel(:,par,nm+2),res) ; create plot
  res@xyMarkLineMode    = (/"Lines"/)                ; choose to use markers
res@xyDashPatterns      = 0                      ; solid line
 res@xyLineThicknesses   = (/3.3/)                ; set second line to 2
res@xyLineColor     = "green"
 plot6  = gsn_csm_xy (wks,allobs(:,par),req3,res) ; create plot
res@xyLineThicknesses   = (/4.0/)                ; set second line to 2
res@xyLineColor     = "Black"
res@pmLegendDisplayMode    = "Never"
end if

if nm+3.lt.nmodels then
res@xyMarkLineMode    = (/"Markers"/)                ; choose to use markers
  res@xyMarkers         =  16                      ; choose type of marker
  res@xyMarkerColor     = "orange"  
  res@xyMarkerSizeF     = 0.0025
res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.24                  ; move units right
  res@pmLegendOrthogonalPosF = -0.46                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.18                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .018   
res@xyExplicitLegendLabels = (/"MODEL 4"/)
plot7  = gsn_csm_xy (wks,allobs(:,par),allmodel(:,par,nm+3),res) ; create plot
  res@xyMarkLineMode    = (/"Lines"/)                ; choose to use markers
res@xyDashPatterns      = 0                      ; solid line
 res@xyLineThicknesses   = (/3.3/)                ; set second line to 2
res@xyLineColor     = "orange"
 plot8  = gsn_csm_xy (wks,allobs(:,par),req4,res) ; create plot
end if

res@xyLineThicknesses   = (/4.0/)                ; set second line to 2
res@xyLineColor     = "Black"
res@pmLegendDisplayMode    = "Never"

 plot9  = gsn_csm_xy (wks,xline,req5,res) ; create plot

rc1Round = decimalPlaces(rc1,2,True)
rc1Roundy = decimalPlaces(rc1@yintercept,2,True)

if rc1Roundy.lt.0 then
rc1Roundy=(-1)*rc1Roundy
eq1="Y = "+rc1Round+"*X - "+rc1Roundy
else
eq1="Y = "+rc1Round+"*X + "+rc1Roundy

end if

if nm+1.lt.nmodels then
rc2Round = decimalPlaces(rc2,2,True)
rc2Roundy = decimalPlaces(rc2@yintercept,2,True)
if rc2Roundy.lt.0 then   
rc2Roundy=(-1)*rc2Roundy
eq2="Y = "+rc2Round+"*X - "+rc2Roundy
else
eq2="Y = "+rc2Round+"*X + "+rc2Roundy
end if
res@txFontColor   = "Red"                    ; text font color
gsn_text_ndc(wks,eq2,0.79,0.74,res)

end if

if nm+2.lt.nmodels then
rc3Round = decimalPlaces(rc3,2,True)
rc3Roundy = decimalPlaces(rc3@yintercept,2,True)
if rc3Roundy.lt.0 then   
rc3Roundy=(-1)*rc3Roundy
eq3="Y = "+rc3Round+"*X - "+rc3Roundy
else
eq3="Y = "+rc3Round+"*X + "+rc3Roundy
end if
res@txFontColor   = "Green"                    ; text font color
gsn_text_ndc(wks,eq3,0.79,0.70,res)

end if

if nm+3.lt.nmodels then

rc4Round = decimalPlaces(rc4,2,True)
rc4Roundy = decimalPlaces(rc4@yintercept,2,True)
if rc4Roundy.lt.0 then   
rc4Roundy=(-1)*rc4Roundy
eq4="Y = "+rc4Round+"*X - "+rc4Roundy
else
eq4="Y = "+rc4Round+"*X + "+rc4Roundy
end if
res@txFontColor   = "Orange"                    ; text font color
gsn_text_ndc(wks,eq4,0.83,0.60,res)

end if

res@gsnDraw  = True
res@txFontColor   = "Blue"                    ; text font color
res@txJust        = "CenterCenter"
gsn_text_ndc(wks,eq1,0.777,0.71,res)

res@txFontColor   = "Black"
res@txFontHeightF = 0.016
gsn_text_ndc(wks,AREA,0.758,0.86,res)
gsn_text_ndc(wks,WHEN,0.788,0.82,res)

res@txFontColor   = "Black"

init=0.75
incr1=0.035
incr=0.07
hei=0.664
inchei=0.040

res@txFontHeightF = 0.016
if nm.eq.0 then
res@txFontColor   = "Black"
gsn_text_ndc(wks,"Rec Num: ",init,hei,res)
gsn_text_ndc(wks,"Bias: ",init,hei-inchei,res)
gsn_text_ndc(wks,"RMSE: ",init,hei-2*inchei,res)
gsn_text_ndc(wks,"Mean Obs: ",init,hei-3*inchei,res)
gsn_text_ndc(wks,"Mean Mod: ",init,hei-4*inchei,res)
gsn_text_ndc(wks,"STD Obs: ",init,hei-5*inchei,res)
gsn_text_ndc(wks,"STD Mod: ",init,hei-6*inchei,res)
gsn_text_ndc(wks,"Pearson: ",init,hei-7*inchei,res)
gsn_text_ndc(wks,"SI: ",init,hei-9*inchei,res)
gsn_text_ndc(wks,"R~S~2~N~: ",init,hei-8*inchei,res)
res@txFontColor   = "Blue"
gsn_text_ndc(wks,sprinti("%6.0i",times(par,nm)),init+3*incr1,hei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(bias(par,nm),2,True)),init+3*incr1,hei-inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(rmse(par,nm),2,True)),init+3*incr1,hei-2*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(meanmod(par,nm),2,True)),init+3*incr1,hei-4*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(stdmod(par,nm),2,True)),init+3*incr1,hei-6*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(pearson(par,nm),2,True)),init+3*incr1,hei-7*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(abs(scatindex(par,nm)),2,True)),init+3*incr1,hei-9*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(R2(par,nm),2,True)),init+3*incr1,hei-8*inchei,res)
res@txFontColor   = "Black"
gsn_text_ndc(wks,sprintf("%5.2f",decimalPlaces(stdobs(par),2,True)),init+3*incr1,hei-5*inchei,res)
gsn_text_ndc(wks,sprintf("%5.2f",meanobs(par)),init+3*incr1,hei-3*inchei,res)

end if

if (nm+1).lt.nmodels then
res@txFontColor   = "red"
gsn_text_ndc(wks,sprinti("%6.0i",times(par,nm+1)),init+incr1+2*incr,hei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(bias(par,nm+1),2,True)),init+incr1+2*incr,hei-inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(rmse(par,nm+1),2,True)),init+incr1+2*incr,hei-2*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(meanmod(par,nm+1),2,True)),init+incr1+2*incr,hei-4*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(stdmod(par,nm+1),2,True)),init+incr1+2*incr,hei-6*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(pearson(par,nm+1),2,True)),init+incr1+2*incr,hei-7*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(abs(scatindex(par,nm+1)),2,True)),init+incr1+2*incr,hei-9*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(R2(par,nm+1),2,True)),init+incr1+2*incr,hei-8*inchei,res)
end if

if (nm+2).lt.nmodels then res@txFontColor = "green" 
gsn_text_ndc(wks,sprinti("%6.0i",times(par,nm+2)),init+incr1+3*incr,hei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(bias(par,nm+2),2,True)),init+incr1+3*incr,hei-inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(rmse(par,nm+2),2,True)),init+incr1+3*incr,hei-2*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(meanmod(par,nm+2),2,True)),init+incr1+3*incr,hei-4*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(stdmod(par,nm+2),2,True)),init+incr1+3*incr,hei-6*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(pearson(par,nm+2),2,True)),init+incr1+3*incr,hei-7*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(abs(scatindex(par,nm+2)),2,True)),init+incr1+3*incr,hei-9*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(R2(par,nm+2),2,True)),init+incr1+3*incr,hei-8*inchei,res) 
end if
if (nm+3).lt.nmodels then res@txFontColor = "orange" 
gsn_text_ndc(wks,sprinti("%6.0i",times(par,nm+3)),init+incr1+4*incr,hei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(bias(par,nm+3),2,True)),init+incr1+4*incr,hei-inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(rmse(par,nm+3),2,True)),init+incr1+4*incr,hei-2*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(meanmod(par,nm+2),2,True)),init+incr1+3*incr,hei-4*inchei,res)
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(stdmod(par,nm+3),2,True)),init+incr1+4*incr,hei-6*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(pearson(par,nm+3),2,True)),init+incr1+4*incr,hei-7*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(abs(scatindex(par,nm+3)),2,True)),init+incr1+4*incr,hei-9*inchei,res) 
gsn_text_ndc(wks,sprintf("%6.2f",decimalPlaces(R2(par,nm+3),2,True)),init+incr1+4*incr,8*inchei,res) 
end if

delete(xline)

overlay(plot1,plot2)
if (nm+1).lt.nmodels then
overlay(plot1,plot3)
overlay(plot1,plot4)
end if
if (nm+2).lt.nmodels then
overlay(plot1,plot5)
overlay(plot1,plot6)
end if
if (nm+3).lt.nmodels then
overlay(plot1,plot7)
overlay(plot1,plot8)
end if
overlay(plot1,plot9)
draw(plot1)
frame(wks)

delete(rc1)
delete(req1)
if nm+1.lt.nmodels then
delete(rc2)
delete(req2)
end if
if nm+2.lt.nmodels then
delete(rc3) 
delete(req3)
end if
if nm+3.lt.nmodels then
delete(rc4) 
delete(req4)
end if
delete(req5)
delete(res)
end if

options=" -trim +repage "
print("CONVERT")
system("convert" + options + outfile+".png" + " " + outfile+".png")
