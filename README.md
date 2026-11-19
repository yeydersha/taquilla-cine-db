# Taquilla de Cine - Base de Datos

Este repositorio contiene la estructura de base de datos para el sistema "Taquilla de Cine", diseñada exclusivamente para **PostgreSQL**.

**Fase actual: 4.2 - Integración con PostgreSQL Remoto (Neon) completada**

## Requisitos

- PostgreSQL 12 o superior.

## Estructura del Repositorio

- `sql/01_create_tables.sql`: Define las tablas principales del sistema.
- `sql/02_constraints_indexes.sql`: Define las relaciones de integridad referencial, restricciones de dominio e índices de optimización.
- `sql/03_drop_tables.sql`: Script para limpiar la base de datos (eliminar tablas).

## Orden de Ejecución

Para inicializar la base de datos, ejecute los scripts en el siguiente orden:

1. `sql/01_create_tables.sql`
2. `sql/02_constraints_indexes.sql`

Para eliminar la estructura:

1. `sql/03_drop_tables.sql`

## Decisiones de Diseño

- **Tipos de Datos**: Se utilizaron `BIGINT` con `GENERATED ALWAYS AS IDENTITY` para las claves primarias para asegurar escalabilidad y compatibilidad con estándares SQL modernos.
- **Integridad Referencial**: Se configuró `ON DELETE RESTRICT` en todas las llaves foráneas para cumplir con el requisito de no permitir el borrado de registros con dependencias activas (sin cascada).
- **Validaciones**: Se implementaron restricciones `CHECK` a nivel de base de datos para asegurar que valores como precios, duraciones y cupos sean siempre válidos (positivos y coherentes).
- **Optimización**: Se crearon índices en todas las llaves foráneas y campos de fecha para acelerar las consultas más comunes del sistema.

## Entornos de Base de Datos

### Local (pruebas automatizadas)

- Base de datos: `taquilla_cine_test` (PostgreSQL local, puerto 5432)
- Uso: **Exclusivamente para pruebas automatizadas** (`mvn test` en `taquilla-cine-api`)
- Scripts de inicialización: mismos scripts SQL

### Remoto / Usuario (Neon - funcionamiento habitual)

- Base de datos: `taquilla_cine` en **Neon** (PostgreSQL gestionado)
- Uso: **Ejecución habitual, pruebas manuales, desarrollo**
- Configuración: `application-local.properties` en `taquilla-cine-api` (no versionado)

> **Nota:** Los scripts SQL son idénticos para ambos entornos. La diferencia es solo la conexión y credenciales.

## Fase 4.2 - Integración con Neon - Completada

**Estado:** ✅ Completada (14/14 comprobaciones manuales + 16/16 validación remota final aprobadas).

### Pruebas manuales con Neon

| Categoría | Pruebas | Estado |
|-----------|---------|--------|
| Corrección selector compras | 14/14 | ✅ |
| Validación remota final (Neon) | 16/16 | ✅ |
| **Total fase 4.2** | **30/30** | **✅ Aprobado** |

## Fase 5 - Preparación de Repositorios

**Estado:** 🔄 En preparación.

### Seguridad y repositorios

- Revisión de credenciales y `.gitignore`
- Preparación para commit inicial (sin push)
- Verificación de `.gitignore` y archivos excluidos
