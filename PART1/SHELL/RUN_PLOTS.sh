export LOCAL=path-to-SCRIPTS
cd $LOCAL
export NCARG_ROOT=/usr/share/ncl_ncarg-6.1.2
export NCL=$NCARG_ROOT/bin/ncl
export PLOT1=$LOCAL/PLOT_T850_DIFF.ncl
export PLOT2=$LOCAL/PLOT_PREC_PROB.ncl
export PLOT3=$LOCAL/PLOT_T850_QUAL_DIFF.ncl
export PLOT4=$LOCAL/PLOT_SPAGHETTI.ncl
export PLOT5=$LOCAL/PLOT_WIND850.ncl

for ii in {0..1} {11..11}
do
export CLIMONTH=$ii
$NCL < $PLOT1
$NCL < $PLOT2 
$NCL < $PLOT3
$NCL < $PLOT4 
$NCL < $PLOT5

done
