#!/bin/bash
#set -x

export RUNDIR=path-to-RUNDIR
export UPPDIR=path-to-UPPDIR
export POSTDIR=path-to-POSTDIR
export runid=$1
export NCARG_ROOT=/usr/share/ncl_ncarg-6.1.2
export NCL=$NCARG_ROOT/bin/ncl
export CHANGES=$RUNDIR/CHANGES.ncl
export STORE=path-to-STORE

cd $RUNDIR
cp -f namelist.input namelist.input_prev
cp -f namelist.input_$1 namelist.input
date
mpiexec -machinefile $RUNDIR/machs -np 24 $RUNDIR/real.exe
date
sleep 5
cp -f wrfinput_d01 "wrfinput_d01_"$1"_org"
cp -f wrflowinp_d01 "wrflowinp_d01_"$1"_org"
cp -f wrfinput_d02 "wrfinput_d02_"$1"_org"
cp -f wrflowinp_d02 "wrflowinp_d02_"$1"_org"
$NCL dd=1 <  $CHANGES
$NCL dd=2 <  $CHANGES
cp -f wrfinput_d01 "wrfinput_d01_"$1
cp -f wrflowinp_d01 "wrflowinp_d01_"$1
cp -f wrfinput_d02 "wrfinput_d02_"$1
cp -f wrflowinp_d02 "wrflowinp_d02_"$1
sleep 5
date
mpiexec -machinefile $RUNDIR/machs -np 24 $RUNDIR/wrf.exe
date
sleep 5
cd $UPPDIR
./run_unipost.global $1
date
sleep 5
cd $STORE/WRFREAL
mkdir 201508$1
cd $STORE/WRFPRS
mkdir 201508$1
cd $RUNDIR
mv -f wrfinput_d01 wrflowinp_d01 wrfinput_d02 wrflowinp_d02 $STORE"/WRFREAL/201508"$1"/"
cp -f namelist.input $STORE"/WRFREAL/201508"$1"/"
cd $POSTDIR
rm -f unipost*
mv -f WRFPRS* $STORE"/WRFPRS/201508"$1"/"
date
