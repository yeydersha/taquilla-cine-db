-- 01_create_tables.sql
-- Creación de las tablas básicas para el sistema de taquilla de cine.

-- Tabla de Películas
CREATE TABLE peliculas (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    genero VARCHAR(80) NOT NULL,
    duracion_min INTEGER NOT NULL,
    clasificacion VARCHAR(20) NOT NULL
);

-- Tabla de Funciones
CREATE TABLE funciones (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pelicula_id BIGINT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    sala VARCHAR(50) NOT NULL,
    precio NUMERIC(12,2) NOT NULL,
    cupos_totales INTEGER NOT NULL,
    cupos_disponibles INTEGER NOT NULL
);

-- Tabla de Compras
CREATE TABLE compras (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    funcion_id BIGINT NOT NULL,
    nombre_cliente VARCHAR(150) NOT NULL,
    cantidad_boletos INTEGER NOT NULL,
    total NUMERIC(12,2) NOT NULL,
    fecha_compra TIMESTAMPTZ NOT NULL
);
