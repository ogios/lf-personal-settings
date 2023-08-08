
$tmp = [System.IO.Path]::GetTempFileName()
lf -last-dir-path="$tmp" $args
if (Test-Path -PathType Leaf "$tmp") {
    $dir = Get-Content "$tmp"
    Remove-Item -Force "$tmp"
    if (Test-Path -PathType Container "$dir") {
        if ("$dir" -ne "$pwd") {
            cd "$dir"
        }
    }
}
