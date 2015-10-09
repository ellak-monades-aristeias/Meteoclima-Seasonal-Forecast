export LOCAL=path-to-SCRIPTS
cd $LOCAL
export NCARG_ROOT=/usr/share/ncl_ncarg-6.1.2
export NCL=$NCARG_ROOT/bin/ncl
export EXTR1=$LOCAL/EXTRACT_TEMP_850.ncl
export EXTR2=$LOCAL/EXTRACT_WIND_850.ncl
export EXTR3=$LOCAL/EXTRACT_MSLP.ncl
export EXTR4=$LOCAL/EXTRACT_PREC.ncl

$NCL tmm=0 inithour=0 < $EXTR1 #>&log100&
$NCL tmm=0 inithour=12 < $EXTR1 #>&log1012&
$NCL tmm=1 inithour=0 < $EXTR1 #>&log110&
$NCL tmm=1 inithour=12 < $EXTR1 #>&log1112&
$NCL tmm=2 inithour=0 < $EXTR1 #>&log120&
$NCL tmm=2 inithour=12 < $EXTR1 #>&log1212&

sleep 5m

$NCL tmm=0 inithour=0 < $EXTR2 >&log200&
$NCL tmm=0 inithour=12 < $EXTR2 >&log2012&
$NCL tmm=1 inithour=0 < $EXTR2 >&log210&
$NCL tmm=1 inithour=12 < $EXTR2 >&log2112&
$NCL tmm=2 inithour=0 < $EXTR2 >&log220&
$NCL tmm=2 inithour=12 < $EXTR2 >&log2212&

sleep 5m

$NCL tmm=0 inithour=0 < $EXTR3 #>&log300&
$NCL tmm=0 inithour=12 < $EXTR3 #>&log3012&
$NCL tmm=1 inithour=0 < $EXTR3 #>&log310&
$NCL tmm=1 inithour=12 < $EXTR3 #>&log3112&
$NCL tmm=2 inithour=0 < $EXTR3 #>&log320&
$NCL tmm=2 inithour=12 < $EXTR3 #>&log3212&

sleep 5m

$NCL tmm=0 inithour=0 < $EXTR4 #>&log400&
$NCL tmm=1 inithour=0 < $EXTR4 #>&log410&
$NCL tmm=2 inithour=0 < $EXTR4 #>&log420&
