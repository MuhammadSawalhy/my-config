
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

$__configs = @(
    [pscustomobject]@{FileName='configs\.gitconfig'; Dest=$HOME}
    [pscustomobject]@{FileName='configs\.gitignore_global'; Dest=$HOME}
    [pscustomobject]@{FileName='configs\.npmrc'; Dest=$HOME}
    [pscustomobject]@{FileName='configs\PowerShell_profile.ps1'; Dest=$PROFILE}
)

if($args.length -eq 1 -and $args[0] -eq '--all') {
    $configs = $__configs
} else {
    $configs = @();
    foreach($c in $__configs){
        # skip the not found files in the $f list
        $found = !$args
        foreach($f in $args){
            if($f -eq (Split-Path $c.FileName -Leaf)){
                $found = $True;
                break;
            }
        }
        if($found) { $configs += $c }
    }
}

foreach ($c in $configs) {
    
    $file = path-relative $c.FileName
    
    $dest = path-relative $c.Dest

    $filename = file-name $file

    $destfile = $dest
    if(Test-Path $dest -PathType Container){
        $destfile = path-resolve $dest $filename
    }

    $cachedfile = path-relative ".\.cache\$filename"

    if ((Test-Path $cachedfile) -and (cat -Raw $cachedfile) -cne (cat -Raw $destfile)){
        Write-Host "There is change in the config file:" -ForegroundColor red
        Write-Host $destfile -ForegroundColor red
        Write-Host "------------------------" -ForegroundColor red
    } else {
        if ((Test-Path $file) -and (cat -Raw $file) -cne (cat -Raw $destfile)){
            cp $file $destfile
            cp $file $cachedfile
            echo ""
            echo "Copy `"$file`""
            echo "To `"$destfile`""
            Write-Host "------------------------" -ForegroundColor green
        } else {
            echo ""
            echo "Config `"$filename`" is not changed"
            Write-Host "------------------------" -ForegroundColor Yellow
        }
    }

}
