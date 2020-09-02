Import-Module posh-git
Import-Module oh-my-posh
Set-Theme robbyrussell

$myp = "E:\Programming\_Projects\"

function cdmyp{
    cd $myp
}

$myc = "$HOME\my-config"

function cdmyc{
	cd $myc
}

function updatemyc{
    [CmdletBinding()]
    param ([string]$file, [string]$f)
    if($file){ $f = $file }

    function log{
        param([string]$msg)
        echo ""
        echo "=================="
        echo $msg
        echo "=================="
        echo ""
    }

    if($f -ieq "ps") { $f = "Powershell_profile.ps1" }
    elseif($f -ieq "git") { $f = ".gitconfig" }
    elseif($f -ieq "npm") { $f = ".npmrc" }

    if($f -ne ""){ log -msg "Updating configs: $f" }
    else { log -msg "Updating all configs!" } 

    &"$myc\__moveToLocations.ps1" -f $f
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
  New-Item -Path $f -ItemType File
}

function cptodir($path, $dir){
    if($dir){
	    cp $path "$dir\$(Split-path $path -leaf)"
    } else {
        throw "dir is not defined"
    }
}

function path-resolve($Dir, $Path){
	$resolved = [System.IO.Path]::GetFullPath((Join-Path $Dir $Path))
	write-output $resolved
}

function path-relative($Path){
	write-output (path-resolve $PWD.path $Path)
}


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
