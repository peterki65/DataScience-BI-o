[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$RepositoryUrl,
    [string]$ProjectPath = $PSScriptRoot
)
$ErrorActionPreference = 'Stop'
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git saknas.' }
if ($RepositoryUrl -notmatch '^https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+(?:\.git)?/?$' -and
    $RepositoryUrl -notmatch '^git@github\.com:[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+(?:\.git)?$') {
    throw 'Ange en GitHub-adress: https://github.com/ägare/repository.git eller git@github.com:ägare/repository.git.'
}
$root = (Resolve-Path -LiteralPath $ProjectPath).Path
$top = & git -C $root rev-parse --show-toplevel 2>$null
if ($LASTEXITCODE -ne 0) { throw 'Kör Init-Git.ps1 först.' }
if ([IO.Path]::GetFullPath($top.Trim()).TrimEnd('\','/') -ne $root.TrimEnd('\','/')) { throw 'Projektkatalogen måste vara roten för ditt Git-repository.' }
$current = & git -C $root remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    if ($current.Trim() -ne $RepositoryUrl) { throw "origin finns redan: $current. Ingen ändring har gjorts." }
    Write-Host 'origin har redan rätt adress.'
} else {
    & git -C $root remote add origin $RepositoryUrl
    if ($LASTEXITCODE -ne 0) { throw 'Kunde inte lägga till origin.' }
}
Write-Host 'GitHub-adressen är kopplad. Skriptet skapar inget repository och laddar inte upp filer.'
Write-Host 'Efter granskning och commit kan du köra: git push -u origin main'
