function cptodir($path, $dir){
    cp $path "$dir\$(Split-Path $path -leaf)"
}

function get-filedir($path, $dir){
    echo (Split-Path $path)
}

function get-filename($path, $dir){
    echo (Split-Path $path -Leaf)
}

function path-resolve($Dir, $Path){
	$resolved = [System.IO.Path]::GetFullPath((Join-Path $Dir $Path))
	echo $resolved
};

function path-relative($Path){
	path-resolve $PWD.path $Path
};

$configs = @(
	[pscustomobject]@{FileName='.gitconfig'; Dest=$HOME}
	[pscustomobject]@{FileName='.gitignore_global'; Dest=$HOME}
	[pscustomobject]@{FileName='.npmrc'; Dest=$HOME}
	[pscustomobject]@{FileName='Microsoft.PowerShell_profile.ps1'; Dest=(Split-Path $PROFILE)}
)

For ($i=0; $i -lt $configs.Length; $i++) {
	if(split-path $configs[$i].Dest -IsAbsolute){
		$file = path-relative $configs[$i].FileName
		$dest = $configs[$i].Dest
		cp  $file $dest
		echo "Copy `"$file`"`nTo `"$dest`""
		echo "------------------------"
	} else {
		$file = path-relative $configs[$i].FileName
		$dest = path-relative $configs[$i].Dest
		cp  $file $dest
		echo "Copy `"$file`"`nTo `"$dest`""
		echo "------------------------"
	}
}
