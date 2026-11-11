# Arquitectura preliminar

## Solución modular

```text
NetworkConfig.Web           -> NetworkConfig.Application, NetworkConfig.Infrastructure
NetworkConfig.Application   -> NetworkConfig.Compiler
NetworkConfig.Infrastructure-> NetworkConfig.Application
NetworkConfig.Compiler      -> (sin dependencias Web, Application o SQL)
NetworkConfig.Compiler.Tests-> NetworkConfig.Compiler
NetworkConfig.Integration.Tests -> Web / Application / Infrastructure
```

- **Web:** interfaz MVC, editor DSL, inventario, formularios, resultados.
- **Application:** casos de uso, orquestación, compilación, trazabilidad, contratos de repositorio.
- **Compiler:** lexer, parser, AST, validaciones de red y generadores Cisco/JSON, sin acceso a la base de datos.
- **Infrastructure:** EF Core, SQL Server, repositorios, auditoría y almacenamiento.
- **Tests:** pruebas del lenguaje y de extremo a extremo.

## Contrato conceptual del compilador

```text
Compile(sourceDsl, targetFormat)
 -> Tokens
 -> Ast
 -> Diagnostics { code, phase, line, column, message, severity }
 -> GeneratedContent? (solo si es válido)
```

## Regla central de persistencia

La fuente DSL deberá versionarse. Una compilación inválida puede registrarse como intento, pero no reemplazará la última configuración activa válida. Las modificaciones mediante CRUD que alteren la configuración deben mantener la equivalencia con el DSL y pasar por las mismas validaciones semánticas. Estrategia exacta pendiente de decisión.

## Límites y seguridad

- Nunca usar sustituciones de texto como reemplazo del lexer/parser.
- Nunca ejecutar comandos Cisco en equipos reales en el MVP.
- No introducir credenciales ni cadenas sensibles en Git.
- Usar migraciones y controles de integridad para operaciones CRUD.
- Roles al menos Administrador y Usuario/Operador según la guía.

Estado: **diseño, sin implementación verificada**.
