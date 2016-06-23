
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

After running the build script there will be a couple outputs

* Logs and builds (archived and compressed: `Tcl32.zip` and
`Tcl64.zip`) are in the `final_build` folder.
* The `Tcl32` and `Tcl64` folders are the final builds (that get
  compressed as mentioned in the above point)

Note that running the `tclbuild.sh` script will delete the files in
`final_build`.

## Test your Tcl/Tk build

You can test the builds by running `wish86.exe` (wish console)

* `C:/Tclbuild/Tcl32/bin/wish86.exe` and enter

        source C:/Tclbuild/interactive_test_build.tcl

* `C:/Tclbuild/Tcl64/bin/wish86.exe` and enter

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
