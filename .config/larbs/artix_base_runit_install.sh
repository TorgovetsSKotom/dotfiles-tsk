#!/bin/sh

echo "Hostname:"
read hostname
echo "Root password"
read password

#cfdisk /dev/sda
#wait
#
#mkfs.ext4 -L ROOT /dev/sda3
#mkfs.ext4 -L HOME /dev/sda4
#mkswap -L SWAP /dev/sda2
#mkfs.fat -F 32 /dev/sda1
#fatlabel /dev/sda1 ESP
#swapon /dev/disk/by-label/SWAP
#mount /dev/disk/by-label/ROOT /mnt
#mkdir /mnt/home
#mount /dev/disk/by-label/HOME /mnt/home
#mkdir /mnt/boot/efi
#mount /dev/disk/by-label/ESP /mnt/boot/efi
#Обновление системных часов, не работало
#sv up ntpd
#basestrap /mnt base base-devel runit elogind-runit
#basestrap /mnt linux-zen dkms xorg-server linux-firmware amd-ucode neovim
#fstabgen -U /mnt >> /mnt/etc/fstab
#sudo nvim /mnt/etc/fstab
#wait
#Проверьте результативный fstab для ошибок перед перезагрузкой. Теперь, вы можете порезать в свою новую систему Artix с:
#artix-chroot /mnt
#pacman -S grub efibootmgr
#grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
#grub-mkconfig -o /boot/grub/grub.cfg
#echo "GRUB_TIMEOUT=0" > /etc/default/grub
#chpasswd root


pacman -Syyuu
pacman -S connman-runit bluez-runit openvpn-runit neovim git
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
#nvim /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.gen
echo "LANG=ru_RU.UTF-8" >> /etc/locale.gen
locale-gen
# nvim /etc/vconsole.conf
echo "KEYMAP=ruwin_cplk-UTF-8
FONT=cyr-sun16" >> /etc/vconsole.conf
export LANG="en_US.UTF-8"
export LC_COLLATE="C"
#useradd -mU -s /usr/bin/zsh -G wheel,uucp,video,audio,storage,games,input "$user"
#/mnt chsh -s /usr/bin/zsh
#echo "$user:$password" | chpasswd
echo "root:$password" | chpasswd

echo "$myhostname" > /etc/hostname
echo "127.0.0.1        localhost
 ::1              localhost
 127.0.1.1        $myhostname.localdomain  $myhostname" >> /etc/hosts
pacman -S dhcpcd 
#pacman -S wpa_supplicant

pacman -S connman-runit
ln -s /etc/runit/sv/connmand /etc/runit/runsvdir/default


#sudo pacman -S --needed base-devel
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si
#paru -Sy nvidia-470xx-dkms nvidia-470xx-settings nvidia-470xx-utils lib32-nvidia-470xx-utils
