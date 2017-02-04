#!/bin/bash

drive=$1
name=$2
directory="/mnt/$name"

cryptsetup luksOpen /dev/$drive $name

if [ ! -d "$directory" ]; then
  mkdir "$directory"
fi
mount -t ext4 /dev/mapper/$name "$directory"
