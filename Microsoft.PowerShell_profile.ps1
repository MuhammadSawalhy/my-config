Import-Module posh-git
Import-Module oh-my-posh
Set-Theme robbyrussell

function myp(){
    Set-Location "E:\Programming\_Projects"
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
    ii "C:\Program Files\Git\git-bash.exe"
    if($c -eq "gfpo"){
        echo "eval `$(ssh-agent -s) && ssh-add ~/.ssh/github_rsa_key && git push -u origin master develop --tags" | clip
    } elseif ($c -eq "ssh") {
        echo "eval `$(ssh-agent -s) && ssh-add ~/.ssh/github_rsa_key" | clip
    }
}
