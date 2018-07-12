#!/bin/bash

echo "Input File Name:"
read fileName

gdalwarp -srcnodata 0 -dstnodata 0 -co "PHOTOMETRIC=rgb" -co "ALPHA=YES" -co "INTERLEAVE=BAND" ./*.TIF $fileName'_ORIGINAL.tif'

gdalbuildvrt $fileName'.vrt' $fileName'_ORIGINAL.tif'

cp $fileName'_ORIGINAL.tif' $fileName'_STRECTCH.tif'

gdal_contrast_stretch -ndv 0 -outndv 255 -percentile-range 0.02 0.98 $fileName'.vrt' $fileName'_STRECTCH.tif'

gdalwarp -t_srs EPSG:3857 $fileName'_ORIGINAL.tif' $fileName'_ORI_3857.tif'

gdalwarp -t_srs EPSG:3857 $fileName'_STRECTCH.tif' $fileName'_STRETCH_3857.tif'

gdalwarp -srcnodata 0 -dstnodata 0 -co "PHOTOMETRIC=rgb" -co "ALPHA=YES" -co "INTERLEAVE=BAND" $fileName'_STRETCH_3857.tif' $fileName'_STRETCH_3857_NEAR.tif'

mv ./*.tif ../
mv ./*.vrt ../
