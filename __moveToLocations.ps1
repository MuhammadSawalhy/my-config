function cptodir($path, $dir){
	cp $path "$dir\$(Split-path $path -leaf)"
}

# copy to directory replacing or create the file there
cptodir ./.gitconfig $HOME
cptodir ./.gitignore_global $HOME

# copy to file path, replacing it
cp 	./Microsoft.PowerShell_profile.ps1 $PROFILE

