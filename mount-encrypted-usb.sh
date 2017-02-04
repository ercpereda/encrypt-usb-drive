#!/bin/bash

drive=$1
name=$2

cryptsetup luksOpen /dev/$drive $name
mount -t ext4 /dev/mapper/$name /mnt/$name
