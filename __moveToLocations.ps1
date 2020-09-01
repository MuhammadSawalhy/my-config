function cptodir($path, $dir){
	cp $path "$dir\$(Split-path $path -leaf)"
}

cptodir ./.gitconfig $HOME
cp 	./Microsoft.PowerShell_profile.ps1 $PROFILE

