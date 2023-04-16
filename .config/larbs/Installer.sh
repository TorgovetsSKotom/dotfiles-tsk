#!/bin/sh

dotfilesrepo="https://github.com/TorgovetsSKotom/dotfiles-tsk.git"
progsfile="https://github.com/TorgovetsSKotom/dotfiles-tsk/master/.config/larbs/progs.csv"
aurhelper="paru"
name="tsk"
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

preinstallmsg() {
	whiptail --title "Начнем же Апокалипсис, Армагеддон, Конец света, Рагнарек, Великий суд, Мекке в одмном событии!" --yes-button "Погнали!" \
		--no-button "Остановись!" \
		--yesno "Теперь у тебя есть выбор. Кальян, энергетик, пиво, банальный чай, ведро кофе. Все. Наслаждайся.\\n\\nВ смысле, нет выбора? Не возвражай, я все закончу." 13 60 || {
		clear
		exit 1
	}
}

# refreshkeys() {
# 	case "$(readlink -f /sbin/init)" in
# 	*systemd*)
# 		whiptail --infobox "Предоставляем ключи достойным..." 7 40
# 		pacman --noconfirm -S archlinux-keyring >/dev/null 2>&1
# 		;;
# 	*)
# 		whiptail --infobox "Лезем в Arch Repositories для призыва древних ..." 7 40
# 		if ! grep -q "^\[universe\]" /etc/pacman.conf; then
# 			echo "[universe]
# Server = https://universe.artixlinux.org/\$arch
# Server = https://mirror1.artixlinux.org/universe/\$arch
# Server = https://mirror.pascalpuffke.de/artix-universe/\$arch
# Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/\$arch
# Server = https://mirror1.cl.netactuate.com/artix/universe/\$arch
# Server = https://ftp.crifo.org/artix-universe/\$arch
# Server = https://artix.sakamoto.pl/universe/\$arch" >>/etc/pacman.conf
# 			pacman -Sy --noconfirm >/dev/null 2>&1
# 		fi
# 		pacman --noconfirm --needed -S \
# 			artix-keyring artix-archlinux-support >/dev/null 2>&1
# 		for repo in extra community; do
# 			grep -q "^\[$repo\]" /etc/pacman.conf ||
# 				echo "[$repo]
# Include = /etc/pacman.d/mirrorlist-arch" >>/etc/pacman.conf
# 		done
# 		pacman -Sy >/dev/null 2>&1
# 		pacman-key --populate archlinux >/dev/null 2>&1
# 		;;
# 	esac
# }

#manualinstall() {
#	pacman -Qq "$1" && return 0
#	whiptail --infobox "Устанавливаем \"$1\" вручную ." 7 50
#	sudo -u "$name" mkdir -p "$repodir/$1"
#	sudo -u "$name" git -C "$repodir" clone --depth 1 --single-branch \
#		--no-tags -q "https://aur.archlinux.org/$1.git" "$repodir/$1" ||
#		{
#			cd "$repodir/$1" || return 1
#			sudo -u "$name" git pull --force origin master
#		}
#	cd "$repodir/$1" || exit 1
#	sudo -u "$name" -D "$repodir/$1" \
#		makepkg --noconfirm -si >/dev/null 2>&1 || return 1
#}

maininstall() {
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

# gitdotsput() {
#     whiptail --infobox "Призыв святых Гита и Дотфайлс..." 7 60
#     alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
#     git clone --bare "$1" $HOME/.cfg
#     function config {
#        /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
#     }
#     config checkout
#     config config status.showUntrackedFiles no
# }

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

finalize() {
	whiptail --title "Все кончено!" \
		--msgbox "Вы справились ничего не делая! Если есть хоть одна ошибка, скрипт ошибся. Иначе все на месте.\\n\\nДля старта просто введи \"startx\" и ты стартуешь (автоматически стартуешь в tty1 при запуске в альтернативном мире с нуля).\\n\\n. Субару" 13 80
}

### THE ACTUAL SCRIPT ###

export repodir="/home/$name/.local/src"
mkdir -p "$repodir"
chown -R "$name":wheel "$(dirname "$repodir")"

pacman --noconfirm --needed -Sy libnewt ||
	error "Уверен, что врубил root, призвал Arch и имеешь возможность sudo pacman -S w3m \| w3m?"

preinstallmsg || error "Человек ошибся."

# refreshkeys ||
# 	error "Ключи тебе не дали. Сделай сам."

for x in curl ca-certificates base-devel git ntp zsh; do
	whiptail --title "А сейчас мы будем устанавливать все" \
		--infobox "Запихиваем \`$x\`. Это надо, правда, иначе считай пропало." 8 70
	installpkg "$x"
done

whiptail --title "А сейчас мы будем устанавливать все" \
	--infobox "Ты не знаешь в каком ты веке... Я позабочусь." 8 70
ntpd -q -g >/dev/null 2>&1

#manualinstall $aurhelper || error "AUR временно не очень."

installationloop

# gitdotsput "$dotfilesrepo"
#gitdotsput "$dotfilesrepo" "/home/$name" "$repobranch"
#rm -rf "/home/$name/.git/" "/home/$name/README.md" "/home/$name/LICENSE" "/home/$name/FUNDING.yml"

finalize
