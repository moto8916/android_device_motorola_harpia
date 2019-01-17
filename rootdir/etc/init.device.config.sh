#!/vendor/bin/sh

# Copyright (c) 2019 Sultan Qasim Khan
#
# Device configuration for harpia variants
#
PATH=/sbin:/vendor/sbin:/vendor/bin:/vendor/xbin
export PATH

sku=`getprop ro.boot.hardware.sku`
msim=`getprop ro.boot.dualsim`
ram=`cat /sys/ram/size`

set_config_props ()
{
    if [ $msim -eq "true" ]
    then
        setprop ro.device.dualsim true
    else
        setprop ro.device.dualsim false
    fi
}

set_dalvik_props ()
{
    case $ram in
        # 1GB
        1024 )
            setprop dalvik.vm.heapstartsize "8m"
            setprop dalvik.vm.heapgrowthlimit "96m"
            setprop dalvik.vm.heapsize "256m"
            setprop dalvik.vm.heaptargetutilization "0.75"
            setprop dalvik.vm.heapminfree "2m"
            setprop dalvik.vm.heapmaxfree "8m"
        ;;
        # 2GB
        * )
            setprop dalvik.vm.heapstartsize "8m"
            setprop dalvik.vm.heapgrowthlimit "192m"
            setprop dalvik.vm.heapsize "512m"
            setprop dalvik.vm.heaptargetutilization "0.75"
            setprop dalvik.vm.heapminfree "512k"
            setprop dalvik.vm.heapmaxfree "8m"
        ;;
    esac
}

# Main
set_dalvik_props
set_config_props

return 0
