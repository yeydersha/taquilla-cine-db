-- 02_constraints_indexes.sql
-- Definición de llaves foráneas, restricciones de chequeo e índices.

-- 1. Relaciones (Foreign Keys)
-- Nota: Se utiliza ON DELETE RESTRICT para evitar el borrado si hay registros relacionados.

ALTER TABLE funciones
ADD CONSTRAINT fk_funciones_peliculas
FOREIGN KEY (pelicula_id) REFERENCES peliculas(id)
ON DELETE RESTRICT;

ALTER TABLE compras
ADD CONSTRAINT fk_compras_funciones
FOREIGN KEY (funcion_id) REFERENCES funciones(id)
ON DELETE RESTRICT;

-- 2. Restricciones de Chequeo (CHECK Constraints)

-- Películas: duración positiva
ALTER TABLE peliculas
ADD CONSTRAINT chk_peliculas_duracion CHECK (duracion_min > 0);

-- Funciones: precio, cupos totales y cupos disponibles válidos
ALTER TABLE funciones
ADD CONSTRAINT chk_funciones_precio CHECK (precio > 0),
ADD CONSTRAINT chk_funciones_cupos_totales CHECK (cupos_totales > 0),
ADD CONSTRAINT chk_funciones_cupos_disponibles CHECK (cupos_disponibles >= 0 AND cupos_disponibles <= cupos_totales);

-- Compras: cantidad de boletos y total positivos
ALTER TABLE compras
ADD CONSTRAINT chk_compras_cantidad_boletos CHECK (cantidad_boletos > 0),
ADD CONSTRAINT chk_compras_total CHECK (total > 0);

-- 3. Índices (Performance)

-- Índices para llaves foráneas
CREATE INDEX idx_funciones_pelicula_id ON funciones(pelicula_id);
CREATE INDEX idx_compras_funcion_id ON compras(funcion_id);

-- Índices para búsquedas frecuentes
CREATE INDEX idx_funciones_fecha ON funciones(fecha);
CREATE INDEX idx_compras_fecha_compra ON compras(fecha_compra);
