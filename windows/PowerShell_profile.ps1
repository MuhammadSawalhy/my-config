Import-Module posh-git
Import-Module oh-my-posh
Set-Theme robbyrussell


#region my helpers and fast utils

$myp = "E:\Programming\_Projects\"

function cdmyp{
  cd $myp
}

$myc = "$HOME\my-config"

function cdmyc{
	cd $myc
}

function updatemyc{
  echo ""

  if(!$args) {
    Write-Host "Nothing to update!" -ForegroundColor Yellow
    return
  } elseif($args.length -eq 1 -and $args[0] -eq '--all') {
      Write-Host "Updating all configs!" -ForegroundColor Blue
  } else {
    for($i=0; $i -lt $args.length; $i+=1){
      $f = $args[$i]
      if ($f -ieq "ps") { $args[$i] = "Powershell_profile.ps1" }
      elseif ($f -ieq "git") { $args[$i] = ".gitconfig" }
      elseif ($f -ieq "npm") { $args[$i] = ".npmrc" }
      echo "Updating config: $($args[$i])"
    }
  }

  &"$myc\__moveToLocations.ps1" $args

  echo ""
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

function file-dir($path){
  if (!(Test-Path $path)) {
    throw ("$path doesn't exist")
  }
  if (!(Test-Path -Path $path -PathType Leaf)){
    throw "can't get file dir of $path"
  }
  Write-Output (Split-Path $path)
}

function file-name($path){
  if (!(Test-Path $path)) {
    throw ("$path doesn't exist")
  }
  if (!(Test-Path $path -PathType Leaf)){
    throw ("can't get file name of $path")
  }
  Write-Output (Split-Path $path -Leaf)
}

function path-resolve($Dir, $Path){
  if(Split-Path $Path -IsAbsolute){
      Write-Output $Path; return
  }
  $resolved = [IO.Path]::GetFullPath((Join-Path $Dir $Path))
  Write-Output $resolved
}

function path-relative($Path){
  Write-Output (path-resolve $PWD.path $Path)
}

#endregion


#region emulate Unix terminal

function touch($Path){

  $Path = path-relative $Path

  $Dir = Split-Path $Path
  if(!(Test-Path $Dir)){
    mkdirp $Dir
  }

  $MyRawString = ""
  if (Test-Path $Path) {
    $MyRawString = cat -Raw $Path
  }

  [IO.File]::WriteAllLines($Path, $MyRawString)

  echo "$Path"

  # $MyFile = Get-Content $Path
  # $MyFile | Out-File -Encoding "UTF8" $Path
}

function mkdirp($Path){
  New-Item $Path -ItemType Directory
}

#endregion


#region git shorcuts

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

#endregion

