
## should be 4 for 32bit and 8 for 64bit
puts [format "pointer size is: %s" [set tcl_platform(pointerSize)]]

## should load (more tests needed)
puts [package require Tktable]
puts [package require BWidget]

## test with loon
lappend auto_path C:/Tclbuild/loon_for_testing
package require loon
namespace import loon::*

# extract variables
dict for {name value} $loon::data::olive {set $name $value}

set p [plot -x $oleic -y $stearic -color $Area -xlabel oleic -ylabel stearic]

set h [histogram -x $oleic -xlabel oleic]

set Area [dict get $loon::data::olive Area]; puts "create Area variable"
set oliveacids [dict filter $loon::data::olive script {key value} {
    expr {$key ni {Area Region}}
}]; puts "filter data"

set s [serialaxes -data $oliveacids -color $Area -title "olive data"]
