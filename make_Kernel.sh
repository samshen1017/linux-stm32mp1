#!/bin/bash

KERNEL_DIR=$PWD/linux-5.15.67
ENV_SET=/home/isaac/toolchain/st/stm32mp1/4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

cd $KERNEL_DIR

#设置编译器
source $ENV_SET

if [ $1 == "astro" ]; then
    unset -v CFLAGS LDFLAGS
    make ARCH=arm CROSS_COMPILE=arm-ostl-linux-gnueabi- O="$PWD/../build" stm32mp157c-astro_defconfig
    make ARCH=arm CROSS_COMPILE=arm-ostl-linux-gnueabi- O="$PWD/../build" uImage dtbs modules LOADADDR=0XC2000040 -j12

elif [ $1 == "copy" ]; then
    cp $PWD/../build/arch/arm/boot/uImage ../../image
    cp $PWD/../build/arch/arm/boot/dts/stm32mp157c-astro.dtb ../../image

elif [ $1 == "clean" ]; then
    make ARCH=arm CROSS_COMPILE=arm-ostl-linux-gnueabi- O="$PWD/../build" distclean
    rm -rf $PWD/../build
    rm -rf $PWD/../deploy
fi

