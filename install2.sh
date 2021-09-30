pacman -Sy

#set the time zone
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc

#localization
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

#network configuration
#echo "Enter a hostname: "
#read varhostname
#echo $varhostname > /etc/hostname
echo desktop > /etc/hostname

echo "127.0.0.1	localhost" > /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	desktop.localdomain desktop " >> /etc/hosts

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
#echo "NEW USER"
#echo "Username: "
#read username
#useradd -m $username
useradd -m sam
passwd sam
usermod --append --groups wheel sam
echo "Uncomment %wheel ALL=(ALL) ALL"
visudo

#copy files
cp .fehbg /home/sam/
cp .xinitrc /home/sam/
cp .Xresources /home/sam/
cp display.sh /home/sam/
cp vpn.sh /home/sam/
mkdir /home/sam/.config
mkdir /home/sam/.config/i3
cp i3config /home/sam/.config/i3/
mv /home/sam/.config/i3/i3config /home/sam/.config/i3/config
mkdir /home/sam/protonvpn
cp nl.protonvpn.com.udp.ovpn /home/sam/protonvpn/
cp install3.sh /home/sam/

cd /
rm -R arch

echo "exit"
echo "umount -R /mnt"
echo "reboot"

