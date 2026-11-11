# Matriz inicial de requisitos y alcance

**Fuente académica:** *Guía Técnica para Integrar CRUD en Proyectos Finales*, UIP, 2026. Apartados 2, 3, 4, 9 y 13–19.

## Requisitos exigidos por la guía (E)

| ID | Requisito | Evidencia de aceptación |
|---|---|---|
| E-01 | DSL propio de redes | Gramática y ejemplos válidos/invalidos |
| E-02 | Análisis léxico y sintáctico reales | Tokens y parser probado |
| E-03 | Validaciones semánticas y errores controlados | Diagnósticos por línea |
| E-04 | Generar configuración de red útil | Salida válida desde DSL |
| E-05 | IPv4/CIDR, direcciones de red/broadcast, duplicados y gateway | Casos positivos y negativos |
| E-06 | CRUD de dispositivos/perfiles, lectura de configuraciones, actualización de interfaces/rutas/VLAN y retiro auditado | Persistencia SQL y operaciones verificadas |
| E-07 | Seguridad, validación servidor, credenciales protegidas y excepciones controladas | Roles, formularios y pruebas |
| E-08 | Evidencia de fuente, validación, salida y CRUD | Capturas/demostración |
| E-09 | Al menos 1 caso válido y 2 inválidos | Pruebas reproducibles |
| E-10 | Repositorio, documentación y video | Instrucciones y demostración |

## Recomendaciones de la guía (R)

- C#, ASP.NET Core MVC, SQL Server, JSON/YAML; Packet Tracer opcional.
- Capas de presentación, aplicación, compilador, persistencia e infraestructura.
- AST o representación equivalente; modelo de persistencia con Device, InterfaceDefinition, NetworkProfile, RouteDefinition y GeneratedConfiguration.
- Modelo de trazabilidad con fuente, compilaciones, artefactos y diagnósticos.

## Propuestas de diseño del grupo (P), pendientes de revisión

- C# / .NET 10, ASP.NET Core MVC, EF Core 10 y SQL Server para Windows 11.
- Lexer y parser propios, AST tipado y generadores Cisco IOS + JSON.
- DSL con DISPOSITIVO, INTERFAZ ... IP y RUTA ... VIA.
- DSL versionado como fuente de verdad; las ediciones CRUD deberán recompilar/sincronizar.
- Compilador independiente de MVC y EF Core.
- Automatización de pruebas con xUnit.

## Criterios de evaluación (rúbrica general *propuesta*, 100 puntos)

| Criterio | Puntos |
|---|---:|
| Lenguaje y gramática | 10 |
| Lexer, parser y AST/equivalente | 20 |
| Análisis semántico | 10 |
| Generación/ejecución | 20 |
| CRUD y SQL | 15 |
| Seguridad y errores | 10 |
| Pruebas | 5 |
| Documentación | 5 |
| Video/sustentación | 5 |

**No se considera implementado ningún requisito por el hecho de figurar en esta matriz.**
