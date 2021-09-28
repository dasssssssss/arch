#set the time zone
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc

#localization
read -p "Uncomment en_US.UTF-8 UTF-8 and other needed locales. Press ENTER to continue..."
nano /etc/locale.gen
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

#exit
#umount -R /mnt
#reboot
