load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

west= -180
east=  180
north= 70
south= -70

aa=0
if tmm.eq.0 then
climonth=5
ndays=30
else if tmm.eq.1 then
climonth=6
ndays=31
else if tmm.eq.2 then
climonth=7
ndays=31
end if
end if
end if

resol=0.50
aslon=floattointeger((east-west)/resol)-1
aslat=floattointeger((north-south)/resol)-1

print(aslon+" "+aslat)
asciidata=new((/aslat*aslon/),string)

wrfmonth=climonth+1
l500 = 9
l850 = 18
cl500 = 13
cl850 = 20
level=l850
clevel=cl850
initmem=17
endmem=initmem+14
nmem=endmem-initmem+1
initdate="201502"+initmem

f     = addfile ("../WRFPRS/"+initdate+"/WRFPRS_d01.24.grb", "r")

lev = f->lv_ISBL2
xlon = f->ELON_GDS205_SFC
ylat = f->NLAT_GDS205_SFC
ilon = dimsizes(xlon)
jlat = dimsizes(ylat)

if resol.eq.1 then
c = addfile("../../FEBRUARY_2015/EVALUATION/NOMADS_WINTER_14-15/NOMADS_201506/gfs_3_20150601_0000_000.grb","r")
clev = c->lv_ISBL3
clat = c->lat_3(::-1)
clon = c->lon_3
else
c = addfile("./NOMADS_GFS/GFS_00_12_201506/gfs_4_20150601_0000_000.grb2","r")
clat = c->lat_0(::-1)
clon = c->lon_0
clev = c->lv_ISBL0
end if

cilon = dimsizes(clon)
cjlat = dimsizes(clat)

print(cilon+" "+cjlat)

month_abbr = (/"","January","February","March","April","May","June","July","August","September", \
                   "October","November","December"/)

Tsum=new((/jlat,ilon/),float)
cTsum=new((/cjlat,cilon/),float)
sinithh=sprinti("%2.2i",inithour)
Tsum=0
cTsum=0
toth=0
ctoth=0

do wrfday=1,ndays

do mem=initmem,endmem
tstart=2160+(endmem-mem+1)*24
tend=200*24+(endmem-mem)*24
do time=tstart,tend,24

   time@units = "hours since 2015-02-"+mem+" "+sinithh+":00:0.0"
   utc_date = cd_calendar(time, 0)
   year   = tointeger(utc_date(:,0))    ; Convert to integer for
   month  = tointeger(utc_date(:,1))    ; use sprinti 
   day    = tointeger(utc_date(:,2))
   hour   = tointeger(utc_date(:,3))
   minute = tointeger(utc_date(:,4))
   second = utc_date(:,5)


   date_str = sprinti("%0.2iZ ", hour) + sprinti("%0.2i ", day) + \
              month_abbr(month) + " "  + sprinti("%0.4i", year)
 
smm=sprinti("%2.2i",month)
sdd=sprinti("%2.2i",day)
shh=sprinti("%2.2i",hour)
year2=year-2000
syy=sprinti("%4.4i",year)
syy2=sprinti("%2.2i",year2)

if month.eq.wrfmonth then
if day.eq.wrfday then

date=syy2+smm+sdd+shh
print(date_str+" "+mem) 

if mem.eq.initmem then
if resol.eq.1 then
c = addfile("../../FEBRUARY_2015/EVALUATION/NOMADS_SUMMER_15/NOMADS_"+syy+""+smm+"/gfs_3_"+year+""+smm+""+sdd+"_"+shh+"00_000.grb","r")
cTsum = cTsum+c->TMP_3_ISBL(clevel,::-1,:)
clat = c->lat_3(::-1)
clon = c->lon_3
else
c = addfile("./NOMADS_GFS/GFS_00_12_"+year+""+smm+"/gfs_4_"+year+""+smm+""+sdd+"_"+shh+"00_000.grb2","r")
cTsum = cTsum+c->TMP_P0_L100_GLL0(clevel,::-1,:)
clat = c->lat_0(::-1)
clon = c->lon_0
end if

ctoth=ctoth+1

end if

dir="201502"+mem

if (time.lt.100) then
step=sprinti("%2.2i",time)
else if (time.lt.1000) then
step=sprinti("%3.3i",time)
else
step=sprinti("%4.4i",time)
end if
end if

f     = addfile ("../WRFPRS/"+dir+"/WRFPRS_d01."+step+".grb", "r")
Tsum=Tsum+f->TMP_GDS205_ISBL(level,:,:)
toth=toth+1

end if
end if

end do
end do

end do

meanT=Tsum/toth
meancT=cTsum/ctoth
print(toth)
print(ctoth)
regridT = linint2 (xlon(1,:),ylat(:,1),meanT(:,:), True, clon,clat, 0)

regridT!0 = "lat"
regridT!1 = "lon"
regridT&lat = clat
regridT&lon = clon
regridT&lat@units="degrees_north"
regridT&lon@units="degrees_east"
minT=min(regridT)
maxT=max(regridT)

regridT@_FillValue=-999
do i=0,dimsizes(clat)-1
do j=0,dimsizes(clon)-1
if clon(j).gt.180 then
clon(j)=clon(j)-360
end if
if clon(j).gt.west.and.clon(j).lt.east.and.clat(i).gt.south.and.clat(i).lt.north then
asciidata(aa)=date+"   "+sprintf("%3.3f",regridT(i,j))+"   "+sprintf("%3.3f",meancT(i,j))
aa=aa+1
end if
end do
end do

asciiwrite("SEASONAL_T"+lev(level)+"_"+wrfmonth+"_"+inithour+"_"+west+"_"+east+"_"+south+"_"+north+"_Deg_"+resol+".txt",asciidata)
delete(asciidata)

end
