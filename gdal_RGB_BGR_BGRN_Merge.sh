#!/bin/bash


echo "Input File Name:"
read fileName



if [ ! -d ./tar ]
then
mkdir ./tar
fi

if [ ! -d ./rgb ]
then
mkdir ./rgb
fi

if [ ! -d ./bgr ]
then
mkdir ./bgr
fi

if [ ! -d ./bgrn ]
then
mkdir ./bgrn
fi




tar -xvf $fileName.tar.gz

gdal_merge.py -co "PHTOMETRIC=rgb" -separate $fileName'_B4.TIF' $fileName'_B3.TIF' $fileName'_B2.TIF'  -o rgb/$fileName'_RGB.TIF'

gdal_merge.py -co "PHTOMETRIC=bgr" -separate $fileName'_B2.TIF' $fileName'_B3.TIF' $fileName'_B3.TIF'  -o bgr/$fileName'_BGR.TIF'

gdal_merge.py -co "PHTOMETRIC=bgrn" -separate $fileName'_B2.TIF' $fileName'_B3.TIF' $fileName'_B4.TIF' $fileName'_B5.TIF'  -o bgrn/$fileName'_BGRN.TIF'

rm ./*.TIF ./*.txt

mv $fileName'.tar.gz' ./tar/


