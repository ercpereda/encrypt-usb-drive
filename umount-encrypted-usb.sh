#!/bin/bash

name=$1

umount /mnt/$name
cryptsetup luksClose $name
