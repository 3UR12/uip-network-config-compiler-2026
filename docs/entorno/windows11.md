# Entorno Windows 11 - Preparación

## Instalar

1. **Git**: https://git-scm.com/downloads/win
2. **SDK .NET 10** (no solo Runtime): https://dotnet.microsoft.com/download/dotnet/10.0
3. **Visual Studio 2026** con carga de trabajo ASP.NET/web, o **VS Code** con C# Dev Kit.
4. **SQL Server Express** o **SQL Server LocalDB** para desarrollo; confirmar instancia y compatibilidad en el equipo.
5. **SQL Server Management Studio**: https://learn.microsoft.com/sql/ssms/install/install

## Comprobar

En PowerShell:

```powershell
dotnet --list-sdks
git --version
```

La salida de SDK debe incluir un `10.0.xxx`. El archivo `global.json` admite versiones posteriores de la familia 10.0 mediante roll-forward a la última feature band instalada.

## Estructura de proyectos .NET

Clonar el repositorio y usar la rama de preparación o `main` cuando se haya integrado:

```powershell
git clone https://github.com/3UR12/uip-network-config-compiler-2026.git
cd uip-network-config-compiler-2026
git switch chore/estructura-inicial-windows11
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\bootstrap-windows11.ps1
```

El bypass se limita a esa invocación de PowerShell. Antes de ejecutar scripts, revisa su contenido en el repositorio.

El script crea 4 proyectos de aplicación y 2 de prueba, agrega referencias entre proyectos y ejecuta `restore`, `build` y `test`. No configura SQL Server ni implementa el compilador. La primera ejecución descargará paquetes NuGet.

## Verificar MVC

```powershell
dotnet run --project .\src\NetworkConfig.Web
```

Abrir la dirección local que muestra `dotnet run`. La página inicial es la plantilla MVC y **no es el editor del compilador**.

## Base de datos (pendiente)

SQL Server será el motor de persistencia. Deben verificarse:

- Nombre real de la instancia (por ejemplo `localhost\SQLEXPRESS` o `(localdb)\MSSQLLocalDB`, según instalación).
- Autenticación Windows y permisos de creación de base de datos.
- Conexión desde SSMS.
- Configuración posterior de cadenas de conexión mediante `dotnet user-secrets` o variables de entorno.
- Migraciones EF Core y pruebas de persistencia **solo cuando el modelo esté definido**.

Nunca guardar credenciales de SQL en README, commits, capturas o archivos rastreados.

## Estado de verificación

Las instrucciones y el script están preparados para Windows 11, pero no se han ejecutado en la computadora del equipo. La compilación y la conexión SQL deben confirmarse con registros reales.
