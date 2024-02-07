# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#### PROMPT ####
Import-Module Terminal-Icons

#### PS Read Line ####
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
# Set-PSReadLineOption -EditMode Windows
# Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd

Set-PSReadLineKeyHandler -Chord 'Ctrl+a' -Function SelectAll
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+Backspace' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord

#### Fzf - History Search ####
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
$env:FZF_DEFAULT_OPTS = "--color=fg:#f8f8f2,hl:#bd93f9,gutter:-1 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#8be9fd,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

#### Bat - better cat ####
$env:BAT_THEME = "gruvbox-dark"

#### Aliases ####
if (Get-Alias -Name ls -ErrorAction SilentlyContinue) { Remove-Alias ls }
Set-Alias vi nvim
Set-Alias vim nvim

Set-Alias grep findstr
Set-Alias touch New-Item
Set-Alias mkd CreateAndSet-Directory
Set-Alias fs Get-DiskUsage
Set-Alias lg lazygit
New-Alias -Force config dotfiles

Set-Alias mute Set-SoundMute
Set-Alias unmute Set-SoundUnmute

Set-Alias dotnet $env:USERPROFILE/scoop/apps/dotnet-sdk/current/dotnet.exe

#### Functions ####
$docs = [environment]::getfolderpath(“MyDocuments”)
Get-ChildItem "$docs\PowerShell\Functions\*.ps1" | ForEach-Object { .$_ }
function ls ($a = '.') { eza -a --icons --group-directories-first $a }
function ll ($a = '.') { eza -hl --git --group-directories-first --time-style relative --changed --git-ignore $a }
function lla ($a = '.') { eza -ahl --git --group-directories-first --time-style relative --changed $a }
function lt ($a = '.') { eza -T -L 3 --group-directories-first $a }
function lta ($a = '.') { eza -aT --group-directories-first $a }
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
function time { $Command = "$args"; Measure-Command { Invoke-Expression $Command 2>&1 | out-default } }
function Edit-Profile { 
    Invoke-Expression "nvim '$PROFILE'" 
    & $profile
}
function System-Update {
    Install-WindowsUpdate -IgnoreUserInput -IgnoreReboot -AcceptAll
    Update-Module
    Update-Help -Force
    scoop update *
    rustup update
}
function dotfiles { git --git-dir=$env:USERPROFILE/.cfg/ --work-tree=$env:USERPROFILE $args }
# Create a new directory and enter it
function CreateAndSet-Directory([String] $path) { New-Item $path -ItemType Directory -ErrorAction SilentlyContinue; Set-Location $path }

function du($path = ".") {
    #todo
    $dirs = Get-ChildItem $path
    $sizes = @{}
    $total = 0
    for ($i = 0; $i -lt $dirs.Length; $i++) {
        $file = $dirs[$i]
        $size = Get-ChildItem -File -Recurse $file.FullName -ErrorAction SilentlyContinue | Measure-Object -Property length -Sum
        $sizes.Add($file, $size.Sum)
        $total += $size.Sum

        $prog = ($i / $dirs.Length) * 100.0
        Write-Progress -Activity "Calculating" -Status "$prog% Complete (Total: $($total)):" -PercentComplete $prog
    }
    $len = ($sizes.Keys | Measure-Object -Property Name -Max).Maximum.Length
    $sorted = $sizes | Sort-Object -Property Value -Descending

    Write-Color " ^cgTotal Size^cn: $(Convert-ToDiskSize($total)) --"
    foreach ($v in $sorted) {
        $icon = if ($v.Key.Attributes -eq 'Directory') { '^cg' } else { '^cY' }
        $size = Convert-ToDiskSize($v.Value)
        Write-Color "    $icon $($v.Key.Name.PadRight($len, ' '))^cn: ^cR$size^cn"
    }    
}
function Get-SoundVolume {
    [math]::Round([Audio]::Volume * 100)
}
function Set-SoundVolume([Parameter(mandatory = $true)][Int32] $Volume) {
    [Audio]::Volume = ($Volume / 100)
}
function Set-SoundMute {
    [Audio]::Mute = $true
}
function Set-SoundUnmute {
    [Audio]::Mute = $false
}

# Let WindowsTermin know what our cwd is:
function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)
