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
ilon = dimsizes(xlon)
jlat = dimsizes(ylat)

c = addfile("/meso01/GLOBAL/input_data/climatology/T850.t85.ltm.nc","r")

cT850 = c->T(climonth,:,:)
clT850 = doubletofloat(cT850)
climT850 = decimalPlaces(clT850,1,True)
clon = c->lon
clat = c->lat

 month_abbr = (/"","January","February","March","April","May","June","July","August","September", \
                    "October","November","December"/)

toth=0
Tsum=new((/jlat,ilon/),float)
Tsum=0
do mem=initmem,endmem
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
toth=toth+1
end if
end do
end do

meanT=Tsum/toth

regridT = linint2 (xlon(1,:),ylat(:,1),meanT(:,:), True, clon,clat, 0)

diffT=regridT-climT850

diffT!0 = "lat"
diffT!1 = "lon"
diffT&lat = clat
diffT&lon = clon
diffT&lat@units="degrees_north"
diffT&lon@units="degrees_east"

minT=min(diffT)
maxT=max(diffT)

print(min(diffT)+" "+max(diffT))

outdir="./"
outfile=outdir+"EXPL_T850_"+wrfmonth+"_"+initmem+"-"+endmem

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

 res@gsnLeftString    ="ACDG/HUA                Temperature at 850 hPa anomalies"
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
res@lbLabelsOn           = False

  res@cnLinesOn            = False             ; no contour lines

res@cnLinesOn            = False             ; no contour lines
  res@cnLevelSelectionMode = "ExplicitLevels"    ; set manual contour levels


  res@cnLevels    = (/-2.5,2.5/)
   res@cnFillColors = (/"blue","white","red"/)
plot = gsn_csm_contour_map_ce(wks,diffT(:,:),res)

txres               = True                     ; text mods desired
txres@txFontHeightF = 0.015                     ; font smaller. default big

gsn_text_ndc(wks,"Below Normal",0.26,0.19,txres)
gsn_text_ndc(wks,"Normal",0.50,0.19,txres)
gsn_text_ndc(wks,"Above Normal",0.74,0.19,txres)

res@gsnSpreadColors = True 

plot = gsn_csm_contour_map_ce(wks,diffT(:,:),res)

txtres = True
txtres@txFontHeightF = 0.015

draw(wks)
frame(wks)
delete(wks)

options=" -trim +repage "
print("CONVERT")
system("convert" + options + outfile+".png" + " " + outfile+".png")

end
