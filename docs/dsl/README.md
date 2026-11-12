# Diseño del DSL (BORRADOR)

Este archivo documenta una propuesta que todavía debe aprobarse antes de implementar el lexer y el parser.

## Ejemplo

```text
DISPOSITIVO R1 {
    INTERFAZ G0/0 IP 192.168.10.1/24
    RUTA 0.0.0.0/0 VIA 192.168.10.254
}
```

## Gramática EBNF preliminar

```ebnf
programa     = dispositivo, { dispositivo } ;
dispositivo  = "DISPOSITIVO", identificador, "{", { instruccion }, "}" ;
instruccion  = interfaz | ruta ;
interfaz     = "INTERFAZ", nombreInterfaz, "IP", ipv4, "/", prefijo ;
ruta         = "RUTA", ipv4, "/", prefijo, "VIA", ipv4 ;
```

La gramática aún no fija la tokenización de un nombre de interfaz como `G0/0`, los comentarios, las reglas de salto de línea, identificadores ni sensibilidad a mayúsculas. Esas decisiones deben especificarse antes de implementar.

## Validaciones previstas

1. IPv4 con cuatro octetos entre 0 y 255.
2. CIDR entre 0 y 32.
3. Reglas de host/red/broadcast según prefijo y contexto.
4. Interfaces duplicadas dentro del mismo dispositivo.
5. Gateway alcanzable bajo una regla definida y documentada.
6. Dispositivos duplicados, rutas repetidas y diagnósticos por línea.

## Salidas propuestas

- Cisco IOS para configuración de interfaces y rutas.
- JSON para consumo y pruebas de salida.

## Decisiones abiertas

- Tratamiento de `/31` y `/32`.
- Validez y normalización de nombres de interfaz.
- Comportamiento ante varias declaraciones DISPOSITIVO.
- Errores bloqueantes versus advertencias.
- Dialecto y convenciones de Cisco IOS.

No se ha implementado ni probado ninguna fase.
