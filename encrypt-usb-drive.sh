#!/bin/bash

drive=$1
sectors=$(cat /sys/block/$drive/size)
bs=$(cat /sys/block/$drive/queue/logical_block_size)

echo "Wipe the device with random data."
dd if=/dev/urandom of=/dev/$drive bs=$bs count=$sectors status='progress'

echo "Create a partition"
(echo "unit: sectors" && echo "/dev/$drive : start=2048, id=83") | sfdisk /dev/$drive

echo "Encripting the partition and making LUKS-compatible"
cryptsetup -c aes-xts-plain -y -s 512 luksFormat /dev/$drive

echo "Opening the partition with LUKS"
cryptsetup luksOpen /dev/$drive privateusb

echo "Formatting the partition"
mkfs.ext4 /dev/mapper/privateusb

echo "Closing the partition with LUKS"
cryptsetup luksClose /dev/mapper/privateusb
