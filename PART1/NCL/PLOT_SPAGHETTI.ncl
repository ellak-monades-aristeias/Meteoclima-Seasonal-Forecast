load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

tmax= 7.2 
tmin= -7.2 
inct= 0.8 

west= -25
east=  50
north= 72
south= 25

climonth=stringtointeger(getenv("CLIMONTH"))
wrfmonth=climonth+1
l850 = 18
initmem=17
endmem=initmem+14
initdate="201508"+initmem

f     = addfile ("../WRFPRS/"+initdate+"/WRFPRS_d01.24.grb", "r")

lev = f->lv_ISBL2
xlon = f->ELON_GDS205_SFC
ylat = f->NLAT_GDS205_SFC
ilon = dimsizes(xlon(0,:))
jlat = dimsizes(ylat(:,0))

plots=new((/17,jlat,ilon/),float)

c = addfile("/meso01/GLOBAL/input_data/climatology/T850.t85.ltm.nc","r")

cT850 = c->T(climonth,:,:)
clT850 = doubletofloat(cT850)
climT850 = decimalPlaces(clT850,1,True)
clon = c->lon
clat = c->lat

 month_abbr = (/"","January","February","March","April","May","June","July","August","September", \
                    "October","November","December"/)

toth=0
memTsum=new((/jlat,ilon/),float)
memTsum=0
Tsum=new((/jlat,ilon/),float)
Tsum=0
do mem=initmem,endmem
memTsum=0
memtoth=0
tstart=(endmem-mem+1)*24
tend=367*24+(endmem-mem)*24
do time=tstart,tend,12

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
 
if month.eq.wrfmonth then

dir="201508"+mem

if (time.lt.100) then
step=sprinti("%2.2i",time)
else if (time.lt.1000) then
step=sprinti("%3.3i",time)
else
step=sprinti("%4.4i",time)
end if
end if

f     = addfile ("../WRFPRS/"+dir+"/WRFPRS_d01."+step+".grb", "r")
Tsum=Tsum+f->TMP_GDS205_ISBL(l850,:,:)
memTsum=memTsum+f->TMP_GDS205_ISBL(l850,:,:)
toth=toth+1
memtoth=memtoth+1
print(memtoth)
end if
end do
memmeanT=memTsum/memtoth
memregridT = linint2 (xlon(1,:),ylat(:,1),memmeanT(:,:), True, clon,clat, 0)
mem1=mem-initmem
plots(mem1,:,:)=memregridT
end do

meanT=Tsum/toth

regridT = linint2 (xlon(1,:),ylat(:,1),meanT(:,:), True, clon,clat, 0)

plots(15,:,:)=climT850
plots(16,:,:)=regridT

plots!1 = "lat"
plots!2 = "lon"
plots&lat = clat
plots&lon = clon
plots&lat@units="degrees_north"
plots&lon@units="degrees_east"

minT=min(plots)
maxT=max(plots)

print(min(plots)+" "+max(plots))

outdir="./"
outfile=outdir+"SPAG_T850_"+wrfmonth+"_"+initmem+"-"+endmem

print(outfile)

  wks_type = "png"
  wks_type@wkWidth = 800
  wks_type@wkHeight = 800
  wks = gsn_open_wks(wks_type,outfile)

gsn_define_colormap(wks,"temp_diff_18lev")

res = True
res@gsnDraw           = False                   ; don't draw
res@gsnFrame          = False                   ; don't advance frame
res@gsnAddCyclic      = True

if wrfmonth.eq.1.or.wrfmonth.eq.2.or.wrfmonth.eq.12
 res@gsnLeftString    ="ACDG/HUA      Spaghetti plot of temperature at 850 hPa (271 K)"
else
 res@gsnLeftString    ="ACDG/HUA      Spaghetti plot of temperature at 850 hPa (282 K)"
end if
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

  res@cnFillOn             = False             ; turn on color
  res@gsnSpreadColors      = False             ; use full colormap
  res@lbLabelStride        = 1
  res@lbLabelFontHeightF   = 0.012   ;;;0.012  ;;change label's font size
  res@pmLabelBarHeightF    = 0.08         ;;change height,make labels appear+disappear
  res@pmLabelBarWidthF     = 0.71

res@lbLabelsOn           = False
 res@mpFillOn          = False
  res@mpOceanFillColor = "Cyan2"
  res@mpLandFillColor =  "Yellow2"
  res@mpInlandWaterFillColor = "Cyan2"
res@cnLineLabelsOn       = False
  res@cnLineColor          = (/"red"/)
  res@cnInfoLabelOn  	   = False

res@cnLinesOn            = True
  res@cnLevelSelectionMode = "ExplicitLevels"    ; set manual contour levels
if wrfmonth.eq.1.or.wrfmonth.eq.2.or.wrfmonth.eq.12
 res@cnLevels    = (/271/)
else
 res@cnLevels    = (/282/)
end if

res@cnLineThicknessF = 2.5

res@gsnSpreadColors = True 
map = gsn_csm_map_ce(wks,res)
 res@gsnLeftString    =""
  res@gsnRightString    =""

memplot=new(15,graphic)
do ii=0,14
memplot(ii) = gsn_csm_contour(wks,plots(ii,:,:),res)
end do
  res@cnLineColor          = (/"blue"/)
res@cnLineThicknessF = 4.0
plot1 = gsn_csm_contour(wks,plots(15,:,:),res)
  res@cnLineColor          = (/"black"/)
 res@cnLineDashPattern  = 2
res@cnLineThicknessF = 4.0
plot2 = gsn_csm_contour(wks,plots(16,:,:),res)
 res@cnLineDashPattern  = 1

do i=0,jlat-1
do j=0,ilon-1
qsort(plots(0:14,i,j))
end do
end do
plot3 = gsn_csm_contour(wks,plots(8,:,:),res)

txtres = True
txtres@txFontHeightF = 0.015

overlay(map,memplot(0))
overlay(map,memplot(1))
overlay(map,memplot(2))
overlay(map,memplot(3))
overlay(map,memplot(4))
overlay(map,memplot(5))
overlay(map,memplot(6))
overlay(map,memplot(7))
overlay(map,memplot(8))
overlay(map,memplot(9))
overlay(map,memplot(10))
overlay(map,memplot(11))
overlay(map,memplot(12))
overlay(map,memplot(13))
overlay(map,memplot(14))
overlay(map,plot1)
overlay(map,plot2)
overlay(map,plot3)
draw(map)

lgres                    = True
lgres@lgAutoManage = False
 lgres@lgLineColors       = (/"red","blue","black","black"/)    ; colors for legend lines
 lgres@vpWidthF           = 0.15                   ; width of legend (NDC)
 lgres@vpHeightF          = 0.10                   ; height of legend (NDC)
 lgres@lgPerimOn          = True                 ; turn off perimeter
 lgres@lgDashIndexes      = (/0,0,2,1/)              ; dash indexes
labels = (/"Members","Climatology","Median","Mean"/)             ; no labels in lines
 gsn_legend_ndc(wks,4,labels,0.70,0.72,lgres)

frame(wks)

options=" -trim +repage "
print("CONVERT")
system("convert" + options + outfile+".png" + " " + outfile+".png")

end
