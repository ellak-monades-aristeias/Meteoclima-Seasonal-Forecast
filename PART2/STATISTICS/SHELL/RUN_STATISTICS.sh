SPATHDIR="path-to-STATISTICS"

cd $SPATHDIR

ii=1
kk=2
jj=2

ncl stmm=6 stnn=0 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=6 stnn=12 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=6 stnn=24 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=7 stnn=0 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=7 stnn=12 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=7 stnn=24 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=8 stnn=0 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=8 stnn=12 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
ncl stmm=8 stnn=24 STATYPE=$kk RUN=$jj CASESTUDY=$ii CONTINUOUS.ncl
