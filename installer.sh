#!/usr/bin/bash

echo "uyarı: bu dosyayı ~/ gibi önemli bir dizide bulundurmalısınız ve silmemelisiniz, yoksa sisteminizi bozabilirsiniz!"

while true
do	printf "devam etmek için 'e' tuşuna basıp enterlayın: "
	read girdi #biliyorum -n1 var ama extra güvenlik önemli
	[ $girdi == 'e' ] &> /dev/null && break
done

mkdir -pv ~/backup.dotfiles
for file in $(ls | sed 's/installer.sh//' | sed 's/README.md//' | sed 's/LICENSE//' | sed 's/uninstaller.sh//')
do	[ -f ~/.$file ] && mv ~/.$file ~/backup.dotfiles/
	ln -sv $PWD/$file ~/.$file
done

echo "bu scripti terciği etdiğiniz için teşekkür ederim -mertoalex"
