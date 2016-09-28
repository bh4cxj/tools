#!/bin/bash
# run as root

ver=`awk -F: '{print $5}' /etc/system-release-cpe`
[ $ver == 6 ] && rpm -Uvh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
[ $ver == 7 ] && rpm -Uvh http://mirrors.ustc.edu.cn/fedora/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

yum install -y sysstat htop tree perf autojump axel wget git


mkdir /root/github
cd /root/github

# install perf-tools
git clone https://github.com/brendangregg/perf-tools.git
echo 'export PATH="/root/github/perf-tools/bin:$PATH"' >> /etc/profile

# install exvim 
mkdir /root/github/exvim
cd /root/github/exvim
git clone https://github.com/exvim/main
cd main
sh unix/install.sh
sh unix/replace-my-vim.sh
sed -i '/background/ s/dark/light/' ~/.vimrc
echo "set cursorcolumn" >> ~/.vimrc
echo "set cursorline" >> ~/.vimrc


# install i3
# yum install -y i3 i3lock i3status fcitx fcitx-table fcitx-table-chinese

# jump directory, like autojump
export MARKPATH=$HOME/.marks
function jump {
	cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
	mkdir -p "$MARKPATH/" ; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
	rm -i "$MARKPATH/$1"
}
function marks {
	ls -l "$MARKPATH" | awk '{if (NR != 1) { printf "%s\t->\t%s\n", $9,$11}}'
}
