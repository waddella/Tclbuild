#!/bin/bash


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
for folder in Tcl Tcl32 Tcl64 build32 build64 final_builds
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


mkdir final_builds


## time the build
start32=`date +%s`

./tclbuild32.sh

start64=`date +%s`

./tclbuild64.sh

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
