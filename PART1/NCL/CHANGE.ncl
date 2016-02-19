load "$NCARG_ROOT/lib/ncarg/nclex/gsun/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclex/gsun/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

apo=abs(stringtointeger(getenv("runid"))-31)  ; the last day of the month e.g. for August is 31

a = addfile("./wrflowinp_d0"+dd+".nc","w")
b = addfile("./wrfinput_d0"+dd+".nc","r")
c = addfile("./NCL/icec.mnmean.nc","r")

seaice = a->SEAICE
sst = a->SST
landmask = b->LANDMASK
wrflat=b->XLAT
wrflon=b->XLONG
wrflat1d=wrflat(0,:,0)
wrflon1d=wrflon(0,0,:)
qsort(wrflon1d)

icetime = c->time
ice = short2flt(c->icec)
icelat = c->lat(::-1)
icelon = c->lon-180.0
  month_abbr = (/"","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep", \
                    "Oct","Nov","Dec"/)
    icetime@units = "days since 1800-01-01 00:00:0.0"
   utc_date = ut_calendar(icetime, 0)
   year   = tointeger(utc_date(:,0))    ; Convert to integer for
   month  = tointeger(utc_date(:,1))    ; use sprinti
   day    = tointeger(utc_date(:,2))
   hour   = tointeger(utc_date(:,3))
   minute = tointeger(utc_date(:,4))
   second = utc_date(:,5)
   date_str = sprinti("%0.2iZ ", hour) + sprinti("%0.2i ", day) + \
              month_abbr(month) + " "  + sprinti("%0.4i", year)

climice=new((/12,dimsizes(icelat),dimsizes(icelon)/),float)
climice=0.

do t=0,11
do i=0,dimsizes(icelat)-1
do j=0,dimsizes(icelon)-1
climice(t,i,j)=sum(ice(t:396:12,i,j))/32
end do
end do
end do

reclimice = linint2 (icelon,icelat,climice(:,::-1,:), True, wrflon1d,wrflat1d, 0)

dims=dimsizes(sst)
dimtimes=dims(0)
dimlat=dims(1)
dimlon=dims(2)

reclimice@_FillValue = -999.

do t=0,11
do i=0,dimlat-1
do j=0,dimlon-1
if (.not.ismissing(reclimice(t,i,j))) then
if reclimice(t,i,j).gt.50 then
reclimice(t,i,j)=1
else
reclimice(t,i,j)=0
end if
else
reclimice(t,i,j)=0
end if
end do
end do
end do

if dd.eq.1 then

do t=0,14
seaice(t,:,:)=seaice(0,:,:)
end do

do t=15,apo+30
seaice(t,:,:)=reclimice(8,:,:)
end do

do t=apo+31,apo+60
seaice(t,:,:)=reclimice(9,:,:)
end do

do t=apo+61,apo+91
seaice(t,:,:)=reclimice(10,:,:)
end do

do t=apo+92,apo+123
seaice(t,:,:)=reclimice(11,:,:)
end do

do t=apo+124,apo+155
seaice(t,:,:)=reclimice(0,:,:)
end do

do t=apo+156,apo+185
seaice(t,:,:)=reclimice(1,:,:)
end do

do t=apo+186,apo+217
seaice(t,:,:)=reclimice(2,:,:)
end do

do t=apo+218,apo+248
seaice(t,:,:)=reclimice(3,:,:)
end do

do t=apo+249,apo+280
seaice(t,:,:)=reclimice(4,:,:)
end do

do t=apo+281,apo+311
seaice(t,:,:)=reclimice(5,:,:)
end do

do t=apo+312,apo+343
seaice(t,:,:)=reclimice(6,:,:)
end do

do t=apo+344,dimtimes-1
seaice(t,:,:)=reclimice(7,:,:)
end do

end if

stadec=120+apo
endjan=151+apo
do t=stadec,endjan
k=(endjan-t)/31.
m=(t-stadec)/31.
print(t+" "+k+" "+m)
sst(t,:,:)=k*sst(stadec,:,:)+m*sst(endjan,:,:)
end do

do t=1,14
print(t)
sst(t,:,:)=sst(0,:,:)
end do

do t=15,17,1
print(t)
sst(t,:,:)=0.1*sst(t,:,:)+0.9*sst(t-1,:,:)
end do

do t=18,20,1
print(t)
sst(t,:,:)=0.2*sst(t,:,:)+0.8*sst(t-1,:,:)
end do

do t=21,23,1
print(t)
sst(t,:,:)=0.3*sst(t,:,:)+0.7*sst(t-1,:,:)
end do

do t=24,26,1
print(t)
sst(t,:,:)=0.4*sst(t,:,:)+0.6*sst(t-1,:,:)
end do

do t=27,29,1
print(t)
sst(t,:,:)=0.5*sst(t,:,:)+0.5*sst(t-1,:,:)
end do

a->SST = sst

if dd.eq.1 then
a->SEAICE = seaice
end if

end 
