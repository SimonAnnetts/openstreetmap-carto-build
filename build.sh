#!/bin/bash

mkdir -p backups/ 2>/dev/null

exec > >(awk '{print strftime("%Y-%m-%d %H:%M:%S [1] "),$0; fflush();}')
exec 2> >(awk '{print strftime("%Y-%m-%d %H:%M:%S [2] "),$0; fflush();}' >&2)

starttime=$(date +%s)
startdate=$(date "+%Y-%m-%d_%H%M%S")

echo "Backing up existing files..."
for i in *.mml; do 
    cp -v ${i} backups/${i%.*}_${startdate}.mml 2>/dev/null
done
for i in *.xml; do 
    cp -v ${i} backups/${i%.*}_${startdate}.xml 2>/dev/null
done
for i in *.mss; do 
    cp -v ${i} backups/${i%.*}_${startdate}.mss 2>/dev/null
done

echo "Attempting to get latest release of openstreetmap-carto..."
url=$(lynx -listonly -nonumbers -dump "https://github.com/gravitystorm/openstreetmap-carto/releases" |grep "archive" |grep "tar.gz" |head -n1)
filename=${url##*/}
if [ -n "${filename}" ]; then
    wget -O ${filename} -o /dev/null "${url}"
    [ $? -ne 0 ] && echo "Could not download the latest openstreetmap-carto release from ${url}!" && exit 1
else
    echo "Could not find a link to the latest openstreetmap-carto release!" && exit 1
fi

echo "Extracting the release archive..."
mkdir tmp 2>/dev/null
tar -zxC tmp -f ${filename}
[ $? -ne 0 ] && echo "Could not extract the latest openstreetmap-carto release!" && exit 1
mkdir ../openstreetmap-carto/ 2>/dev/null
rm -Rf ../openstreetmap-carto/scripts 2>/dev/null
rm -Rf ../openstreetmap-carto/symbols 2>/dev/null
mv -f tmp/*/* ../openstreetmap-carto/ 2>/dev/null
rm -Rf tmp

echo "Applying patches...."
cp -f ../openstreetmap-carto/roads.mss roads-OS.mss && \
patch -p0 -i roads-OS.patch && \
cp -f ../openstreetmap-carto/water.mss water-OS.mss && \
patch -p0 -i water-OS.patch && \
cp -f ../openstreetmap-carto/fonts.mss fonts.mss && \
patch -p0 -i fonts.patch && \
cp -f ../openstreetmap-carto/style.mss style-OS.mss && \
patch -p0 -i style-OS.patch && \
cp -f ../openstreetmap-carto/project.mml esdm-uncontoured.mml && \
patch -p0 -i esdm-uncontoured.patch && \
cp -f esdm-uncontoured.mml esdm-contoured.mml && \
patch -p0 -i esdm-contoured.patch && \
cp -f esdm-uncontoured.mml esdm-27700-uncontoured.mml && \
patch -p0 -i esdm-27700-uncontoured.patch && \
cp -f esdm-contoured.mml esdm-27700-contoured.mml && \
patch -p0 -i esdm-27700-contoured.patch
[ $? -ne 0 ] && echo "Failed!!" && exit 1

echo "Copying patched files to openstreetmap-carto release directory..."
mkdir ../openstreetmap-carto/esdm 2>/dev/null
cp -f *.mss ../openstreetmap-carto/esdm/
cp -f *.mml ../openstreetmap-carto/
ln -s ../../osm-contours ../openstreetmap-carto/esdm/osm-contours 2>/dev/null

echo "Checking if world boundary shapefiles are present..."
cd ../openstreetmap-carto
if [ ! -d data/world_boundaries ]; then
    ./scripts/get-shapefiles.py
    [ $? -ne 0 ] && echo "Could not get world shapefiles!" && exit 1
    rm -f data/*.zip
    rm -f data/*.tar.gz
fi

echo "Building style files using carto..."
carto esdm-uncontoured.mml >esdm-uncontoured.xml 
[ $? -ne 0 ] && echo "Build failed for esdm-uncontoured.mml !" && exit 1
carto esdm-contoured.mml >esdm-contoured.xml
[ $? -ne 0 ] && echo "Build failed for esdm-contoured.mml !" && exit 1
carto esdm-27700-uncontoured.mml >esdm-27700-uncontoured.xml
[ $? -ne 0 ] && echo "Build failed for esdm-27700-uncontoured.mml !" && exit 1
carto esdm-27700-contoured.mml >esdm-27700-contoured.xml
[ $? -ne 0 ] && echo "Build failed for esdm-27700-contoured.mml !" && exit 1


echo "Building default style file using carto..."
carto project.mml >project.xml
[ $? -ne 0 ] && echo "Build failed for project.mml !" && exit 1

cp -f *.xml ../openstreetmap-carto-build/

endtime=$(date +%s)
echo "Done in $[${endtime}-${starttime}] seconds! All your Maps Belong to Us!"
