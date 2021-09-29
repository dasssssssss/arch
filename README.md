pacman -Syy && pacman -S git
git clone https://github.com/dasssssssss/arch
cd arch && chmod 777 install.sh && ./install.sh

cd arch && ./install2.sh
exit
umount -R /mnt && reboot

./install3.sh
