#!/bin/sh

# Luke's Auto Rice Boostrapping Script (LARBS)
# by Luke Smith <luke@lukesmith.xyz>
# License: GNU GPLv3
# https://github.com/TorgovetsSKotom/dotfiles-tsk/master/.config/larbs/larbs.sh

### ОПЦИИ И ПЕРЕМЕННЫЕ ###

dotfilesrepo="https://github.com/TorgovetsSKotom/dotfiles-tsk.git"
progsfile="https://github.com/TorgovetsSKotom/dotfiles-tsk/master/.config/larbs/progs.csv"
aurhelper="paru"
#repobranch="main"
export TERM=ansi

### ФУНКЦИИ ###

installpkg() {
	pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
}

error() {
	# Log to stderr and exit with failure.
	printf "%s\n" "$1" >&2
	exit 1
}

welcomemsg() {
	whiptail --title "Ха!" \
		--msgbox "Ты реально захотел установить это чудо?!\\n\\nТогда ничего не делай и кайфуй, ща все будет.\\n\\n-Luke" 10 60

	whiptail --title "Важно, слушай!" --yes-button "Йеей!" \
		--no-button "Я возвращаюсь..." \
		--yesno "Обнови систему, если сможешь, значит про ключи тоже не забыл.\\n\\nИначе ошибаться установка будет трижды.. Или тридцативосьмирежды.." 8 70
}

getuserandpass() {
	# Prompts user for new username an password.
	name=$(whiptail --inputbox "Сначала.... Хто ты?." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		name=$(whiptail --nocancel --inputbox "Ты глупенький? Имя должно начинаться со строчной буквы, - или _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	pass1=$(whiptail --nocancel --passwordbox "Защити себя паролем или атакуй вечно." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(whiptail --nocancel --passwordbox "Повтори, я не услышал." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		pass1=$(whiptail --nocancel --passwordbox "Ты лжешь, а я все слышал.\\n\\nПовтори." 10 60 3>&1 1>&2 2>&3 3>&1)
		pass2=$(whiptail --nocancel --passwordbox "Не слышу!!!." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
}

usercheck() {
	! { id -u "$name" >/dev/null 2>&1; } ||
		whiptail --title "ПРЕДУПРЕЖДАЮ" --yes-button "ОКЕЙ" \
			--no-button "Хм..." \
			--yesno "Тебя, \`$name\` я уже знаю. LARBS справится, но перезапишет этот мир. Во славу сатане, конечно же!\\n\\nLARBS уничтожит только миропорядок, не человеков, так что жмите <CONTINUE> во имя сатаны.\\n\\nИ да, пароль учетки $name изменится." 14 70
}

preinstallmsg() {
	whiptail --title "Начнем же Апокалипсис, Армагеддон, Конец света, Рагнарек, Великий суд, Мекке в одмном событии!" --yes-button "Погнали!" \
		--no-button "Остановись!" \
		--yesno "Теперь у тебя есть выбор. Кальян, энергетик, пиво, банальный чай, ведро кофе. Все. Наслаждайся.\\n\\nВ смысле, нет выбора? Не возвражай, я все закончу." 13 60 || {
		clear
		exit 1
	}
}

adduserandpass() {
	# Adds user `$name` with password $pass1.
	whiptail --infobox "Adding user \"$name\"..." 7 50
	useradd -m -g wheel -s /bin/zsh "$name" >/dev/null 2>&1 ||
		usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
	export repodir="/home/$name/.local/src"
	mkdir -p "$repodir"
	chown -R "$name":wheel "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2
}

refreshkeys() {
	case "$(readlink -f /sbin/init)" in
	*systemd*)
		whiptail --infobox "Предоставляем ключи достойным..." 7 40
		pacman --noconfirm -S archlinux-keyring >/dev/null 2>&1
		;;
	*)
		whiptail --infobox "Лезем в Arch Repositories для призыва древних ..." 7 40
		if ! grep -q "^\[universe\]" /etc/pacman.conf; then
			echo "[universe]
Server = https://universe.artixlinux.org/\$arch
Server = https://mirror1.artixlinux.org/universe/\$arch
Server = https://mirror.pascalpuffke.de/artix-universe/\$arch
Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/\$arch
Server = https://mirror1.cl.netactuate.com/artix/universe/\$arch
Server = https://ftp.crifo.org/artix-universe/\$arch
Server = https://artix.sakamoto.pl/universe/\$arch" >>/etc/pacman.conf
			pacman -Sy --noconfirm >/dev/null 2>&1
		fi
		pacman --noconfirm --needed -S \
			artix-keyring artix-archlinux-support >/dev/null 2>&1
		for repo in extra community; do
			grep -q "^\[$repo\]" /etc/pacman.conf ||
				echo "[$repo]
Include = /etc/pacman.d/mirrorlist-arch" >>/etc/pacman.conf
		done
		pacman -Sy >/dev/null 2>&1
		pacman-key --populate archlinux >/dev/null 2>&1
		;;
	esac
}

manualinstall() {
	# Устанавливаем $1 вручную. Сам виноват, что избрал AUR.
	# Запускается после установки репозиториев и установки переменных (не происходит раз в 3000 лет).
	pacman -Qq "$1" && return 0
	whiptail --infobox "Устанавливаем \"$1\" вручную ." 7 50
	sudo -u "$name" mkdir -p "$repodir/$1"
	sudo -u "$name" git -C "$repodir" clone --depth 1 --single-branch \
		--no-tags -q "https://aur.archlinux.org/$1.git" "$repodir/$1" ||
		{
			cd "$repodir/$1" || return 1
			sudo -u "$name" git pull --force origin master
		}
	cd "$repodir/$1" || exit 1
	sudo -u "$name" -D "$repodir/$1" \
		makepkg --noconfirm -si >/dev/null 2>&1 || return 1
}

maininstall() {
	# Installs all needed programs from main repo.
	whiptail --title "А сейчас мы будем устанавливать все" --infobox "Призываем \`$1\` ($n of $total). $1 $2" 9 70
	installpkg "$1"
}

gitmakeinstall() {
	progname="${1##*/}"
	progname="${progname%.git}"
	dir="$repodir/$progname"
	whiptail --title "А сейчас мы будем устанавливать все" \
		--infobox "Ставим на ноги \`$progname\` ($n of $total) через \`git\` и \`make\`. $(basename "$1") $2" 8 70
	sudo -u "$name" git -C "$repodir" clone --depth 1 --single-branch \
		--no-tags -q "$1" "$dir" ||
		{
			cd "$dir" || return 1
			sudo -u "$name" git pull --force origin master
		}
	cd "$dir" || exit 1
	make >/dev/null 2>&1
	make install >/dev/null 2>&1
	cd /tmp || return 1
}

aurinstall() {
	whiptail --title "А сейчас мы будем устанавливать все" \
		--infobox "Собираем по кусочкам \`$1\` ($n of $total) из AUR. $1 $2" 9 70
	echo "$aurinstalled" | grep -q "^$1$" && return 1
	sudo -u "$name" $aurhelper -S --noconfirm "$1" >/dev/null 2>&1
}

pipinstall() {
	whiptail --title "А сейчас мы будем устанавливать все" \
		--infobox "Питона дергали с репов люди. \`$1\` ($n of $total). $1 $2" 9 70
	[ -x "$(command -v "pip")" ] || installpkg python-pip >/dev/null 2>&1
	yes | pip install "$1"
}

installationloop() {
	([ -f "$progsfile" ] && cp "$progsfile" /tmp/progs.csv) ||
		curl -Ls "$progsfile" | sed '/^#/d' >/tmp/progs.csv
	total=$(wc -l </tmp/progs.csv)
	aurinstalled=$(pacman -Qqm)
	while IFS=, read -r tag program comment; do
		n=$((n + 1))
		echo "$comment" | grep -q "^\".*\"$" &&
			comment="$(echo "$comment" | sed -E "s/(^\"|\"$)//g")"
		case "$tag" in
		"A") aurinstall "$program" "$comment" ;;
		"G") gitmakeinstall "$program" "$comment" ;;
		"P") pipinstall "$program" "$comment" ;;
		*) maininstall "$program" "$comment" ;;
		esac
	done </tmp/progs.csv
}

gitdotsput() {"$dotfilesrepo"
    whiptail --infobox "Призыв святых Гита и Дотфайлс..." 7 60
    git clone --bare "$1" $HOME/.cfg
    function config {
       /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
    }
    mkdir -p .config-backup
    config checkout
    if [ $? = 0 ]; then
      echo "Checked out config.";
      else
        echo "Backing up pre-existing dot files.";
        config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
    fi;
    config checkout
    config config status.showUntrackedFiles no
}

#putgitrepo() {
#	# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
#	whiptail --infobox "Призыв святых Гита и Дотфайлс..." 7 60
#	[ -z "$3" ] && branch="master" || branch="$repobranch"
#	dir=$(mktemp -d)
#	[ ! -d "$2" ] && mkdir -p "$2"
#	chown "$name":wheel "$dir" "$2"
#	sudo -u "$name" git -C "$repodir" clone --depth 1 \
#		--single-branch --no-tags -q --recursive -b "$branch" \
#		--recurse-submodules "$1" "$dir"
#	sudo -u "$name" cp -rfT "$dir" "$2"
#}

vimplugininstall() {
	# TODO remove shortcuts error message
	# Installs vim plugins.
	whiptail --infobox "Мобилизируем залупышей nvim..." 7 60
	mkdir -p "/home/$name/.config/nvim/autoload"
	curl -Ls "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" >  "/home/$name/.config/nvim/autoload/plug.vim"
	chown -R "$name:wheel" "/home/$name/.config/nvim"
	sudo -u "$name" nvim -c "PlugInstall|q|q"
}

#makeuserjs(){
#	# Get the Arkenfox user.js and prepare it.
#	arkenfox="$pdir/arkenfox.js"
#	overrides="$pdir/user-overrides.js"
#	userjs="$pdir/user.js"
#	ln -fs "/home/$name/.config/firefox/larbs.js" "$overrides"
#	[ ! -f "$arkenfox" ] && curl -sL "https://raw.githubusercontent.com/arkenfox/user.js/master/user.js" > "$arkenfox"
#	cat "$arkenfox" "$overrides" > "$userjs"
#	chown "$name:wheel" "$arkenfox" "$userjs"
#	# Install the updating script.
#	mkdir -p /usr/local/lib /etc/pacman.d/hooks
#	cp "/home/$name/.local/bin/arkenfox-auto-update" /usr/local/lib/
#	chown root:root /usr/local/lib/arkenfox-auto-update
#	chmod 755 /usr/local/lib/arkenfox-auto-update
#	# Trigger the update when needed via a pacman hook.
#	echo "[Trigger]
#Operation = Upgrade
#Type = Package
#Target = firefox
#Target = librewolf
#Target = librewolf-bin
#[Action]
#Description=Update Arkenfox user.js
#When=PostTransaction
#Depends=arkenfox-user.js
#Exec=/usr/local/lib/arkenfox-auto-update" > /etc/pacman.d/hooks/arkenfox.hook
#}

#installffaddons(){
#	addonlist="ublock-origin decentraleyes istilldontcareaboutcookies vim-vixen"
#	addontmp="$(mktemp -d)"
#	trap "rm -fr $addontmp" HUP INT QUIT TERM PWR EXIT
#	IFS=' '
#	sudo -u "$name" mkdir -p "$pdir/extensions/"
#	for addon in $addonlist; do
#		addonurl="$(curl --silent "https://addons.mozilla.org/en-US/firefox/addon/${addon}/" | grep -o 'https://addons.mozilla.org/firefox/downloads/file/[^"]*')"
#		file="${addonurl##*/}"
#		sudo -u "$name" curl -LOs "$addonurl" > "$addontmp/$file"
#		id="$(unzip -p "$file" manifest.json | grep "\"id\"")"
#		id="${id%\"*}"
#		id="${id##*\"}"
#		sudo -u "$name" mv "$file" "$pdir/extensions/$id.xpi"
#	done
#	# Fix a Vim Vixen bug with dark mode not fixed on upstream:
#	sudo -u "$name" mkdir -p "$pdir/chrome"
#	[ ! -f  "$pdir/chrome/userContent.css" ] && sudo -u "$name" echo ".vimvixen-console-frame { color-scheme: light !important; }
#category-more-from-mozilla { display: none !important }" > "$pdir/chrome/userContent.css"
#}

ohmyzshinstall() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	wait
	yay -S powerline-fonts
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes
	sudo pacman -Sqy --needed --noconfirm awesome-terinal-fonts
	wait
	autoload -Uz compinit && compinit
	source $ZSH/oh-my-zsh.sh
	export PATH=~/.zshrc:$PATH
}

finalize() {
	whiptail --title "Все кончено!" \
		--msgbox "Вы справились ничего не делая! Если есть хоть одна ошибка, скрипт ошибся. Иначе все на месте.\\n\\nДля старта просто введи \"startx\" и ты стартуешь (автоматически стартуешь в tty1 при запуске в альтернативном мире с нуля).\\n\\n. Субару" 13 80
}

### THE ACTUAL SCRIPT ###

### This is how everything happens in an intuitive format and order.

# Check if user is root on Arch distro. Install whiptail.
echo "KEYMAP=ru
FONT=cyr-sun16" >> /etc/vconsole.conf
pacman --noconfirm --needed -Sy libnewt ||
	error "Уверен, что врубил root, призвал Arch и имеешь возможность sudo pacman -S w3m \| w3m?"

# Welcome user and pick dotfiles.
welcomemsg || error "Человек ошибся."

# Get and verify username and password.
getuserandpass || error "Человек ошибся."

# Give warning if user already exists.
usercheck || error "Человек ошибся."

# Last chance for user to back out before install.
preinstallmsg || error "Человек ошибся."

### The rest of the script requires no user input.

# Refresh Arch keyrings.
refreshkeys ||
	error "Ключи тебе не дали. Сделай сам."

for x in curl ca-certificates base-devel git ntp zsh; do
	whiptail --title "А сейчас мы будем устанавливать все" \
		--infobox "Запихиваем \`$x\`. Это надо, правда, иначе считай пропало." 8 70
	installpkg "$x"
done

whiptail --title "А сейчас мы будем устанавливать все" \
	--infobox "Ты не знаешь в каком ты веке... Я позабочусь." 8 70
ntpd -q -g >/dev/null 2>&1

adduserandpass || error "Ошибка при знакомстве. Вас захотели убить."

[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers # Just in case

# Allow user to run sudo without password. Since AUR programs must be installed
# in a fakeroot environment, this is required for all builds with AUR.
trap 'rm -f /etc/sudoers.d/larbs-temp' HUP INT QUIT TERM PWR EXIT
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/larbs-temp

# Make pacman colorful, concurrent downloads and Pacman eye-candy.
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf

# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf

manualinstall yay || error "AUR временно не очень."

# The command that does all the installing. Reads the progs.csv file and
# installs each needed program the way required. Be sure to run this only after
# the user has been created and has priviledges to run sudo without a password
# and all build dependencies are installed.
installationloop

# Install the dotfiles in the user's home directory, but remove .git dir and
# other unnecessary files.
gitdotsput "$dotfilesrepo"
#gitdotsput "$dotfilesrepo" "/home/$name" "$repobranch"
#rm -rf "/home/$name/.git/" "/home/$name/README.md" "/home/$name/LICENSE" "/home/$name/FUNDING.yml"

# Install vim plugins if not alread present.
[ ! -f "/home/$name/.config/nvim/autoload/plug.vim" ] && vimplugininstall

# Most important command! Get rid of the beep!
rmmod pcspkr
echo "blacklist pcspkr" >/etc/modprobe.d/nobeep.conf

# Make zsh the default shell for the user.
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"
sudo -u "$name" mkdir -p "/home/$name/.config/abook/"
sudo -u "$name" mkdir -p "/home/$name/.config/mpd/playlists/"
ohmyzshinstall

# dbus UUID must be generated for Artix runit.
dbus-uuidgen >/var/lib/dbus/machine-id

# Use system notifications for Brave on Artix
echo "export \$(dbus-launch)" >/etc/profile.d/dbus.sh

# Enable tap to click
[ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
	# Enable left mouse button by tapping
	Option "Tapping" "on"
EndSection' >/etc/X11/xorg.conf.d/40-libinput.conf

# All this below to get Librewolf installed with add-ons and non-bad settings.
#
#whiptail --infobox "Setting browser privacy settings and add-ons..." 7 60
#
#browserdir="/home/$name/.librewolf"
#profilesini="$browserdir/profiles.ini"

# Start librewolf headless so it generates a profile. Then get that profile in a variable.
#sudo -u "$name" librewolf --headless >/dev/null 2>&1 &
#sleep 1
#profile="$(sed -n "/Default=.*.default-release/ s/.*=//p" "$profilesini")"
#pdir="$browserdir/$profile"

#[ -d "$pdir" ] && makeuserjs

#[ -d "$pdir" ] && installffaddons

# Kill the now unnecessary librewolf instance.
#pkill -u "$name" librewolf

# Allow wheel users to sudo with password and allow several system commands
# (like `shutdown` to run without password).
echo "%wheel ALL=(ALL:ALL) ALL" >/etc/sudoers.d/00-larbs-wheel-can-sudo
echo "%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/pacman -S -u -y --config /etc/pacman.conf --,/usr/bin/pacman -S -y -u --config /etc/pacman.conf --" >/etc/sudoers.d/01-larbs-cmds-without-password
echo "Defaults editor=/usr/bin/nvim" >/etc/sudoers.d/02-larbs-visudo-editor
mkdir -p /etc/sysctl.d
echo "kernel.dmesg_restrict = 0" > /etc/sysctl.d/dmesg.conf

# Last message! Install complete!
finalize
