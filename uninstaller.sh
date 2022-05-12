#!/usr/bin/bash
while true
do	printf "devam etmek için 'e' tuşuna basıp enterlayın: "
	read girdi #biliyorum -n1 var ama extra güvenlik önemli
	[ $girdi == 'e' ] &> /dev/null && break
done

for file in {aliases,bashrc,definitions,zshrc} 
do	[ -h ~/.$file			] && rm -v ~/.$file
	[ -f ~/backup.dotfiles/.$file	] && mv -v ~/backup.dotfiles/.$file ~/
done
rm -r ~/backup.dotfiles/ &> /dev/null

echo "bu scripti terciği etdiğiniz için teşekkür ederim -mertoalex"
