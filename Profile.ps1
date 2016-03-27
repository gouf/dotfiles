# Put me in C:\Users\[user_name]\Documents\WindowsPowerShell\
Write-Host "Loading Current User Profile..."
function Get-GitBranch{
  git branch 2>$null |
  ForEach-Object {
    if($_[0] -eq "*") {
      $branch = ($_ -Split " ")[1]
      return "(git:$branch)"
      break
    }
  }
}
function prompt {
  (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell $pwd"
  $name = $pwd.Path | Split-Path -Leaf
  $t = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
  $gb = Get-GitBranch

  Write-Host "[" -NoNewLine -ForegroundColor White
  Write-Host "$t " -NoNewLine -ForegroundColor Green
  Write-Host $env:USERNAME -NoNewLine -ForegroundColor Cyan
  Write-Host "@$name " -NoNewLine -ForegroundColor White
  Write-Host "$gb" -NoNewLine -ForegroundColor Red
  Write-Host "]$" -NoNewLine -ForegroundColor White
  return " "
}

# alias
{
  Set-Alias -Name which -Value Get-Command
}.Invoke()
