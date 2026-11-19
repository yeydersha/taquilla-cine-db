# Taquilla de Cine - Base de Datos

Este repositorio contiene la estructura de base de datos para el sistema "Taquilla de Cine", diseñada exclusivamente para **PostgreSQL**.

## Requisitos

- PostgreSQL 12 o superior.

## Modelo Entidad-Relación

```mermaid
erDiagram
    PELICULAS ||--o{ FUNCIONES : "tiene"
    FUNCIONES ||--o{ COMPRAS : "genera"

    PELICULAS {
        BIGINT id PK
        VARCHAR(150) titulo
        VARCHAR(80) genero
        INTEGER duracion_min
        VARCHAR(20) clasificacion
    }

    FUNCIONES {
        BIGINT id PK
        BIGINT pelicula_id FK
        DATE fecha
        TIME hora
        VARCHAR(50) sala
        NUMERIC(12,2) precio
        INTEGER cupos_totales
        INTEGER cupos_disponibles
    }

    COMPRAS {
        BIGINT id PK
        BIGINT funcion_id FK
        VARCHAR(150) nombre_cliente
        INTEGER cantidad_boletos
        NUMERIC(12,2) total
        TIMESTAMPTZ fecha_compra
    }
```

## Descripción de las Tablas

### `peliculas`
Almacena la información de las películas en cartelera.
- `id` (PK, BIGINT, IDENTITY): Identificador único.
- `titulo` (VARCHAR(150), NOT NULL): Nombre de la película.
- `genero` (VARCHAR(80), NOT NULL): Género cinematográfico.
- `duracion_min` (INTEGER, NOT NULL, CHECK > 0): Duración en minutos.
- `clasificacion` (VARCHAR(20), NOT NULL): Clasificación por edad (ej. PG-13, +18).

### `funciones`
Define las proyecciones programadas para cada película.
- `id` (PK, BIGINT, IDENTITY): Identificador único.
- `pelicula_id` (FK, BIGINT, NOT NULL): Referencia a `peliculas.id`.
- `fecha` (DATE, NOT NULL): Día de la proyección (YYYY-MM-DD).
- `hora` (TIME, NOT NULL): Hora de inicio (HH:mm:ss).
- `sala` (VARCHAR(50), NOT NULL): Identificador de la sala.
- `precio` (NUMERIC(12,2), NOT NULL, CHECK > 0): Precio unitario del boleto.
- `cupos_totales` (INTEGER, NOT NULL, CHECK > 0): Capacidad total de la sala.
- `cupos_disponibles` (INTEGER, NOT NULL, CHECK ≥ 0): Butacas disponibles; se descuenta automáticamente al registrar compras.

### `compras`
Registra cada venta de boletos. Inmutable: no se permite edición ni eliminación.
- `id` (PK, BIGINT, IDENTITY): Identificador único.
- `funcion_id` (FK, BIGINT, NOT NULL): Referencia a `funciones.id`.
- `nombre_cliente` (VARCHAR(150), NOT NULL): Nombre del comprador.
- `cantidad_boletos` (INTEGER, NOT NULL, CHECK > 0): Boletos adquiridos.
- `total` (NUMERIC(12,2), NOT NULL): Calculado por el servidor (`precio × cantidad`).
- `fecha_compra` (TIMESTAMPTZ, NOT NULL): Instante exacto de la compra (zona horaria America/Bogota).

## Relaciones e Integridad Referencial

- `funciones.pelicula_id` → `peliculas.id` (ON DELETE RESTRICT).
- `compras.funcion_id` → `funciones.id` (ON DELETE RESTRICT).
- Restricción `CHECK (cupos_disponibles >= 0)` evita cupos negativos.
- Restricción `CHECK (cupos_disponibles <= cupos_totales)` asegura coherencia.

## Estructura de Scripts SQL

| Archivo | Descripción |
|---------|-------------|
| `sql/01_create_tables.sql` | Crea las tres tablas con sus columnas, tipos, PK, FK y restricciones CHECK. |
| `sql/02_constraints_indexes.sql` | Define FK, restricciones CHECK adicionales e índices en FK y campos de fecha. |
| `sql/03_drop_tables.sql` | **Destructivo**: elimina las tres tablas (ordena por dependencias: compras → funciones → peliculas). **Úselo con precaución**. |

## Orden de Ejecución

Para inicializar la base de datos:
1. `sql/01_create_tables.sql`
2. `sql/02_constraints_indexes.sql`

Para eliminar la estructura (uso exclusivo en entornos de desarrollo):
1. `sql/03_drop_tables.sql` — **Advertencia: destruye todos los datos sin confirmación.**

## Entornos de Base de Datos

Los scripts son idénticos para ambos entornos; solo cambia la conexión.

| Entorno | Base de datos | Uso |
|---------|---------------|-----|
| Local (pruebas automatizadas) | `taquilla_cine_test` (PostgreSQL local, puerto 5432) | Exclusivamente para `mvn test` en `taquilla-cine-api`. |
| Remoto / Usuario (Neon) | `taquilla_cine` en **Neon** | Ejecución habitual, pruebas manuales, desarrollo. |

## Pruebas Iniciales de Base de Datos

- **64 pruebas** automatizadas en `taquilla-cine-api` validan la integridad del esquema, restricciones CHECK, FK, índices y el guardián de entorno (`GuardiaBaseDatosPruebas`).
- Estado: **64/64 aprobadas**.

## Repositorios Relacionados

- **API REST (Spring Boot)**: https://github.com/yeydersha/taquilla-cine-api
- **Frontend (Angular 21)**: https://github.com/yeydersha/taquilla-cine-web