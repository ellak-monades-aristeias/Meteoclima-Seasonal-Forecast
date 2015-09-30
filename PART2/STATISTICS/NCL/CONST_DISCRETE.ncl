nmodels=1
npar=1
nthres=6
initthres=0.5

nss=1
nse=1
NaN="-999"

obotw=0
mbotw=0
otopw=1000
mtopw=1000
obott=0
mbott=0
otopt=60
mtopt=60
obotm=0
mbotm=0
otopm=60
mtopm=60

thres=new((/npar,nthres/),float)

do par=0,npar-1
do nth=0,nthres-1

thres(par,0)=10
thres(par,1)=20
thres(par,2)=40
thres(par,3)=80
thres(par,4)=120
thres(par,5)=200

end do
end do

PARAMETER=new((/1/),string)
PARAMETER(0)="RAIN"
