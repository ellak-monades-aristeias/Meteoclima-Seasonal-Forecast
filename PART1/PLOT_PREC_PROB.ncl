load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

west= -25
east=  50
north= 72
south= 25

climonth=stringtointeger(getenv("CLIMONTH"))
wrfmonth=climonth+1
initmem=17
endmem=initmem+14
nmem=endmem-initmem+1
initdate="201508"+initmem

f     = addfile ("../WRFPRS/"+initdate+"/WRFPRS_d01.24.grb", "r")

lev = f->lv_ISBL2
xlon = f->ELON_GDS205_SFC
ylat = f->NLAT_GDS205_SFC
ilon = dimsizes(xlon(0,:))
jlat = dimsizes(ylat(:,0))

prec=new((/jlat,ilon/),float)
prec=0.
prob=new((/jlat,ilon/),float)

 month_abbr = (/"","  January","  February","Mar","Apr","May","  June","  July","  August","Sep", \
                    "Oct","Nov","  December"/)

do down=100,300,100
prob=0.
do mem=initmem,endmem
a=0
b=0
tstart=(endmem-mem+1)*24
tend=367*24+(endmem-mem)*24
do time=tstart,tend,24

   time@units = "hours since 2015-08-"+mem+" 00:00:0.0"
   utc_date = cd_calendar(time, 0)
   year   = tointeger(utc_date(:,0))    ; Convert to integer for
   month  = tointeger(utc_date(:,1))    ; use sprinti
   day    = tointeger(utc_date(:,2))
   hour   = tointeger(utc_date(:,3))
   minute = tointeger(utc_date(:,4))
   second = utc_date(:,5)

   date_str = sprinti("%0.2iZ ", hour) + sprinti("%0.2i ", day) + \
              month_abbr(month) + " "  + sprinti("%0.4i", year)

dir="201508"+mem

if month.eq.wrfmonth.and.a.eq.0 then
a=1
print(date_str)
if (time.lt.100) then
step=sprinti("%2.2i",time)
else if (time.lt.1000) then
step=sprinti("%3.3i",time)
else
step=sprinti("%4.4i",time)
end if
end if
step1=step
end if

if wrfmonth.eq.8 then
if year.eq.2016 then

if month.eq.(wrfmonth+1).and.b.eq.0 then
print(date_str)
print(mem)
b=1
if (time.lt.100) then
step=sprinti("%2.2i",time)
else if (time.lt.1000) then
step=sprinti("%3.3i",time)
else
step=sprinti("%4.4i",time)
end if
end if
step2=step
end if

end if
else

if month.eq.(wrfmonth+1).and.b.eq.0 then
print(date_str)
print(mem)
b=1
if (time.lt.100) then
step=sprinti("%2.2i",time)
else if (time.lt.1000) then
step=sprinti("%3.3i",time)
else
step=sprinti("%4.4i",time)
end if
end if
step2=step
end if

if climonth.eq.11 then
if month.eq.1.and.b.eq.0 then
print(date_str)
print(mem)
b=1
if (time.lt.100) then
step=sprinti("%2.2i",time)
else if (time.lt.1000) then
step=sprinti("%3.3i",time)
else
step=sprinti("%4.4i",time)
end if
end if
step2=step
end if
end if

end if

end do

f1     = addfile ("../WRFPRS/"+dir+"/WRFPRS_d01."+step1+".grb", "r")
f2     = addfile ("../WRFPRS/"+dir+"/WRFPRS_d01."+step2+".grb", "r")
vnames1 = getfilevarnames(f1) 
vnames2 = getfilevarnames(f2) 
prec = f2->$vnames2(17)$ - f1->$vnames1(17)$

do i=0,jlat-1
do j=0,ilon-1
if prec(i,j).gt.down then
prob(i,j)=prob(i,j)+1
print(i)
end if
end do
end do

end do

prob=prob/nmem*100

prob!0 = "lat"
prob!1 = "lon"
prob&lat = ylat(:,0)
prob&lon = xlon(0,:)
prob&lat@units="degrees_north"
prob&lon@units="degrees_east"

minP=min(prob)
maxP=max(prob)
print((minP)+" "+max(maxP))

outdir="./"
outfile=outdir+"PROB_"+wrfmonth+"_"+initmem+"-"+endmem+"-"+down+"mm"

print(outfile)

  wks_type = "png"
  wks_type@wkWidth = 800
  wks_type@wkHeight = 800
  wks = gsn_open_wks(wks_type,outfile)

res = True
res@gsnDraw           = False                   ; don't draw
res@gsnFrame          = False                   ; don't advance frame
res@gsnAddCyclic      = True


  res@gsnLeftString    ="ACDG/HUA      Precipitation probability exceedance "+down+"mm (%)"
if wrfmonth.ge.9.and.wrfmonth.le.12 then
  res@gsnRightString    =month_abbr(wrfmonth)+" 2015"
else
  res@gsnRightString    =month_abbr(wrfmonth)+" 2016"
end if

 res@tiMainFontPosition = "Center"
  res@tiMainSide         = "Top"
  res@tiMainFontHeightF = 0.02 ;;0.020   ;;fontsz
   res@gsnCenterStringFontHeight = 0.0
  res@gsnRightStringFontHeightF = 0.014
  res@gsnLeftStringFontHeightF = 0.014
res@mpOutlineBoundarySets = "Geophysical"
  res@mpDataBaseVersion     = "HighRes"
  res@mpOutlineOn           = True
  res@mpGridAndLimbOn   = True                ; coordinates on the plot
  res@mpGridLatSpacingF = 10.               ; spacing for lat lines
  res@mpGridLonSpacingF = 10.               ; spacing for lon lines
  res@mpFillOn          = False        ; color contentinents
  res@mpFillColors      = (/0,7,18,7/); colors to draw
  res@mpLabelsOn        = True
  res@mpLabelFontColor  = True
 res@pmTickMarkDisplayMode ="Always"
   res@tmXBLabelFontHeight = 0.007

  res@mpMaxLatF       = north          ; choose subregion
  res@mpMinLatF       = south
  res@mpMaxLonF       = east
  res@mpMinLonF       = west

  res@mpCenterLonF = 0.0

  res@cnFillOn             = True             ; turn on color
  res@gsnSpreadColors      = True             ; use full colormap
  res@lbLabelStride        = 1
  res@lbLabelFontHeightF   = 0.012   ;;;0.012  ;;change label's font size
  res@pmLabelBarHeightF    = 0.08         ;;change height,make labels appear+disappear
  res@pmLabelBarWidthF     = 0.71

  res@cnLinesOn            = False             ; no contour lines

res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
res@cnLevels             = (/10,30,50,60,70,80,90/)

res@cnFillPalette="BlAqGrYeOrReVi200"
res@cnFillColors = (/-1,37,24,14,1,199,184,169/)

plot = gsn_csm_contour_map_ce(wks,prob(:,:),res)

txtres = True
txtres@txFontHeightF = 0.015

draw(wks)
frame(wks)
delete(wks)

options=" -trim +repage "
print("CONVERT")
system("convert" + options + outfile+".png" + " " + outfile+".png")

end do
end
