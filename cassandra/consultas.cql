USE voluntariado;

-- Consultar logs de actividad de un usuario específico
SELECT *
FROM logs_actividad
WHERE usuario_id = 11111111-1111-1111-1111-111111111111;

-- Consultar historial de participación de un voluntario específico
SELECT *
FROM historial_participacion
WHERE usuario_id = 11111111-1111-1111-1111-111111111111;