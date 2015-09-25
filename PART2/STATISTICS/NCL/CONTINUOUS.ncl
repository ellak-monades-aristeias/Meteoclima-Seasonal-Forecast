load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

;;;;;;; INITIAL ;;;;;;;;

if CASESTUDY.eq.1 then
load "./NAMELIST.ncl"
CASE="GWRF"
end if

;;;;;;; npar and ncol no from namelist above ;;;

load"./CONST_CONTINUOUS.ncl"

if timeplots.eq.1 then
difflim=new((/4/),float)  ;; 4 for timeplots 3 for statistics
else
difflim=new((/3/),float)
end if

if STATYPE.eq.2 then
TYPE="GWRF"
difflim(0)=10000000.
difflim(1)=6.
difflim(2)=6.
incpar=1
end if

;;; INPUT FILE ;;;

if STATYPE.eq.2 then
f=asciiread("./"+version+".txt",-1,"float")
fnames=asciiread("./"+CASE+"_"+TYPE+"_only_names.txt",-1,"string")
end if

;;;;;;;;;;;;;;;;;;
len=dimsizes(f)
nstations=floattointeger(f(0))
nss=2
nse=2
NaN="-999"

nrowmax=floattointeger(f(nss-1))

nsig=5
sigtest=new((/nsig,nstations,npar,nmodels/),float)
sigtest=0.

plot=new((/3/),graphic)  ;;taylor

bias=new((/npar,nmodels/),float)
rmse=new((/npar,nmodels/),float)
pearson=new((/npar,nmodels/),float)
R2=new((/npar,nmodels/),float)
scatindex=new((/npar,nmodels/),float)
times=new((/npar,nmodels/),integer)
stdobs=new((/npar/),float)
stdmod=new((/npar,nmodels/),float)
R2=-999.
bias=-999.
rmse=-999.
pearson=-999.
scatindex=-999.
times=-999
stdobs=-999.
stdmod=-999.

allstdmod=new((/npar,nmodels/),float)
allscov=new((/npar,nmodels/),float)
allstdobs=new((/npar/),float)
allstdmod=999.
allscov=999.
allstdobs=999.

stallobs=new((/nstations,nrowmax,npar/),float)
stallmodel=new((/nstations,nrowmax,npar,nmodels/),float)
stallobs=-999.
stallmodel=-999.

allobs=new((/nstations*nrowmax,npar/),float)
allmodel=new((/nstations*nrowmax,npar,nmodels/),float)
allobs=-999.
allmodel=-999.

stbias=new((/nstations,npar,nmodels/),float)
strmse=new((/nstations,npar,nmodels/),float)
stobs=new((/nstations,npar/),float)
stmod=new((/nstations,npar,nmodels/),float)
mststd=new((/nstations,npar,nmodels/),float)
oststd=new((/nstations,npar/),float)
stcov=new((/nstations,npar,nmodels/),float)
sttimes=new((/nstations,npar,nmodels/),integer)
msttimes=new((/nstations,npar,nmodels/),integer)
osttimes=new((/nstations,npar/),integer)
stbias=0.
sttimes=0
msttimes=0
osttimes=0

do nstat=0,nstations-1

nrow=floattointeger(f(nss))
ncol=floattointeger(f(nss+1))

if STATYPE.ne.3 then
id=fnames(nstat)
else
idd=floattointeger(f(nss+2))
id=sprinti("%5.5i",idd)
end if

print(id)

olat=f(nss+3)
olon=f(nss+4)
mlat=f(nss+5)
mlon=f(nss+6)
elev=f(nss+7)

if nstat.eq.0 then
nse=nss+7+nrow*ncol
end if

print(nrow+" "+ncol)
data=new((/nrow,ncol/),float)
date=new((/nrow/),float)
aa=0
do i=nss+8,nse,ncol
do j=0,ncol-1
data(aa,j)=f(i+j)
date(aa)=data(aa,0)
end do
aa=aa+1
end do

model=new((/nrow/),float)
obs=new((/nrow/),float)

if nstat.lt.nstations-1 then
nss=nss+nrow*ncol+8
nrow1=floattointeger(f(nss))
ncol1=floattointeger(f(nss+1))
nse=nss+7+nrow1*ncol1
end if
;;;;;;;;;;;;;;;;;;;;;;;

do par=0,npar-1,incpar

;;;;;; LIMITS ;;;;;;;;;;;

if par.eq.0 then
obot=obot1
mbot=mbot1
otop=otop1
mtop=mtop1
else if par.eq.1 then
obot=obot2
mbot=mbot2
otop=otop2
mtop=mtop2
else if par.eq.2 then
obot=obot3
mbot=mbot3
otop=otop3
mtop=mtop3
else if par.eq.3 then
obot=obot4
mbot=mbot4
otop=otop4
mtop=mtop4
end if
end if
end if
end if

;;;;;;;;;;;;;;;;;;;;;;;;

do nm=0,nmodels-1

sbias=0.
srmse=0.
scov=0.
smod=0.
mstd=0.
ostd=0.
summod=0.
ntimes=0
mtimes=0
otimes=0
sobs=0.
sumobs=0.

spar=par+1
snm=nm+ncol-nmodels*npar-npar  ;;;

model(:)=data(:,par*(nmodels+1)+snm)
obs(:)=data(:,spar*(nmodels+1))

;;;;; CALCULATE STATISTICS ;;

do i=0,nrow-1

if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop.and.(model(i)-obs(i))^2.le.difflim(par)) then

mtimes=mtimes+1
summod=summod+model(i)
otimes=otimes+1
sumobs=sumobs+obs(i)

else

mtimes=mtimes
summod=summod
otimes=otimes
sumobs=sumobs

end if

end do

do i=0,nrow-1

if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop.and.(model(i)-obs(i))^2.le.difflim(par)) then

smod=smod+model(i)
sobs=sobs+obs(i)

if mtimes.ne.0 then
mstd=mstd+(model(i)-summod/mtimes)^2
else
mstd=mstd
end if

if otimes.ne.0 then
ostd=ostd+(obs(i)-sumobs/otimes)^2
else
ostd=ostd
end if

else
ostd=ostd
mstd=mstd

end if

if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop.and.(model(i)-obs(i))^2.le.difflim(par)) then
sbias=sbias+model(i)-obs(i)
srmse=srmse+(model(i)-obs(i))^2

ntimes=ntimes+1

if otimes.ne.0.and.mtimes.ne.0 then

scov=scov+(obs(i)-sumobs/otimes)*(model(i)-summod/mtimes)
else
scov=scov
ntimes=ntimes
end if
else
if timeplots.ne.1 then
obs(i)=-999.
model(i)=-999.  ;; timeplots problem
end if

end if

end do

stbias(nstat,par,nm)=sbias
strmse(nstat,par,nm)=srmse
stobs(nstat,par)=sobs
stmod(nstat,par,nm)=smod
sttimes(nstat,par,nm)=ntimes
mststd(nstat,par,nm)=mstd
stcov(nstat,par,nm)=scov
oststd(nstat,par)=ostd
osttimes(nstat,par)=otimes
msttimes(nstat,par,nm)=mtimes

if sttimes(nstat,par,nm).ne.0 then
bias(par,nm)=stbias(nstat,par,nm)/sttimes(nstat,par,nm)
rmse(par,nm)=sqrt(strmse(nstat,par,nm)/sttimes(nstat,par,nm))
times(par,nm)=sttimes(nstat,par,nm)
else
bias(par,nm)=-999.
rmse(par,nm)=-999.
times(par,nm)=-999
end if
if msttimes(nstat,par,nm).ne.0 then
stdmod(par,nm)=sqrt(mststd(nstat,par,nm)/(msttimes(nstat,par,nm)))
else
stdmod(par,nm)=-999.
end if
if osttimes(nstat,par).ne.0 then
stdobs(par)=sqrt(oststd(nstat,par)/(osttimes(nstat,par)))
else
stdobs(par)=-999.
end if
if (mststd(nstat,par,nm).ne.0.and.oststd(nstat,par).ne.0) then
pearson(par,nm)=stcov(nstat,par,nm)/sqrt(mststd(nstat,par,nm))/sqrt(oststd(nstat,par))
else
pearson(par,nm)=-999.
end if
if oststd(nstat,par).ne.0 then
R2(par,nm)=1-strmse(nstat,par,nm)/oststd(nstat,par)
else
R2(par,nm)=-999.
end if

timesmod=msttimes(nstat,par,nm)
timesobs=osttimes(nstat,par)
meanobs=0.
if timesobs.ne.0 then
meanobs=stobs(nstat,par)/timesobs
else
meanobs=-999.
end if

if meanobs.gt.0. then
scatindex(par,nm)=rmse(par,nm)/meanobs
else
scatindex(par,nm)=-999.
end if

allobs(nstat*nrow:(nstat+1)*nrow-1,par)=obs(:)
allmodel(nstat*nrow:(nstat+1)*nrow-1,par,nm)=model(:)

stallobs(nstat,0:nrow-1,par)=obs(:)
stallmodel(nstat,0:nrow-1,par,nm)=model(:)

sncol=ncol+3
nnstat=nstat+1
if TYPE.ne."ECMWF" then
if (par.eq.0.or.par.eq.1.or.par.eq.2).and.plotstations.eq.0 then
header1 = (/"NSTATIONS="+nstations+" NPAR="+npar,\
            "NROWS="+nrow+" NCOLS="+sncol,\
            "STATION="+id+"."+nnstat+" OLAT="+olat+" OLON="+olon+" MLAT="+mlat+" MLON="+mlon+" ELEV="+elev,\
            "PARAMETER       BIAS      RMSE        STD        PEARSON    RSQ    SCAT_INDEX  times     mod_times   obs_times"/)

header2 = (/"NROWS="+nrow+" NCOLS="+sncol,\
            "STATION="+id+"."+nnstat+" OLAT="+olat+" OLON="+olon+" MLAT="+mlat+" MLON="+mlon+" ELEV="+elev,\
            "PARAMETER       BIAS      RMSE        STD        PEARSON    RSQ    SCAT_INDEX  times     mod_times   obs_times"/)


alist = [/PARAMETER(par)+"_MOD_"+snm, bias(par,nm),  rmse(par,nm), stdmod(par,nm), pearson(par,nm), R2(par,nm), abs(scatindex(par,nm)),times(par,nm), timesmod,timesobs/]

if (nstat.eq.0.and.par.eq.0.and.nm.eq.0) then
hlist = [/header1/]
else if (nstat.ne.0.and.par.eq.0.and.nm.eq.0)
hlist = [/header2/]
else
end if
end if

if nm.eq.(nmodels-1) then
alist1 = [/PARAMETER(par)+"_OBS", NaN,  NaN, stdobs(par), NaN, NaN, NaN, NaN, NaN,timesobs/]
end if

end if ;par
end if

end do

end do

delete(obs)  
delete(model)
delete(data)
delete(date)

if plotstations.eq.1 then

do par=0,npar-1,incpar
if par.eq.0 then
obot=obot1
mbot=mbot1
otop=otop1
mtop=mtop1
else if par.eq.1 then
obot=obot2
mbot=mbot2
otop=otop2
mtop=mtop2
else if par.eq.2 then
obot=obot3
mbot=mbot3
otop=otop3
mtop=mtop3
else if par.eq.3 then
obot=obot4
mbot=mbot4
otop=otop4
mtop=mtop4
end if
end if
end if
end if

end do

do par=0,npar-1,incpar
if par.eq.0 then
obot=obot1
mbot=mbot1
otop=otop1
mtop=mtop1
else if par.eq.1 then
obot=obot2
mbot=mbot2
otop=otop2
mtop=mtop2
else if par.eq.2 then
obot=obot3
mbot=mbot3
otop=otop3
mtop=mtop3
else if par.eq.3 then
obot=obot4
mbot=mbot4
otop=otop4
mtop=mtop4
end if
end if
end if
end if

end do
end if

end do

delete(spar)
delete(snm)
delete(meanobs)

;;;; TOTAL ;;;;;

meanmod=new((/npar,nmodels/),float)
meanobs=new((/npar/),float)

do par=0,npar-1,incpar
spar=par+1

timesobs=sum(osttimes(:,par))
if timesobs.ne.0 then
meanobs(par)=sum(stobs(:,par))/timesobs
else
meanobs(par)=meanobs(par)
end if

end do

do par=0,npar-1,incpar
do nm=0,nmodels-1
snm=nm+1

timesmod=sum(msttimes(:,par,nm))
if timesmod.ne.0 then
meanmod(par,nm)=sum(stmod(:,par,nm))/timesmod
else
meanmod(par,nm)=meanmod(par,nm)
end if

end do
end do

do par=0,npar-1,incpar

if par.eq.0 then
obot=obot1
mbot=mbot1
otop=otop1
mtop=mtop1
else if par.eq.1 then
obot=obot2
mbot=mbot2
otop=otop2
mtop=mtop2
else if par.eq.2 then
obot=obot3
mbot=mbot3
otop=otop3
mtop=mtop3
else if par.eq.3 then
obot=obot4
mbot=mbot4
otop=otop4
mtop=mtop4
end if
end if
end if
end if

spar=par+1

do nm=0,nmodels-1
stdobsall=0.
stdmodall=0.
scovall=0.

snm=nm+ncol-nmodels*npar-npar

nss=2
nse=2

do nstat=0,nstations-1
nrow=floattointeger(f(nss))
ncol=floattointeger(f(nss+1))
data=new((/nrow,ncol/),float)
date=new((/nrow/),float)
aa=0

if nstat.eq.0 then
nse=nss+7+nrow*ncol
end if

do i=nss+8,nse,ncol
do j=0,ncol-1
data(aa,j)=f(i+j)
date(aa)=data(aa,0)
end do
aa=aa+1
end do

model=new((/nrow/),float)
obs=new((/nrow/),float)

if nstat.lt.(nstations-1) then
nss=nss+nrow*ncol+8
nrow1=floattointeger(f(nss))
ncol1=floattointeger(f(nss+1))
print(nrow1)
print(ncol1)
nse=nss+7+nrow1*ncol1
end if

obs(:)=data(:,spar*(nmodels+1))

model(:)=data(:,par*(nmodels+1)+snm)
 
do i=0,nrow-1

if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop.and.(model(i)-obs(i))^2.le.difflim(par)) then
stdobsall=stdobsall+(obs(i)-meanobs(par))^2
stdmodall=stdmodall+(model(i)-meanmod(par,nm))^2
scovall=scovall+(model(i)-meanmod(par,nm))*(obs(i)-meanobs(par))
end if
end do

delete(obs)  
delete(model)
delete(data)
delete(date)

end do

allstdmod(par,nm)=stdmodall
stdmodall=0.
allscov(par,nm)=scovall
scovall=0.

end do

allstdobs(par)=stdobsall
stdobsall=0.

end do

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

if plotstations.eq.0.and.TYPE.ne."ECMWF" then
delete(alist)
delete(hlist)
end if

delete(bias)
delete(rmse)
delete(pearson)
delete(stdmod)
delete(times)
delete(stdobs)
delete(scatindex)

bias=new((/npar,nmodels/),float)
rmse=new((/npar,nmodels/),float)
pearson=new((/npar,nmodels/),float)
R2=new((/npar,nmodels/),float)
scatindex=new((/npar,nmodels/),float)
times=new((/npar,nmodels/),integer)
stdobs=new((/npar/),float)
stdmod=new((/npar,nmodels/),float)
bias=-999.
rmse=-999.
pearson=-999.
scatindex=-999.
times=-999
stdobs=-999.
stdmod=-999.

do par=0,npar-1,incpar

if par.eq.0 then
obot=obot1
mbot=mbot1
otop=otop1
mtop=mtop1
else if par.eq.1 then
obot=obot2
mbot=mbot2
otop=otop2
mtop=mtop2
else if par.eq.2 then
obot=obot3
mbot=mbot3
otop=otop3
mtop=mtop3
else if par.eq.3 then
obot=obot4
mbot=mbot4
otop=otop4
mtop=mtop4
end if
end if
end if
end if

if sum(osttimes(:,par)).ne.0 then
stdobs(par)=sqrt(allstdobs(par)/sum(osttimes(:,par)))
else
stdobs(par)=-999.
end if

timesobs=sum(osttimes(:,par))

do nm=0,nmodels-1
snm=nm+1

if sum(sttimes(:,par,nm)).ne.0 then
bias(par,nm)=sum(stbias(:,par,nm))/sum(sttimes(:,par,nm))
rmse(par,nm)=sqrt(sum(strmse(:,par,nm))/sum(sttimes(:,par,nm)))
times(par,nm)=sum(sttimes(:,par,nm))
else
bias(par,nm)=-999.
rmse(par,nm)=-999.
times(par,nm)=-999
end if

if sum(msttimes(:,par,nm)).ne.0 then
stdmod(par,nm)=sqrt(allstdmod(par,nm)/sum(msttimes(:,par,nm)))
else
stdmod(par,nm)=-999.
end if
if allstdobs(par).ne.0 .and.allstdmod(par,nm).ne.0 then
pearson(par,nm)=allscov(par,nm)/sqrt(allstdmod(par,nm))/sqrt(allstdobs(par))
else
pearson(par,nm)=-999.
end if
if meanobs(par).ne.0 then
scatindex(par,nm)=rmse(par,nm)/meanobs(par)
else
scatindex(par,nm)=-999.
end if
if allstdobs(par).ne.0 then
R2(par,nm)=1-sum(strmse(:,par,nm))/allstdobs(par)
else
R2(par,nm)=-999.
end if

if (par.eq.0.or.par.eq.1.or.par.eq.2).and.plotstations.eq.0 .and.TYPE.ne."ECMWF" then

alist = [/PARAMETER(par)+"_MOD_"+snm, bias(par,nm),  rmse(par,nm), stdmod(par,nm), pearson(par,nm), R2(par,nm), abs(scatindex(par,nm)),times(par,nm), timesmod,timesobs/]
header = (/"PARAMETER       BIAS      RMSE        STD        PEARSON    RSQ     SCAT_INDEX  times     mod_times   obs_times"/)
hlist = [/header/]

end if ;par

end do
if (par.eq.0.or.par.eq.1.or.par.eq.2).and.plotstations.eq.0.and.TYPE.ne."ECMWF"  then

alist2 = [/PARAMETER(par)+"_OBS", NaN,  NaN, stdobs(par), NaN, NaN, NaN, NaN, NaN,timesobs/]
end if ;par


end do


load"./const_continuous.ncl"
do par=0,npar-1,incpar
if par.eq.0 then
obot=obot1
mbot=mbot1
otop=otop1
mtop=mtop1
else if par.eq.1 then
obot=obot2
mbot=mbot2
otop=otop2
mtop=mtop2
else if par.eq.2 then
obot=obot3
mbot=mbot3
otop=otop3
mtop=mtop3
else if par.eq.3 then
obot=obot4
mbot=mbot4
otop=otop4
mtop=mtop4
end if
end if
end if
end if

if (par.eq.0.or.par.eq.1.or.par.eq.2).and.plotstations.eq.0 then

stallobs@_FillValue=-999.
stallmodel@_FillValue=-999.

do nm=0,nmodels-1

total=0
signif=0

load"./SCATTER.ncl"

end do
end if ;par

end do

end
