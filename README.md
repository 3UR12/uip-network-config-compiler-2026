# Compilador para Configuración de Redes — UIP 2026

**Curso:** Compiladores — Universidad Interamericana de Panamá (UIP)  
**Proyecto:** Grupo 1 — Compilador para Configuración de Redes  
**Integrantes oficiales:** Aaron, Daniela y Euris

> **Estado:** fase de preparación. La arquitectura y el DSL son propuestas preliminares. Todavía NO están implementados el lexer, parser, AST, validaciones, generadores, CRUD ni persistencia SQL.

## Objetivo académico

Crear un lenguaje específico de dominio (DSL) para definir dispositivos, interfaces IPv4 y rutas estáticas; analizarlo mediante fases reales de compilación y generar configuraciones de red. Una aplicación web administrará inventario, fuentes, perfiles, resultados e historial con CRUD y SQL.

**El CRUD no sustituye al núcleo del compilador.** Fuente: *Guía Técnica para Integrar CRUD en Proyectos Finales*, UIP 2026, especialmente apartados 2, 9 y 14–19.

## Stack de desarrollo propuesto

- C# y .NET 10.
- ASP.NET Core MVC (Razor).
- Entity Framework Core 10 y SQL Server (Express/LocalDB durante desarrollo).
- xUnit para pruebas; Git y GitHub para colaboración.
- Cisco IOS como primera salida; JSON como salida complementaria.

La selección y el alcance están sujetos a confirmación de compatibilidad y decisiones abiertas.

## Windows 11: primeros pasos

1. Instalar **.NET 10 SDK**, **Git**, un editor **Visual Studio 2026 o VS Code con C# Dev Kit**, y SQL Server Express/LocalDB con SSMS.
2. Verificar en PowerShell: `dotnet --list-sdks` y `git --version`.
3. Clonar este repositorio.
4. Ejecutar el script revisado de preparación:

```powershell
git clone https://github.com/3UR12/uip-network-config-compiler-2026.git
cd uip-network-config-compiler-2026
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\bootstrap-windows11.ps1
```

El script crea la solución y las plantillas de 4 proyectos de aplicación y 2 de pruebas, las conecta y ejecuta restauración, compilación y pruebas de plantilla. **No configura aún SQL, ni implementa el compilador.** Requiere conexión a NuGet. Su funcionamiento en la computadora del grupo está pendiente de comprobación.

Para iniciar la plantilla web luego del script:

```powershell
dotnet run --project .\src\NetworkConfig.Web
```

## Carpetas de diseño ya disponibles

- [Requisitos y rúbrica](docs/requisitos/alcance.md).
- [Arquitectura y dependencias](docs/arquitectura/README.md).
- [DSL preliminar](docs/dsl/README.md).
- [Entorno Windows 11](docs/entorno/windows11.md).
- [Decisiones pendientes](docs/decisiones/PENDIENTES.md).
- [Identificación del grupo](docs/equipo.md).

La solución `NetworkConfig.slnx` y las carpetas de código se generan localmente mediante el script. Deben incorporarse al repositorio **solo después de verificar que compilan y se ejecutan**.

## Próximos hitos

1. Verificar entorno Windows 11 y SQL Server.
2. Aprobar gramática, tokens, AST y contratos.
3. Implementar fases del compilador.
4. Incorporar SQL, CRUD, seguridad e integración.
5. Probar casos válidos e inválidos y preparar evidencia para sustentación.

No registrar tareas o autoría individual sin confirmación de los participantes.
