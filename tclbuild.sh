#!/bin/bash


## time the build
start32=`date +%s`

if [ "$1" == "reset" ]
then
    git reset --hard HEAD
fi


if [ "$PWD" != "/c/Tclbuild" ] 
then
    echo "Please run the current script in /c/Tclbuild!"
    exit
fi

# Delete old build files
for folder in Tcl32 Tcl64 build32 build64 final_builds
do
    if [ -d "$folder" ] 
    then 
        echo "You already have the $folder folder, should it be deleted [Y n]?"
        read X
        if [ "$X" != "n" ] || [ "$X" != "N" ] 
        then
            rm -fR $folder
        else
            echo "Progam exited!"
            exit
        fi
    fi
done


if [ ! -d  C:/Rtools ] 
then
    echo "C:/Rtools does not exist, please install Rtools under C:/Rtools"
    exit
fi


for archive in tcl864-src.zip tk864-src.zip bwidget-1.9.9.zip tktable-tktable.tar.gz
do
    if [ ! -f $archive ]
    then
        echo "file $archive is missing run: git reset --hard HEAD (careful!)"
        exit
    fi
done




## programs
unzip="/c/Rtools/bin/unzip"

mkdir final_builds
final_builds="/c/Tclbuild/final_builds"

## Compile 32 bit Tcl and Tk
tclbuild=/c/Tclbuild/Tcl32

mkdir build32

$unzip tcl864-src.zip -d build32
$unzip tk864-src.zip -d build32

export PATH=/usr/local/bin:/c/Rtools/mingw_32/bin/:/bin/

## tcl
cd /c/Tclbuild/build32/tcl8.6.4/win

./configure --prefix=/c/Tclbuild/Tcl32  --enable-threads

make
make test > test32_tcl.log
make install


## tk
cd /c/Tclbuild/build32/tk8.6.4/win
./configure --prefix=$tclbuild --with-tcl="${tclbuild}/lib" --enable-threads
make
make install

# necessary to run tests
export PATH=$PATH:${tclbuild}/bin
make test > test32_tk.log
export PATH=/usr/local/bin:/c/Rtools/mingw_32/bin/:/bin/

## bwidget
cd /c/Tclbuild
$unzip bwidget-1.9.9.zip -d "${tclbuild}/lib"
mv "${tclbuild}/lib/bwidget-1.9.9" "${tclbuild}/lib/BWidget"


## tktable
tar -zxvf tktable-tktable.tar.gz --directory build32
cd /c/Tclbuild/build32/tktable
./configure --prefix="${tclbuild}/lib" --with-tcl="${tclbuild}/lib" --with-tk="${tclbuild}/lib"
make
make test > test32_tktable.log
make install


## copy logs
cp /c/Tclbuild/build32/tcl8.6.4/win/test32_tcl.log $final_builds
cp /c/Tclbuild/build32/tcl8.6.4/win/config.log "${final_builds}/config32_tcl.log"
cp /c/Tclbuild/build32/tk8.6.4/win/test32_tk.log $final_builds
cp /c/Tclbuild/build32/tk8.6.4/win/config.log "${final_builds}/config32_tk.log"
cp /c/Tclbuild/build32/tktable/test32_tktable.log $final_builds
cp /c/Tclbuild/build32/tktable/config.log "${final_builds}/config32_tktable.log"


cd /c/Tclbuild
/c/Rtools/bin/zip -r "${final_builds}/Tcl32.zip" Tcl32

start64=`date +%s`


#############################
# Compile 64 bit tcl and tk
#############################

tclbuild=/c/Tclbuild/Tcl64

mkdir build64

$unzip tcl864-src.zip -d build64
$unzip tk864-src.zip -d build64

export PATH=/usr/local/bin:/c/Rtools/mingw_64/bin/:/bin/

## tcl
cd /c/Tclbuild/build64/tcl8.6.4/win

./configure --prefix=/c/Tclbuild/Tcl64 --enable-64bit --enable-threads

make
make test > test64_tcl.log
make install


## tk
cd /c/Tclbuild/build64/tk8.6.4/win
./configure --prefix=$tclbuild --with-tcl="${tclbuild}/lib" --enable-64bit --enable-threads
make
make install

# necessary to run tests
export PATH=$PATH:${tclbuild}/bin
make test > test64_tk.log
export PATH=/usr/local/bin:/c/Rtools/mingw_64/bin/:/bin/

## bwidget
cd /c/Tclbuild
$unzip bwidget-1.9.9.zip -d "${tclbuild}/lib"
mv "${tclbuild}/lib/bwidget-1.9.9" "${tclbuild}/lib/BWidget"


## tktable
tar -zxvf tktable-tktable.tar.gz --directory build64
cd /c/Tclbuild/build64/tktable
./configure --prefix="${tclbuild}/lib" --with-tcl="${tclbuild}/lib" --with-tk="${tclbuild}/lib"
make
make test > test64_tktable.log
make install


## copy logs
cp /c/Tclbuild/build64/tcl8.6.4/win/test64_tcl.log $final_builds
cp /c/Tclbuild/build64/tcl8.6.4/win/config.log "${final_builds}/config64_tcl.log"
cp /c/Tclbuild/build64/tk8.6.4/win/test64_tk.log $final_builds
cp /c/Tclbuild/build64/tk8.6.4/win/config.log "${final_builds}/config64_tk.log"
cp /c/Tclbuild/build64/tktable/test64_tktable.log $final_builds
cp /c/Tclbuild/build64/tktable/config.log "${final_builds}/config64_tktable.log"


cd /c/Tclbuild
/c/Rtools/bin/zip -r "${final_builds}/Tcl64.zip" Tcl64

end=`date +%s`


bt32=$((start64-start32))
bt64=$((end-star64))

echo "build time for 32bit is $bt32 and for 64bit is $bt64"

#spmin=60.0
#buildtimem=$(($buildtime/spm))

#echo "64 bit build took $buildtimem minutes"

echo "Done!"

echo "open the respective wish86.exe in Tcl32/bin and Tcl63/bin and run"
echo "  source C:/Tclbuild/interactive_test_build.tcl"
