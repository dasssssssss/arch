#!/bin/bash
#ARCHLINUX INSTALLATION SCRIPT

#system clock
timedatectl set-ntp true

#partitions
fdisk -l
echo "Enter a partition to install ArchLinux on: /dev/sd"
read partition
fdisk /dev/sd$partition
#then create partition manually

#format the created partition
mkfs.ext4 /dev/sd${partition}1

#mount the file system
mount /dev/sd${partition}1 /mnt

#generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

#install the base packages and custom packages
pacstrap /mnt base linux linux-firmware dhclient dialog dnsutils nmap openvpn sudo wget nano vim

chmod 777 ~/arch/*.sh
cp ~/arch/* /mnt/

#change root
arch-chroot /mnt





