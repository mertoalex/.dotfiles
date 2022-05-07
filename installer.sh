#!/usr/bin/bash

echo "uyarı: bu dosyayı ~/ gibi önemli bir dizide bulundurmalısınız ve silmemelisiniz, yoksa sisteminizi bozabilir!"

while true
do	printf "devam etmek için 'e' tuşuna basıp enterlayın: "
	read girdi #biliyorum -n1 var ama extra güvenlik önemli
	[ $girdi == 'e' ] &> /dev/null && break
done

mkdir -p ~/backup.dotfiles
for file in $(ls | sed 's/installer.sh//' | sed 's/README.md//' | sed 's/LICENSE//')
do	mv ~/.$file ~/backup.dotfiles
	ln -sv $pwd/$file ~/.$file
done

echo "bu scripti terciği etdiğiniz için teşekkür ederim -mertoalex"
