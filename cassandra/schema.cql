CREATE KEYSPACE IF NOT EXISTS voluntariado
WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};

USE voluntariado;

CREATE TABLE IF NOT EXISTS logs_actividad (
    usuario_id UUID,
    fecha_hora TIMESTAMP,
    log_id UUID,
    accion TEXT,
    evento_id UUID,
    ip_address TEXT,
    dispositivo TEXT,
    resultado TEXT,
    detalles TEXT,
    PRIMARY KEY ((usuario_id), fecha_hora, log_id)
) WITH CLUSTERING ORDER BY (fecha_hora DESC);

CREATE TABLE IF NOT EXISTS historial_participacion (
    usuario_id UUID,
    fecha_evento TIMESTAMP,
    evento_id UUID,
    nombre_evento TEXT,
    organizacion TEXT,
    horas_aportadas INT,
    estado_asistencia TEXT,
    calificacion INT,
    PRIMARY KEY ((usuario_id), fecha_evento, evento_id)
) WITH CLUSTERING ORDER BY (fecha_evento DESC);