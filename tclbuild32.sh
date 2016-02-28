

## Compile 32 bit Tcl and Tk

unzip="/c/Rtools/bin/unzip"

tclbuild=/c/Tclbuild/Tcl32
final_builds="/c/Tclbuild/final_builds"


mkdir build32

$unzip tcl864-src.zip -d build32
$unzip tk864-src.zip -d build32

export PATH=/usr/local/bin:/c/Rtools/mingw_32/bin/:/bin/

## tcl
cd /c/Tclbuild/build32/tcl8.6.4/win

./configure --prefix=$tclbuild  --enable-threads

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
