#!/bin/sh
set -x

init=GFS:2015-08-17_00

sst96=SST:1996-0
sst96_2d=SST:1996-
sst13=SST:2016-0
sst13_2d=SST:2016-
sst14=SST:2016-0
sst14_2d=SST:2016-
gfs13=GFS:2016-0
gfs13_2d=GFS:2016-
gfs14=GFS:2016-0
gfs14_2d=GFS:2016-
tel=_00


for j in {1..8}  # For more simple debugging run the script 2 times. Rerun with 2016->2015 for j in {9..12}
do

if (( $j == 1 ))
then
for i in {1..17}
do
k=`expr $i + 14`
echo $k

ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel" 

done

for i in 0{1..9} {10..14}
do
k=`expr $i `
kk=15
echo $k
ln -sf "$sst96"$j"-"$kk"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi

if (( $j == 2 ))
then
for i in 0{1..9} {10..28}
do  
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi

if (( $j == 3 ))
then
for i in 0{1..9} {10..31}
do  
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi

if (( $j == 4 ))
then
for i in 0{1..9} {10..30}
do  
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi

if (( $j == 5 ))
then
for i in 0{1..9} {10..31}
do  
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi

if (( $j == 6 ))
then
for i in 0{1..9} {10..30}
do  
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi

if (( $j == 7 ))
then
for i in 0{1..9} {10..31}
do  
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"

done
fi


if (( $j == 8 ))
then
for i in 0{1..9} {10..31}
do
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"
ln -sf "$sst96"$j"-"$k"$tel" "$sst13"$j"-"$k"$tel"
ln -sf  "$init" "$gfs13"$j"-"$k"$tel"

done
fi


if (( $j == 9 ))
then
for i in 0{1..9} {10..30}
do
k=`expr $i `
echo $k
ln -sf "$sst96"$j"-"$k"$tel" "$sst14"$j"-"$k"$tel"
ln -sf  "$init" "$gfs14"$j"-"$k"$tel"
ln -sf "$sst96"$j"-"$k"$tel" "$sst13"$j"-"$k"$tel"
ln -sf  "$init" "$gfs13"$j"-"$k"$tel"

done
fi

if (( $j == 10 ))
then
for i in 0{1..9} {10..31}
do  
k=`expr $i `
echo $k
ln -sf "$sst96_2d"$j"-"$k"$tel" "$sst13_2d"$j"-"$k"$tel"
ln -sf  "$init" "$gfs13_2d"$j"-"$k"$tel"

done
fi

if (( $j == 11 ))
then
for i in 0{1..9} {10..30}
do  
k=`expr $i `
echo $k
ln -sf "$sst96_2d"$j"-"$k"$tel" "$sst13_2d"$j"-"$k"$tel"
ln -sf  "$init" "$gfs13_2d"$j"-"$k"$tel"

done
fi

if (( $j == 12 ))
then
for i in 0{1..9} {10..15}
do  
k=`expr $i `
echo $k
ln -sf "$sst96_2d"$j"-"$k"$tel" "$sst13_2d"$j"-"$k"$tel"
ln -sf  "$init" "$gfs13_2d"$j"-"$k"$tel"

done

for i in 0{1..9} {10..17}
do
k=`expr $i + 14`
kk=15
echo $k
ln -sf "$sst96_2d"$j"-"$kk"$tel" "$sst13_2d"$j"-"$k"$tel"
ln -sf  "$init" "$gfs13_2d"$j"-"$k"$tel"

done

fi
done
