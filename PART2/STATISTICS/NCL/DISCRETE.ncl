load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

do mmm=6,8
CASE="SEASONAL_PREC_"+mmm+"_0_-180_180_-70_70_Deg_0.5"
version="JUNE"  ;; the month
resol=0.5

;;;;;;; INITIAL ;;;;;;;;

if mmm.eq.6 then
WHEN="JUNE 2015  "
else if mmm.eq.7 then
WHEN="JULY 2015  "
else if mmm.eq.8 then
WHEN="AUGUST 2015  "
end if
end if
end if

AREA="GLOBAL70"
VNAME="PREC"

load "./CONST_DISCRETE.ncl"
numbins=fspan(1,nthres,nthres)

;;; INPUT FILE ;;;

f=asciiread("./"+CASE+".txt",-1,"float")

;;;;;;;;;;;;;;;;;;
len=dimsizes(f)
nstations=floattointeger(f(0))
nss=2
nse=2
NaN="-999"
nrowmax=floattointeger(f(nss-1))

nstatpar=8  ;;; deiktes
plotvar=new((/nstatpar,npar,nmodels,nthres/),float)
plotvar=-999.
plotvar@_FillValue=-999.

a=new((/nthres/),float)
b=new((/nthres/),float)
c=new((/nthres/),float)
d=new((/nthres/),float)
n=new((/nthres/),float)

ast=new((/nthres,nstations,npar,nmodels/),float)
bst=new((/nthres,nstations,npar,nmodels/),float)
cst=new((/nthres,nstations,npar,nmodels/),float)
dst=new((/nthres,nstations,npar,nmodels/),float)
nst=new((/nthres,nstations,npar,nmodels/),float)
ast=0.
bst=0.
cst=0.
dst=0.
nst=0.

srmsest=new((/nthres,nstations,npar,nmodels/),float)
timesrmsest=new((/nthres,nstations,npar,nmodels/),float)

do nstat=0,nstations-1
nrow=floattointeger(f(nss))
ncol=floattointeger(f(nss+1))

idd=floattointeger(f(nss+2))
id=sprinti("%5.5i",idd)
olat=f(nss+3)
olon=f(nss+4)
mlat=f(nss+5)
mlon=f(nss+6)
elev=f(nss+7)

print(nstat)
print(nstations+" "+olat+" "+olon+" "+mlat+" "+mlon+" "+elev+" "+nrow+" "+ncol)

data=new((/nrow,ncol/),float)
date=new((/nrow/),integer)

if nstat.eq.0 then
nse=nss+7+nrow*ncol
end if

aa=0
do i=nss+8,nse,ncol
do j=0,ncol-1
data(aa,j)=f(i+j)
date(aa)=floattointeger(data(aa,0))
end do
aa=aa+1
end do
model=new((/nrow/),float)
obs=new((/nrow/),float)

yy=new((/nrow/),"long")
mm=new((/nrow/),"long")
dd=new((/nrow/),"long")
hr=new((/nrow/),"long")

do i=0,nrow-1

yy(i)=date(i)/1000000
mm(i)=date(i)/10000-yy(i)*100
dd(i)=date(i)/100-yy(i)*10000-mm(i)*100
hr(i)=date(i)-yy(i)*1000000-mm(i)*10000-dd(i)*100

end do

if nstat.lt.nstations-1 then
print(nss)
nss=nss+nrow*ncol+8
nrow1=floattointeger(f(nss))
ncol1=floattointeger(f(nss+1))
print(nss)
print(nrow1)
nse=nss+7+nrow1*ncol1
end if

print(npar)
do par=0,npar-1

;;;;;; LIMITS ;;;;;;;;;;;

if par.eq.0 then
obot=obotw
mbot=mbotw
otop=otopw
mtop=mtopw
else if par.eq.1 then
obot=obott
mbot=mbott
otop=otopt
mtop=mtopt
else if par.eq.2 then
obot=obotm
mbot=mbotm
otop=otopm
mtop=mtopm
else if par.eq.3 then
obot=obotrh
mbot=mbotrh
otop=otoprh
mtop=mtoprh
end if
end if
end if
end if

;;;;;;;;;;;;;;;;;;;;;;;;

do nm=0,nmodels-1

times=0
timesmod=0
timesobs=0

a=0.
b=0.
c=0.
d=0.
n=0.

spar=par+1
snm=nm+ncol-nmodels*npar-npar

model(:)=data(:,par*(nmodels+1)+snm)
obs(:)=data(:,spar*(nmodels+1))

;;;;;;; BINS ;;;;;;;;;;
obsbins=new((/nrow/),float)
modbins=new((/nrow/),float)
obsallbins=new((/nthres,nrow/),float)
modallbins=new((/nthres,nrow/),float)
obsbins=999.
modbins=999.
;;;;;;;;;;;;;;;;;;;;;;;

do i=0,nrow-1

if (model(i).ge.mbot.and.model(i).lt.mtop) then
timesmod=timesmod+1
end if
if (obs(i).ge.obot.and.obs(i).lt.otop) then
timesobs=timesobs+1
end if
if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop) then
times=times+1
end if

if i.gt.0.and.hr(i).eq.6.and.hr(i-1).eq.0 then
obs(i)=obs(i)-obs(i-1)
else
obs(i)=obs(i)
end if
if i.gt.0.and.hr(i).eq.18.and.hr(i-1).eq.12 then
obs(i)=obs(i)-obs(i-1)
else
obs(i)=obs(i)
end if

if (i.eq.0.and.(hr(i).eq.6.or.hr(i).eq.18)) then
obs(i)=-999.
else
obs(i)=obs(i)
end if
end do

;;;;; CALCULATE STATISTICS ;;

bias=new((/nthres/),float)
hh=new((/nthres/),float)
ts=new((/nthres/),float)
pod=new((/nthres/),float)
far=new((/nthres/),float)
e=new((/nthres/),float)
ets=new((/nthres/),float)
hss=new((/nthres/),float)
srmse=new((/nthres/),float)
srmse=0.
rmse=new((/nthres/),float)
timesrmse=new((/nthres/),float)
timesrmse=0

do bb=0,nthres-1
do i=0,nrow-1
if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop) then
if (obs(i).ge.thres(par,bb)) then 
timesrmse(bb)=timesrmse(bb)+1
srmse(bb)=srmse(bb)+(model(i)-obs(i))^2
end if
end if

end do
end do

do bb=0,nthres-1
do i=0,nrow-1
if (obs(i).ge.obot.and.obs(i).lt.otop.and.model(i).ge.mbot.and.model(i).lt.mtop) then
if (obs(i).ge.thres(par,bb).and.model(i).ge.thres(par,bb)) then
a(bb)=a(bb)+1
else
a(bb)=a(bb)
end if
if (obs(i).lt.thres(par,bb).and.model(i).ge.thres(par,bb)) then
b(bb)=b(bb)+1
else
b(bb)=b(bb)
end if
if (obs(i).ge.thres(par,bb).and.model(i).lt.thres(par,bb)) then
c(bb)=c(bb)+1
else
c(bb)=c(bb)
end if
if (obs(i).lt.thres(par,bb).and.model(i).lt.thres(par,bb)) then
d(bb)=d(bb)+1
else
d(bb)=d(bb)
end if
end if
end do

n(bb)=a(bb)+b(bb)+c(bb)+d(bb)

if (a(bb)+c(bb)).ne.0 then
bias(bb)=(a(bb)+b(bb))/(a(bb)+c(bb))
pod(bb)=a(bb)/(a(bb)+c(bb))
else
bias(bb)=999.
pod(bb)=999.
end if

if n(bb).ne.0 then
hh(bb)=(a(bb)+d(bb))/n(bb)
else
hh(bb)=999.
end if

if (a(bb)+b(bb)+c(bb)).ne.0 then
ts(bb)=a(bb)/(a(bb)+b(bb)+c(bb))
else
ts(bb)=999.
end if

if (a(bb)+b(bb)).ne.0 then
far(bb)=b(bb)/(a(bb)+b(bb))
else
far(bb)=999.
end if

if n(bb).ne.0 then
e(bb)=((a(bb)+b(bb))*(a(bb)+c(bb)))/n(bb)
if (a(bb)+b(bb)+c(bb)-e(bb)).ne.0 then
ets(bb)=(a(bb)-e(bb))/(a(bb)+b(bb)+c(bb)-e(bb))
else
ets(bb)=999.
end if
else
e(bb)=999.
ets(bb)=999.
end if

if ((a(bb)+c(bb))*(c(bb)+d(bb))+(b(bb)+d(bb))*(b(bb)+d(bb))).ne.0 then
hss(bb)=(2*(a(bb)*d(bb)-b(bb)*c(bb)))/((a(bb)+c(bb))*(c(bb)+d(bb))+(b(bb)+d(bb))*(b(bb)+d(bb)))
else
hss(bb)=999.
end if

if timesrmse(bb).ne.0 then
rmse(bb)=sqrt(srmse(bb)/timesrmse(bb))
else
rmse(bb)=999.
end if

ast(bb,nstat,par,nm)=a(bb)
bst(bb,nstat,par,nm)=b(bb)
cst(bb,nstat,par,nm)=c(bb)
dst(bb,nstat,par,nm)=d(bb)
nst(bb,nstat,par,nm)=n(bb)

srmsest(bb,nstat,par,nm)=srmse(bb)
timesrmsest(bb,nstat,par,nm)=timesrmse(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

header1 = (/"NSTATIONS="+nstations,\
            "NROWS="+nrow+" NCOLS="+ncol,\
            "STATION="+id+" OLAT="+olat+" OLON="+olon+" MLAT="+mlat+" MLON="+mlon+" ELEV="+elev,\
            "BIN    PARAMETER       BIAS       RMSE     ETS       HSS       POD         H        TS          FAR            a          b          c        d         n"/)

header2 = (/"NROWS="+nrow+" NCOLS="+ncol,\
            "STATION="+id+" OLAT="+olat+" OLON="+olon+" MLAT="+mlat+" MLON="+mlon+" ELEV="+elev,\
            "BIN    PARAMETER       BIAS       RMSE     ETS       HSS       POD         H        TS          FAR            a          b          c        d         n"/)


alist = [/numbins(bb),PARAMETER(par)+"_MOD_"+snm, bias(bb), rmse(bb), ets(bb), hss(bb), pod(bb), hh(bb), ts(bb), far(bb),a(bb),b(bb),c(bb),d(bb),n(bb)/]


if (nstat.eq.0.and.par.eq.0.and.nm.eq.0.and.bb.eq.0) then
hlist = [/header1/]
else if (nstat.ne.0.and.par.eq.0.and.nm.eq.0.and.bb.eq.0)
hlist = [/header2/]
else
end if
end if

end do
delete(obsbins)
delete(modbins)
delete(modallbins)
delete(obsallbins)

end do
end do
delete(obs)
delete(model)
delete(data)
delete(date)
delete(yy)
delete(mm)
delete(dd)
delete(hr)
end do

do par=0,npar-1
spar=par+1

do nm=0,nmodels-1
snm=nm+1

do bb=0,nthres-1

if (sum(ast(bb,:,par,nm))+sum(cst(bb,:,par,nm))).ne.0 then
bias(bb)=(sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm)))/(sum(ast(bb,:,par,nm))+sum(cst(bb,:,par,nm)))
pod(bb)=sum(ast(bb,:,par,nm))/(sum(ast(bb,:,par,nm))+sum(cst(bb,:,par,nm)))
else
bias(bb)=999.
pod(bb)=999.
end if

if sum(nst(bb,:,par,nm)).ne.0 then
hh(bb)=(sum(ast(bb,:,par,nm))+sum(dst(bb,:,par,nm)))/(sum(nst(bb,:,par,nm)))
else
hh(bb)=999.
end if

if (sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm))+sum(cst(bb,:,par,nm))).ne.0 then
ts(bb)=sum(ast(bb,:,par,nm))/(sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm))+sum(cst(bb,:,par,nm)))
else
ts(bb)=999.
end if

if (sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm))).ne.0 then
far(bb)=sum(bst(bb,:,par,nm))/(sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm)))
else
far(bb)=999.
end if

if sum(nst(bb,:,par,nm)).ne.0 then
e(bb)=(sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm)))*(sum(ast(bb,:,par,nm))+sum(cst(bb,:,par,nm)))/sum(nst(bb,:,par,nm))
if (sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm))+sum(cst(bb,:,par,nm))-e(bb)).ne.0 then
ets(bb)=(sum(ast(bb,:,par,nm))-e(bb))/(sum(ast(bb,:,par,nm))+sum(bst(bb,:,par,nm))+sum(cst(bb,:,par,nm))-e(bb))
else
ets(bb)=999.
end if
else
e(bb)=999.
ets(bb)=999.
end if

if ((sum(ast(bb,:,par,nm))+sum(cst(bb,:,par,nm)))*(sum(cst(bb,:,par,nm))+sum(dst(bb,:,par,nm)))+(sum(bst(bb,:,par,nm))+sum(dst(bb,:,par,nm)))*(sum(bst(bb,:,par,nm))+sum(dst(bb,:,par,nm)))).ne.0 then
hss(bb)=(2*(sum(ast(bb,:,par,nm))*sum(dst(bb,:,par,nm))-sum(bst(bb,:,par,nm))*sum(cst(bb,:,par,nm))))/((sum(ast(bb,:,par,nm))+sum(cst(bb,:,par,nm)))*(sum(cst(bb,:,par,nm))+sum(dst(bb,:,par,nm)))+(sum(bst(bb,:,par,nm))+sum(dst(bb,:,par,nm)))*(sum(bst(bb,:,par,nm))+sum(dst(bb,:,par,nm))))
else
hss(bb)=999.
end if

if sum(timesrmsest(bb,:,par,nm)).ne.0 then
rmse(bb)=sqrt(sum(srmsest(bb,:,par,nm))/sum(timesrmsest(bb,:,par,nm)))
else
rmse(bb)=999.
end if

do stpa=0,7
if stpa.eq.0 then
plotvar(stpa,par,nm,bb)=bias(bb)
else if stpa.eq.1 then
plotvar(stpa,par,nm,bb)=rmse(bb)
else if stpa.eq.2 then
plotvar(stpa,par,nm,bb)=ets(bb)
else if stpa.eq.3 then
plotvar(stpa,par,nm,bb)=hss(bb)
else if stpa.eq.4 then
plotvar(stpa,par,nm,bb)=pod(bb)
else if stpa.eq.5 then
plotvar(stpa,par,nm,bb)=hh(bb)
else if stpa.eq.6 then
plotvar(stpa,par,nm,bb)=ts(bb)
else if stpa.eq.7 then
plotvar(stpa,par,nm,bb)=far(bb)
end if
end if
end if
end if
end if
end if
end if
end if
end do

delete(alist)
delete(hlist)

header = (/"BIN    PARAMETER       BIAS       RMSE     ETS       HSS       POD         H        TS          FAR            a          b          c        d         n"/)
hlist = [/header/]

alist = [/numbins(bb),PARAMETER(par)+"_MOD_"+snm, bias(bb), rmse(bb), ets(bb), hss(bb), pod(bb), hh(bb), ts(bb), far(bb),sum(ast(bb,:,par,nm)),sum(bst(bb,:,par,nm)),sum(cst(bb,:,par,nm)),sum(dst(bb,:,par,nm)),sum(nst(bb,:,par,nm))/]

end do
end do
end do

do par=0,npar-1
do nm=0,nmodels-1
load "./DIAGRAMS.ncl"
end do
end do

end do
end
