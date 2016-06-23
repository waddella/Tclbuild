
# Compile Tck and Tk on Windows with msys and gcc from Rtools

This repository contains the build instructions and sources to compile
`Tcl` and `Tk` with the `Bwidget` and `Tktable` extensions.

# Setup

* Download the newest R tools from
[here](https://cloud.r-project.org/bin/windows/Rtools/) and install it
under `c:\Rtools`.
* Clone this git repository into 'C:\Tclbuild'
* Install msys v1 (which comes bundled with mingw) from
  [here](http://www.mingw.org/). Install it under `C:/MinGW/`.

# Compile Tcl and Tk

Start a msys terminal by running `C:/MinGW/msys/1.0/msys.bat` and
enter

~~~
cd /c/Tclbuild
./tclbuild.sh
~~~

The logs and builds are then in the `final_build` folder. If you are
not able to follow these compile instructions then you can also find
my builds on github in the `final_build` folder (`Tcl32.zip` and
`Tcl64.zip`). Note that running the `tclbuild.sh` script will delete
my build.


## Test your Tcl/Tk build

You can test the builds by running `wish86.exe` (wish console) in

* `Tcl32/bin/`

        source C:/Tclbuild/interactive_test_build.tcl

* `Tcl64/bin`

        set auto_path [concat C:/Tclbuild/Tcl64/lib64 $auto_path]
        source C:/Tclbuild/interactive_test_build.tcl

The `auto_path` issue for the 64bit build gets resolved when compiling
`R` with this `Tcl/Tk` build on Windows.


# URLs for sources

The sources can be found at the following urls

* [`tcl864-src.zip`](https://www.tcl.tk/software/tcltk/download.html) ([direct link](http://prdownloads.sourceforge.net/tcl/tcl864-src.zip))
* [`tk864-src.zip`](https://www.tcl.tk/software/tcltk/download.html) ([direct link](http://prdownloads.sourceforge.net/tcl/tk864-src.zip))
* [`bwidget-1.9.9.zip`](http://sourceforge.net/projects/tcllib/files/BWidget/)
* [`tktable-tktable.tar.gz`](http://tktable.cvs.sourceforge.net/viewvc/tktable/tktable/)([direct link](http://tktable.cvs.sourceforge.net/viewvc/tktable/tktable/?view=tar)). Note that
this is from the cvs repository and version 2.11. The stable build
is 2.10 but ActiveTcl also ships with 2.11 (although I am not sure
which commit).
