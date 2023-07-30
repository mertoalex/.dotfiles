#!/usr/bin/env sh
echo "Uyarı: Bu dosyayı ~/ gibi önemli bir dizide bulundurmalısınız ve silmemelisiniz, yoksa sisteminizi bozabilirsiniz!"

while true
do	printf "Devam etmek için 'e' tuşuna basıp enterlayın: "
	read girdi #Biliyorum -n1 var ama extra güvenlik önemli
	[ $girdi == 'e' ] &> /dev/null && break
done

mkdir -pv ~/backup.dotfiles
for file in $(ls | sed -z 's/uninstaller.sh//g;s/installer.sh//g;s/LICENSE//g;s/README.md//g;s/\n\n//g')
do	[ -f ~/.$file ] && mv -v ~/.$file ~/backup.dotfiles/
	ln -sv $PWD/$file ~/.$file
done && echo "unset color_prompt force_no_color_prompt" > ~/.color_mode && \
	echo '~/.color_mode dosyası oluşturuldu.'

echo "Orjinal .dotfiles dosyalarınız ~/backup.dotfiles klasörüne yedeklenmiştir. (üstte hata vermediyse yani)"

echo "Bu scripti terciği etdiğiniz için teşekkür ederim -mertoalex"
