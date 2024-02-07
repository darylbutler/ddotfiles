function Convert-ToDiskSize {
    param ( $bytes, $precision = '0' )
    foreach ($size in ("B", "K", "M", "G", "T")) {
        if (($bytes -lt 1000) -or ($size -eq "T")) {
            $bytes = ($bytes).tostring("F0" + "$precision")
            return "${bytes}${size}"
        }
        else { $bytes /= 1KB }
    }
}