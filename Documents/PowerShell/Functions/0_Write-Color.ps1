Function Write-Color {
  <#
  .SYNOPSIS
    Enables support to write multiple color text on a single line
  .DESCRIPTION
    Users color codes to enable support to write multiple color text on a single line
    ################################################
    # Write-Color Color Codes
    ################################################
    # ^cn = Normal Output Color
    # ^ck = Black
    # ^cb = Blue
    # ^cc = Cyan
    # ^ce = Gray
    # ^cg = Green
    # ^cm = Magenta
    # ^cr = Red
    # ^cw = White
    # ^cy = Yellow
    # ^cB = DarkBlue
    # ^cC = DarkCyan
    # ^cE = DarkGray
    # ^cG = DarkGreen
    # ^cM = DarkMagenta
    # ^cR = DarkRed
    # ^cY = DarkYellow [Unsupported in Powershell]
    ################################################
  .PARAMETER text
    Mandatory. Line of text to write
  .INPUTS
    [string]$text
  .OUTPUTS
    None
  .NOTES
    Version:        1.0
    Author:         Brian Clark
    Creation Date:  01/21/2017
    Purpose/Change: Initial function development
    Version:        1.1
    Author:         Brian Clark
    Creation Date:  01/23/2017
    Purpose/Change: Fix Gray / Code Format Fixes
  .EXAMPLE
    Write-Color "Hey look ^crThis is red ^cgAnd this is green!"
#>
 
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)][string]$text
  )
     
  ### If $text contains no color codes just write-host as normal
  if (-not $text.Contains("^c")) {
    Write-Host "$($text)"
    return
  }
 
 
  ### Set to true if the beginning of $text is a color code. The reason for this is that
  ### the generated array will have an empty/null value for the first element in the array
  ### if this is the case.
  ### Since we also assume that the first character of a split string is a color code we
  ### also need to know if it is, in fact, a color code or if it is a legitimate character.
  $blnStartsWithColor = $false
  if ($text.StartsWith("^c")) {
    $blnStartsWithColor = $true
  }
 
  ### Split the array based on our color code delimeter
  $strArray = $text -split "\^c"
  ### Loop Counter so we can generate a new empty line on the last element of the loop
  $count = 1
 
  ### Loop through the array
  $strArray | % {
    if ($count -eq 1 -and $blnStartsWithColor -eq $false) {
      Write-Host $_ -NoNewline
      $count++
    }
    elseif ($_.Length -eq 0) {
      $count++
    }
    else {
 
      $char = $_.Substring(0, 1)
      $color = ""
      switch -CaseSensitive ($char) {
        "b" { $color = "Blue" }
        "B" { $color = "DarkBlue" }
        "c" { $color = "Cyan" }
        "C" { $color = "DarkCyan" }
        "e" { $color = "Gray" }
        "E" { $color = "DarkGray" }
        "g" { $color = "Green" }
        "G" { $color = "DarkGreen" }
        "k" { $color = "Black" }
        "m" { $color = "Magenta" }
        "M" { $color = "DarkMagenta" }
        "r" { $color = "Red" }
        "R" { $color = "DarkRed" }
        "w" { $color = "White" }
        "y" { $color = "Yellow" }
        "Y" { $color = "DarkYellow" }
      }
 
      ### If $color is empty write a Normal line without ForgroundColor Option
      ### else write our colored line without a new line.
      if ($color -eq "") {
        Write-Host $_.Substring(1) -NoNewline
      }
      else {
        Write-Host $_.Substring(1) -NoNewline -ForegroundColor $color
      }
      ### Last element in the array writes a blank line.
      if ($count -eq $strArray.Count) {
        Write-Host ""
      }
      $count++
    }
  }
}