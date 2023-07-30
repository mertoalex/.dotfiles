#!/usr/bin/env sh
while true
do	printf "Devam etmek için 'e' tuşuna basıp enterlayın: "
	read girdi #biliyorum -n1 var ama extra güvenlik önemli
	[ $girdi == 'e' ] &> /dev/null && break
done

for file in $(ls | sed -z 's/uninstaller.sh//g;s/installer.sh//g;s/LICENSE//g;s/README.md//g;s/\n\n//g')
do	[ -h ~/.$file			] && unlink ~/.$file
	[ -f ~/backup.dotfiles/.$file	] && mv -v ~/backup.dotfiles/.$file ~/
done;	rm -rv ~/.color_mode
rm -r ~/backup.dotfiles/ &> /dev/null

echo "Bu scripti terciği etdiğiniz için teşekkür ederiz. -mertoalex"
