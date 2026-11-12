# Fase 1: crea únicamente la estructura de proyectos .NET. No implementa el compilador.
# Requisitos: Windows 11, SDK .NET 10, acceso a NuGet.
param(
    [switch]$SkipTests
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function Invoke-DotNet {
    param([string[]]$Arguments)
    & dotnet @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw ("Fallo el comando: dotnet " + ($Arguments -join " "))
    }
}

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    throw "No se encontro dotnet. Instala primero el SDK .NET 10."
}

$sdks = (& dotnet --list-sdks) -join "`n"
if ($LASTEXITCODE -ne 0 -or $sdks -notmatch "(?m)^10\.") {
    throw "El equipo no tiene instalado el SDK .NET 10. Ejecuta dotnet --list-sdks."
}

Push-Location $repoRoot
try {
    Write-Host "Preparando solucion NetworkConfig desde $repoRoot"

    if (-not (Test-Path "NetworkConfig.slnx") -and -not (Test-Path "NetworkConfig.sln")) {
        Invoke-DotNet -Arguments @("new", "sln", "--name", "NetworkConfig")
    }

    $solution = if (Test-Path "NetworkConfig.slnx") { "NetworkConfig.slnx" } else { "NetworkConfig.sln" }

    $projects = @(
        @{ Name = "NetworkConfig.Web"; Template = "mvc"; Folder = "src/NetworkConfig.Web" },
        @{ Name = "NetworkConfig.Application"; Template = "classlib"; Folder = "src/NetworkConfig.Application" },
        @{ Name = "NetworkConfig.Compiler"; Template = "classlib"; Folder = "src/NetworkConfig.Compiler" },
        @{ Name = "NetworkConfig.Infrastructure"; Template = "classlib"; Folder = "src/NetworkConfig.Infrastructure" },
        @{ Name = "NetworkConfig.Compiler.Tests"; Template = "xunit"; Folder = "tests/NetworkConfig.Compiler.Tests" },
        @{ Name = "NetworkConfig.Integration.Tests"; Template = "xunit"; Folder = "tests/NetworkConfig.Integration.Tests" }
    )

    foreach ($p in $projects) {
        $projectFile = Join-Path $p.Folder ($p.Name + ".csproj")
        if (-not (Test-Path $projectFile)) {
            Invoke-DotNet -Arguments @(
                "new", $p.Template, "--name", $p.Name,
                "--framework", "net10.0", "--output", $p.Folder, "--no-restore"
            )
        }
    }

    $solutionProjects = (& dotnet sln $solution list) -join "`n"
    if ($LASTEXITCODE -ne 0) { throw "No se pudo leer la solucion." }

    foreach ($p in $projects) {
        $projectFile = Join-Path $p.Folder ($p.Name + ".csproj")
        $projectName = [regex]::Escape($p.Name + ".csproj")
        if ($solutionProjects -notmatch $projectName) {
            Invoke-DotNet -Arguments @("sln", $solution, "add", $projectFile)
        }
    }

    function Ensure-Reference {
        param([string]$FromProject, [string]$ToProject)
        $targetName = Split-Path $ToProject -Leaf
        if ((Get-Content -Raw $FromProject) -notmatch [regex]::Escape($targetName)) {
            Invoke-DotNet -Arguments @("add", $FromProject, "reference", $ToProject)
        }
    }

    Ensure-Reference "src/NetworkConfig.Application/NetworkConfig.Application.csproj" "src/NetworkConfig.Compiler/NetworkConfig.Compiler.csproj"
    Ensure-Reference "src/NetworkConfig.Infrastructure/NetworkConfig.Infrastructure.csproj" "src/NetworkConfig.Application/NetworkConfig.Application.csproj"
    Ensure-Reference "src/NetworkConfig.Web/NetworkConfig.Web.csproj" "src/NetworkConfig.Application/NetworkConfig.Application.csproj"
    Ensure-Reference "src/NetworkConfig.Web/NetworkConfig.Web.csproj" "src/NetworkConfig.Infrastructure/NetworkConfig.Infrastructure.csproj"
    Ensure-Reference "tests/NetworkConfig.Compiler.Tests/NetworkConfig.Compiler.Tests.csproj" "src/NetworkConfig.Compiler/NetworkConfig.Compiler.csproj"
    Ensure-Reference "tests/NetworkConfig.Integration.Tests/NetworkConfig.Integration.Tests.csproj" "src/NetworkConfig.Web/NetworkConfig.Web.csproj"

    Invoke-DotNet -Arguments @("restore", $solution)
    Invoke-DotNet -Arguments @("build", $solution, "--no-restore")

    if (-not $SkipTests) {
        Invoke-DotNet -Arguments @("test", $solution, "--no-build")
    }

    Write-Host ""
    Write-Host "Estructura base creada. Siguiente: dotnet run --project src/NetworkConfig.Web"
    Write-Host "No se han implementado lexer, parser, AST, CRUD ni SQL Server."
}
finally {
    Pop-Location
}
