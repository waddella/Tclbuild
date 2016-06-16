#!/bin/bash

#############################
# Compile 64 bit tcl and tk
#############################


unzip="/c/Rtools/bin/unzip"

tclbuild="/c/Tclbuild/Tcl64"

bindir="${tclbuild}/bin64"
libdir="${tclbuild}/lib64"

final_builds="/c/Tclbuild/final_builds"


mkdir build64

$unzip tcl864-src.zip -d build64
$unzip tk864-src.zip -d build64

export PATH=/usr/local/bin:/c/Rtools/mingw_64/bin/:/bin/

## tcl
cd /c/Tclbuild/build64/tcl8.6.4/win

./configure --prefix=$tclbuild --enable-64bit --enable-threads --bindir=$bindir --libdir=$libdir

make
make test > test64_tcl.log
make install


## tk
cd /c/Tclbuild/build64/tk8.6.4/win
./configure --prefix=$tclbuild --with-tcl=$libdir --enable-64bit --enable-threads --bindir=$bindir --libdir=$libdir
make
make install

# necessary to run tests
export PATH=$PATH:$bindir
make test > test64_tk.log
export PATH=/usr/local/bin:/c/Rtools/mingw_64/bin/:/bin/

## bwidget
cd /c/Tclbuild
bwlib="${tclbuild}/lib"
$unzip bwidget-1.9.9.zip -d $bwlib
mv "${bwlib}/bwidget-1.9.9" "${bwlib}/BWidget"


## tktable
tar -zxvf tktable-tktable.tar.gz --directory build64
cd /c/Tclbuild/build64/tktable
./configure --prefix=$libdir --with-tcl=$libdir --with-tk=$libdir --enable-64bit --libdir=$libdir
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
