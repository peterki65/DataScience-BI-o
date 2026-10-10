[CmdletBinding()]
param([string]$ProjectPath = $PSScriptRoot)
$ErrorActionPreference = 'Stop'
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git saknas. Installera Git for Windows och kör skriptet igen.' }
$root = (Resolve-Path -LiteralPath $ProjectPath).Path
if (-not (Test-Path -LiteralPath (Join-Path $root 'huvudspar.tex'))) { throw 'Välj projektkatalogen som innehåller huvudspar.tex.' }
$existing = & git -C $root rev-parse --show-toplevel 2>$null
if ($LASTEXITCODE -eq 0) {
    if ([IO.Path]::GetFullPath($existing.Trim()).TrimEnd('\','/') -ne $root.TrimEnd('\','/')) { throw 'Katalogen ingår redan i ett överordnat Git-repository. Avbryter.' }
    Write-Host "Git är redan initierat i $root"
} else {
    & git -C $root init -b main
    if ($LASTEXITCODE -ne 0) { throw 'Git init misslyckades.' }
}
& git -C $root status --short
if ($LASTEXITCODE -ne 0) { throw 'Git status misslyckades.' }
Write-Host 'Granska filerna. Skapa sedan din första commit enligt README.md.'
