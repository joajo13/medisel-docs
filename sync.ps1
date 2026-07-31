# Re-copia los HTMLs generados desde Downloads al repo.
# Uso:  .\sync.ps1            (usa $HOME\Downloads)
#       .\sync.ps1 -Source "D:\otra\carpeta"

param(
    [string]$Source = (Join-Path $HOME "Downloads")
)

$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot

$map = @(
    @{ From = "CLIENTE  Medisel  Presupuesto.html";              To = "docs\presupuesto.html" }
    @{ From = "CLIENTE  Medisel  Especificacion funcional.html"; To = "docs\especificacion-funcional.html" }
    @{ From = "INTERNO  Medisel  Plan de proyecto.html";         To = "interno\plan-de-proyecto.html" }
    @{ From = "INTERNO  Medisel  SRS tecnico.html";              To = "interno\srs-tecnico.html" }
)

$copied = 0
$missing = @()

foreach ($item in $map) {
    $src = Join-Path $Source $item.From
    $dst = Join-Path $repo   $item.To

    if (Test-Path -LiteralPath $src) {
        Copy-Item -LiteralPath $src -Destination $dst -Force
        Write-Host "  OK  $($item.To)" -ForegroundColor Green
        $copied++
    } else {
        Write-Host "  --  falta: $($item.From)" -ForegroundColor DarkYellow
        $missing += $item.From
    }
}

Write-Host ""
Write-Host "$copied de $($map.Count) archivos actualizados desde $Source"

if ($missing.Count -gt 0) {
    Write-Host "No se encontraron $($missing.Count) archivo(s). Revisa el nombre o pasa -Source." -ForegroundColor DarkYellow
}

if ($copied -gt 0) {
    Write-Host ""
    Write-Host "Siguiente paso:" -ForegroundColor Cyan
    Write-Host "  git add -A; git commit -m 'docs: actualiza documentos'; git push"
}
