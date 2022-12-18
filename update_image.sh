#!/bin/sh

sudo dd if=output/images/u-boot-sunxi-with-spl.bin of=/dev/sdc bs=1024 seek=8
sync

sudo cp output/images/zImage /media/iron/BOOT/
sudo cp output/images/*.dtb /media/iron/BOOT/
sync


sudo rm -rf /media/iron/rootfs/*
sudo tar -xvf output/images/rootfs.tar -C /media/iron/rootfs/
sync

echo "======================================================"
echo "--------------------update success!-------------------"
echo "======================================================"



