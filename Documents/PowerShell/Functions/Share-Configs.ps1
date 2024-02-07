$config_share_path = "\\ANUUMICRO\Share\Config"
$backup_share_path = "\\ANUUMICRO\Share\Config\.backup"

function Compare-PSConfig($output = $true) {       
    $root = "$env:USERPROFILE\Documents\PowerShell\"
    $local = (Get-ChildItem $root -Exclude Help, Modules, InstalledScriptInfos | Get-ChildItem -File -Recurse -Exclude InstalledScriptInfos | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
    $remote = (Get-ChildItem "$config_share_path/PowerShell" -Exclude Help, Modules, InstalledScriptInfos | Get-ChildItem -File -Recurse | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum

    return Compare-ConfigFileAge $local $remote $output 
}
function Compare-VimConfig($output = $true) {
    $root = "$env:USERPROFILE/AppData/Local/nvim"
    $local = (Get-ChildItem $root -File -Recurse -Filter "*.lua" | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
    $remote = (Get-ChildItem "$config_share_path/nvim" | Get-ChildItem -File -Recurse | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum

    return Compare-ConfigFileAge $local $remote $output
}
function Compare-TermConfig($output = $true) {
    $root = "$env:USERPROFILE/scoop/apps/windows-terminal-preview/current/settings"
    $local = (Get-ChildItem $root -Exclude "state.json" -File -Recurse -Filter "*.json" | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
    $remote = (Get-ChildItem "$config_share_path/WindowsTerminal" -File -Recurse | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum

    return Compare-ConfigFileAge $local $remote $output 
}
function Compare-ConfigDir($output = $true) {
    $root = "$env:USERPROFILE/.config/"
    $local = (Get-ChildItem $root -File -Recurse | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
    $remote = (Get-ChildItem "$config_share_path/.config" -File -Recurse | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum

    return Compare-ConfigFileAge $local $remote $output 
}
function Compare-ConfigFileAge($local, $remote, $output) {    
    
    if ($local -eq $remote) {
        if ($output) {
            Write-Color "^cyLocal^cn is ^cgUp-To-Date^cn (^cg$local^cn)"
        }
        return 0
    }
    elseif ($local -gt $remote) {        
        if ($output) {
            Write-Color "^cyLocal^cn is ^crNewer^cn than ^cbRemote^cn   (^cy$local^cn vs ^cb$remote^cn)"            
        }
        return 1
    }
    else {
        if ($output) {
            Write-Color "^cyLocal^cn is ^crOlder^cn than ^cbRemote^cn   (^cy$local^cn vs ^cb$remote^cn)"
        }
        return -1
    }
}

function Push-Config {
    Push-PSConfig
    Push-VimConfig
    Push-TermConfig
    Push-ConfigDir
}
function Pull-Config {
    Pull-PSConfig
    Pull-VimConfig
    Pull-TermConfig
    Pull-ConfigDir
}

function _check-Config-Format($result) {
    if ($result -gt 0) {
        return "^cbAhead^cn"
    }
    if ($result -lt 0) {
        return "^cmBehind^cn"
    }
    return "^cgUp-To-Date^cn"
}
function Check-Config {
    $ps = Compare-PSConfig $false
    $vim = Compare-VimConfig $false
    $term = Compare-TermConfig $false
    $dir = Compare-ConfigDir $false
    Write-Color "^cgPowershell^cn:      $(_check-Config-Format $ps)"
    Write-Color "^cbVim / Neovim^cn:    $(_check-Config-Format $vim)"
    Write-Color "^cyTerminal^cn:        $(_check-Config-Format $term)"
    Write-Color "^ccConfig Dir^cn:      $(_check-Config-Format $dir)"
}

function Push-PSConfig {
    robocopy "$config_share_path/PowerShell" "$backup_share_path/PowerShell" /MIR /njh /njs /ndl /nfl
    robocopy "$env:USERPROFILE/Documents/PowerShell" "$config_share_path/PowerShell" /MIR /xd "Help" /xd "Modules" /xd "InstalledScriptInfos" /xd "Local" /njh /njs /ndl
}
function Pull-PSConfig {
    robocopy "$env:USERPROFILE/Documents/PowerShell" "$env:USERPROFILE/Documents/PowerShell-Backup" /MIR /njh /njs /ndl /nfl
    robocopy "$config_share_path/PowerShell" "$env:USERPROFILE/Documents/PowerShell" /MIR /xd "Help" /xd "Modules" /xd "InstalledScriptInfos" /xd "Local" /njh /njs /ndl /xx
}
function Push-VimConfig {
    robocopy "$config_share_path/nvim" "$backup_share_path/nvim" /MIR /njh /njs /ndl /nfl
    robocopy "$env:USERPROFILE/AppData/Local/nvim" "$config_share_path/nvim" *.lua /MIR  /njh /njs /ndl
}
function Pull-VimConfig {
    robocopy "$env:USERPROFILE/AppData/Local/nvim" "$env:USERPROFILE/AppData/Local/nvim-backup" /MIR /njh /njs /ndl /nfl
    robocopy "$config_share_path/nvim" "$env:USERPROFILE/AppData/Local/nvim" *.lua /MIR /xd "Modules" /xd "InstalledScriptInfos" /xd "Local" /njh /njs /ndl /xx
}
function Push-TermConfig {
    robocopy "$config_share_path/WindowsTerminal" "$backup_share_path/WindowsTerminal" /MIR /njh /njs /ndl /nfl
    robocopy "$env:USERPROFILE/scoop/apps/windows-terminal-preview/current/settings" "$config_share_path/WindowsTerminal" *.json /xf "state.json" /MIR /njh /njs /ndl
}
function Pull-TermConfig {
    robocopy "$env:USERPROFILE/scoop/apps/windows-terminal-preview/current/settings" "$env:USERPROFILE/scoop/apps/windows-terminal-preview/current/settings-backup" *.json /MIR /njh /njs /ndl /nfl
    robocopy "$config_share_path/WindowsTerminal" "$env:USERPROFILE/scoop/apps/windows-terminal-preview/current/settings" *.json /xf "state.json" /MIR /njh /njs /ndl /xx    
}
function Push-ConfigDir {
    robocopy "$config_share_path/.config" "$backup_share_path/.config" /MIR /njh /njs /ndl /nfl
    robocopy "$env:USERPROFILE/.config" "$config_share_path/.config" /MIR /njh /njs /ndl
}
function Pull-TermDir {
    robocopy "$env:USERPROFILE/.config" "$env:USERPROFILE/.config-backup" *.json /MIR /njh /njs /ndl /nfl
    robocopy "$config_share_path/.config" "$env:USERPROFILE/.config" /MIR /njh /njs /ndl /xx    
}
