
# Compile Tck and Tk on Windows with msys and gcc from Rtools

This repository contains the build instructions and sources to compile
`Tcl` and `Tk` with the `Bwidget` and `Tktable` extensions.

# Setup

* Download the newest R tools from
[here](https://cran.r-project.org/bin/windows/Rtools/) and install it
under `c:\Rtools`. Read more about gcc 4.9.3
[here](https://github.com/rwinlib/r-base#readme).
* Install msys2 (32bit or 64bit from [here](https://msys2.github.io/))
  and install `make` & `tar` in `msys2` with

        pacman -Sy
        pacman -S make
        pacman -S tar
        pacman -S gettext

* Clone this git repository into 'C:\Tclbuild'


# Compile Tcl and Tk




Run 'msys2_shell.bat' and enter

~~~
cd /c/Tclbuild
./tclbuild.sh
~~~

The logs and builds are then in the `final_build` folder. My builds
can be also found in this build in the `final_build` folder. Running
the `tclbuild.sh` script will delete my build.


You can test the builds by running `wish86.exe` in `Tcl32/bin/` or
`Tcl64/bin` and then by entering

~~~
source C:/Tclbuild/interactive_test_build.tcl
~~~

in the wish console.

# URLs for sources

The sources can be found at the following urls

* [`tcl864-src.zip`](https://www.tcl.tk/software/tcltk/download.html) ([direct link](http://prdownloads.sourceforge.net/tcl/tcl864-src.zip))
* [`tk864-src.zip`](https://www.tcl.tk/software/tcltk/download.html) ([direct link](http://prdownloads.sourceforge.net/tcl/tk864-src.zip))
* [`bwidget-1.9.9.zip`](http://sourceforge.net/projects/tcllib/files/BWidget/)
* [`tktable-tktable.tar.gz`](http://tktable.cvs.sourceforge.net/viewvc/tktable/tktable/)([direct link](http://tktable.cvs.sourceforge.net/viewvc/tktable/tktable/?view=tar)). Note that
this is from the cvs repository and version 2.11. The stable build
is 2.10 but ActiveTcl also ships with 2.11 (although I am not sure
which commit).
