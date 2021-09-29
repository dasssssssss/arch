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
cp -R ~/arch /mnt/

#change root
arch-chroot /mnt

pacman -Sy

#set the time zone
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc

#localization
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

#network configuration
echo "Enter a hostname: "
read varhostname
echo $varhostname > /etc/hostname

echo "127.0.0.1	localhost" > /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	${varhostname}.localdomain $varhostname" >> /etc/hosts

#root password
echo "Enter the root password:"
passwd

#install GRUB
yes | pacman -S grub
fdisk -l
echo "Enter a partition to install GRUB on: /dev/sd"
read partition
grub-install --target=i386-pc /dev/sd$partition
grub-mkconfig -o /boot/grub/grub.cfg

#regular user
echo "NEW USER"
echo "Username: "
read username
useradd -m $username
passwd $username
usermod --append --groups wheel $username
echo "Uncomment %wheel ALL=(ALL) ALL"
visudo

#copy files
cp .fehbg /home/$username/
cp .xinitrc /home/$username/
cp .Xresources /home/$username/
cp display.sh /home/$username/
cp vpn.sh /home/$username/
mkdir /home/$username/.config
mkdir /home/$username/.config/i3
cp i3config /home/$username/.config/i3/
mv /home/$username/.config/i3/i3config /home/$username/.config/i3/config
mkdir /home/$username/protonvpn
cp nl.protonvpn.com.udp.ovpn /home/$username/protonvpn/
cp install3.sh /home/sam/

cd /
rm -R arch

echo "exit"
echo "umount -R /mnt"
echo "reboot"





