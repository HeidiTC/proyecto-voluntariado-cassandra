USE voluntariado;

INSERT INTO logs_actividad (
    usuario_id, fecha_hora, log_id, accion, evento_id, ip_address, dispositivo, resultado, detalles
) VALUES (
    11111111-1111-1111-1111-111111111111,
    '2026-05-20 09:00:00',
    uuid(),
    'LOGIN',
    22222222-2222-2222-2222-222222222222,
    '192.168.1.10',
    'web',
    'SUCCESS',
    'Inicio de sesión exitoso del voluntario'
);

INSERT INTO logs_actividad (
    usuario_id, fecha_hora, log_id, accion, evento_id, ip_address, dispositivo, resultado, detalles
) VALUES (
    11111111-1111-1111-1111-111111111111,
    '2026-05-20 09:15:00',
    uuid(),
    'REGISTRO_EVENTO',
    33333333-3333-3333-3333-333333333333,
    '192.168.1.10',
    'web',
    'SUCCESS',
    'Voluntario inscrito al evento Limpieza del Río Acelhuate'
);

INSERT INTO logs_actividad (
    usuario_id, fecha_hora, log_id, accion, evento_id, ip_address, dispositivo, resultado, detalles
) VALUES (
    11111111-1111-1111-1111-111111111111,
    '2026-05-20 09:30:00',
    uuid(),
    'CANCELACION_EVENTO',
    44444444-4444-4444-4444-444444444444,
    '192.168.1.10',
    'web',
    'SUCCESS',
    'Voluntario canceló su participación en un evento'
);

INSERT INTO historial_participacion (
    usuario_id, fecha_evento, evento_id, nombre_evento, organizacion, horas_aportadas, estado_asistencia, calificacion
) VALUES (
    11111111-1111-1111-1111-111111111111,
    '2026-03-15 08:00:00',
    33333333-3333-3333-3333-333333333333,
    'Limpieza del Río Acelhuate',
    'Fundación Medio Ambiente SV',
    4,
    'ASISTIO',
    5
);

INSERT INTO historial_participacion (
    usuario_id, fecha_evento, evento_id, nombre_evento, organizacion, horas_aportadas, estado_asistencia, calificacion
) VALUES (
    11111111-1111-1111-1111-111111111111,
    '2026-04-10 09:00:00',
    55555555-5555-5555-5555-555555555555,
    'Jornada de Donación de Alimentos',
    'Manos Solidarias',
    3,
    'ASISTIO',
    4
);

INSERT INTO historial_participacion (
    usuario_id, fecha_evento, evento_id, nombre_evento, organizacion, horas_aportadas, estado_asistencia, calificacion
) VALUES (
    11111111-1111-1111-1111-111111111111,
    '2026-05-05 10:00:00',
    66666666-6666-6666-6666-666666666666,
    'Taller Educativo Comunitario',
    'Educación para Todos',
    2,
    'CONFIRMADO',
    0
);