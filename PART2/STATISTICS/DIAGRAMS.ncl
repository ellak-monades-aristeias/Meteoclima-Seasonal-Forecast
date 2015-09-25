if nm.eq.0 then
do stpa=0,nstatpar-1
custom=0
if stpa.eq.0 then
VARNAME="BS"
else if stpa.eq.1 then
VARNAME="RMSE"
else if stpa.eq.2 then
VARNAME="ETS"
else if stpa.eq.3 then
VARNAME="HSS"
else if stpa.eq.4 then
VARNAME="POD"
else if stpa.eq.5 then
VARNAME="H"
else if stpa.eq.6 then
VARNAME="TS"
else if stpa.eq.7 then
VARNAME="FAR"
end if
end if
end if
end if
end if
end if
end if
end if

xdate1=new((/nthres/),float)
xdate=new((/nthres/),float)
xaxis=fspan(0,300,301)

xdate(:)=thres(par,:)

do inn=0,nthres-1
xdate1(inn)=sum(nst(inn,:,par,nm))-sum(dst(inn,:,par,nm))
end do

print(xdate+" "+xdate1)

NCGM=0
X11=0
EPS=0
PNG=1
PDF=0

outdir="./"
outfile =outdir+CASE+"_"+VARNAME+"_"+VNAME

print(outfile)

  wks_type = "png"
  wks_type@wkWidth = 760
  wks_type@wkHeight = 760
  wks = gsn_open_wks(wks_type,outfile)

  res = True
  res@gsnDraw         = False   ; don't draw the plots, gsn_panel will draw them
  res@gsnFrame        = False   ; don't advance the frame, gsn_panel will
  res@vpXF                = 0.135        ; size of plot
  res@vpYF                = 0.76 
  res@vpWidthF            = 0.63 
  res@vpHeightF           = 0.43 

plotvar@_FillValue=999.

if (.not.all(ismissing(plotvar(stpa,par,:,:)))) then
ymax=decimalPlaces(max(plotvar(stpa,par,:,:)),2,False)
ymin=decimalPlaces(min(plotvar(stpa,par,:,:)),2,False)
end if

if VARNAME.ne."RMSE" then
res@trYMaxF = sqrt(ymax^2)+0.1
else
res@trYMaxF = sqrt(ymax^2)+2.0
end if

res@trYMinF = 0.


  res@tiYAxisString = VARNAME
  res@tiYAxisFontHeightF = 0.015
  res@tiXAxisString = "Precipitation Thresholds (mm)"
  res@tiXAxisFontHeightF = 0.013
  res@xyLineThicknesses = (/2.2/)               ; make 2nd lines thicker
  res@xyLineColors      = (/"blue"/)          ; change line color
  res@xyDashPattern = 0               ; Make curves all solid
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.115                  ; move units right
  res@pmLegendOrthogonalPosF = -0.43                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.13                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .013
  res@xyExplicitLegendLabels = (/VNAME/)

  res@txFontHeightF = 0.015 ; set font height of gsn*String
  res@tmYRLabelsOn = False

  res@tmXBLabelFontHeightF = 0.013
  res@tmYLLabelFontHeightF = 0.016   

  res@tmXBOn  = True
  res@tmXBLabelsOn = True

  res@tmXBMode        = "Explicit"

  res@tmXBValues      = xdate

  res@tmXBLabels = "" + xdate

 plot1  = gsn_csm_xy (wks,xdate(:),plotvar(stpa,par,nm,:),res) ; create plot
y=new((/101/),float)
y=1.

res@pmLegendDisplayMode    = "Never"     
res@xyLineColors      = (/"black"/)
res@xyDashPattern = 1   
res@pmLegendOrthogonalPosF = -0.30         

plotbs  = gsn_csm_xy (wks,xaxis(:),y,res) ; create plot

if nm+1.lt.nmodels then
res@xyLineThicknesses = (/2.2/)               ; make 2nd lines thicker
 res@xyLineColors      = (/"red"/)          ; change line color
 res@xyDashPattern = 0               ; Make curves all solid

res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.12                  ; move units right
  res@pmLegendOrthogonalPosF = -0.24                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.13                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .013  
res@xyExplicitLegendLabels = (/"ARGO"/)

 plot2  = gsn_csm_xy (wks,xdate(:),plotvar(stpa,par,nm+1,:),res) ; create plot
end if

if nm+2.lt.nmodels then
res@xyLineThicknesses = (/2.2/)               ; make 2nd lines thicker
 res@xyLineColors      = (/"green"/)          ; change line color
 res@xyDashPattern = 0               ; Make curves all solid

res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.28                  ; move units right
  res@pmLegendOrthogonalPosF = -0.40                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.13                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .013    
res@xyExplicitLegendLabels = (/"MODEL 3"/)

 plot3  = gsn_csm_xy (wks,xdate(:),plotvar(stpar,par,nm+2,:),res) ; create plot
end if
if nm+3.lt.nmodels then
res@xyLineThicknesses = (/2.2/)               ; make 2nd lines thicker
 res@xyLineColors      = (/"orange"/)          ; change line color
 res@xyDashPattern = 0               ; Make curves all solid

res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 1.28                  ; move units right
  res@pmLegendOrthogonalPosF = -0.46                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.13                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .013    
res@xyExplicitLegendLabels = (/"MODEL 4"/)

 plot4  = gsn_csm_xy (wks,xdate(:),plotvar(stpa,par,nm+3,:),res) ; create plot
end if

if nm+1.lt.nmodels
overlay(plot1,plot2)
end if

if VARNAME.eq."BS"
overlay(plot1,plotbs)
end if

res@gsnDraw  = True
res@txFontHeightF = 0.014                     ; text font height
res@txJust        = "CenterCenter"
res@txFontColor   = "Black"

init=0.150
incr1=0.024
incr=0.05
hei=0.791

res@txFontHeightF = 0.008

gsn_text_ndc(wks,sum(nst(0,:,par,nm))-sum(dst(0,:,par,nm))-sum(bst(0,:,par,nm)),init-0.023,hei,res) ;0.007
gsn_text_ndc(wks,sum(nst(1,:,par,nm))-sum(dst(1,:,par,nm))-sum(bst(1,:,par,nm)),init+0.045,hei,res)
gsn_text_ndc(wks,sum(nst(2,:,par,nm))-sum(dst(2,:,par,nm))-sum(bst(2,:,par,nm)),init+0.0880,hei,res)
gsn_text_ndc(wks,sum(nst(3,:,par,nm))-sum(dst(3,:,par,nm))-sum(bst(3,:,par,nm)),init+0.163,hei,res)
gsn_text_ndc(wks,sum(nst(4,:,par,nm))-sum(dst(4,:,par,nm))-sum(bst(4,:,par,nm)),init+0.321,hei,res)
gsn_text_ndc(wks,sum(nst(5,:,par,nm))-sum(dst(5,:,par,nm))-sum(bst(5,:,par,nm)),init+0.604,hei,res)

res@txFontHeightF = 0.012

gsn_text_ndc(wks,AREA,0.840,0.74,res)
gsn_text_ndc(wks,WHEN,0.845,0.69,res)

draw(plot1)
frame(wks)

options=" -trim +repage "
print("CONVERT")
system("convert" + options + outfile+".png" + " " + outfile+".png")

end do

end if
