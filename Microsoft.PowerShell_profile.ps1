Import-Module posh-git
Import-Module oh-my-posh
Set-Theme robbyrussell

function myp(){
    Set-Location "E:\Programming\_Projects"
}

$myc = "$($HOME)\my-config"

function cdmyc(){
	cd $myc
}

function updatemyc(){
	&"$($myc)\__moveToLocations.ps1"
}

function cdlnk($target){
    if($target.EndsWith(".lnk"))
    {
        $sh = new-object -com wscript.shell
        $fullpath = resolve-path $target
        $targetpath = $sh.CreateShortcut($fullpath).TargetPath
        set-location $targetpath
    }
    else {
        set-location $target
    }
}

function touch($f){
  echo "" > $f
}

function cptodir($path, $dir){
	cp $path "$dir\$(Split-path $path -leaf)"
}

function path-resolve($Dir, $Path){
	$resolved = [System.IO.Path]::GetFullPath((Join-Path $Dir $Path))
	echo $resolved
};

function path-relative($Path){
	path-resolve $PWD.path $Path
};


# git shorcuts #################################

function gfpo(){
    git-flow-push origin
}

function git-flow-push($remote){
    git push $remote master
    git push $remote develop
    git push $remote --tags
}

function git-bash($c){
	if($c -eq "gfpo"){
		$cmd = "eval `$(ssh-agent -s) && ssh-add ~/.ssh/github_rsa_key && git push -u origin master develop --tags"
	} elseif ($c -eq "ssh") {
		$cmd = "eval `$(ssh-agent -s) && ssh-add ~/.ssh/github_rsa_key"
	}
	if($cmd){
		echo $cmd | clip
	}
	&"C:\Program Files\Git\git-bash.exe"
}
