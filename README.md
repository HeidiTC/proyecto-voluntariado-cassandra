# Plataforma de Voluntariado Comunitario

## Descripción del proyecto

Este proyecto corresponde a la fase final del proyecto de cátedra de Bases de Datos II. La plataforma tiene como objetivo conectar voluntarios con organizaciones comunitarias, permitiendo registrar eventos, participación de usuarios y actividad generada dentro del sistema.

En esta fase se implementó el módulo de Cassandra, orientado al almacenamiento de datos de alto volumen como logs de actividad e historial de participación.

## Tecnologías utilizadas

- ASP.NET Core Web API
- Apache Cassandra 4.1
- Docker y Docker Compose
- CassandraCSharpDriver
- Swagger
- PowerShell

## Modelo Cassandra

Se creó el keyspace `voluntariado` y dos tablas principales:

### logs_actividad

Esta tabla almacena las acciones realizadas por los usuarios dentro de la plataforma, como inicio de sesión, inscripción a eventos y cancelaciones.

Partition Key:
- `usuario_id`

Clustering Key:
- `fecha_hora`
- `log_id`

La tabla permite consultar rápidamente los logs de actividad de un usuario específico, ordenados por fecha de forma descendente.

### historial_participacion

Esta tabla almacena el historial de eventos en los que ha participado cada voluntario.

Partition Key:
- `usuario_id`

Clustering Key:
- `fecha_evento`
- `evento_id`

La tabla permite consultar el historial de participación de un voluntario específico, mostrando primero los eventos más recientes.

## Endpoints de la API

### GET /

Valida que la API se encuentre activa.

### GET /api/logs/{usuarioId}

Consulta los logs de actividad de un usuario específico.

Parámetros:

- `usuarioId`: identificador UUID del usuario.
- `pageSize`: cantidad de registros a devolver.

Ejemplo:

```http
GET /api/logs/11111111-1111-1111-1111-111111111111?pageSize=2
```

### GET /api/historial/{usuarioId}

Consulta el historial de participación de un voluntario específico.

Parámetros:

- `usuarioId`: identificador UUID del usuario.
- `pageSize`: cantidad máxima de registros a devolver.

Ejemplo:

```http
GET /api/historial/11111111-1111-1111-1111-111111111111?pageSize=2
```

## Ejecución del proyecto

### Levantar Cassandra en un nodo

Desde la carpeta `cassandra`, ejecutar:

```bash
docker compose up -d
```

### Levantar Cassandra en dos nodos

Desde la carpeta `cassandra`, ejecutar:

```bash
docker compose -f docker-compose-ha.yml up -d
```

Verificar el estado del clúster:

```bash
docker exec -it voluntariado-cassandra-node1 nodetool status
```

### Ejecutar scripts CQL

Copiar los archivos al contenedor:

```bash
docker cp schema.cql voluntariado-cassandra-node1:/schema.cql
docker cp insert_data.cql voluntariado-cassandra-node1:/insert_data.cql
docker cp consultas.cql voluntariado-cassandra-node1:/consultas.cql
```

Ejecutar los scripts:

```bash
docker exec voluntariado-cassandra-node1 cqlsh -f /schema.cql
docker exec voluntariado-cassandra-node1 cqlsh -f /insert_data.cql
docker exec voluntariado-cassandra-node1 cqlsh -f /consultas.cql
```

### Ejecutar la API

Desde la carpeta `VoluntariadoApi`, ejecutar:

```bash
dotnet restore
dotnet run
```

Abrir Swagger en el navegador:

```text
http://localhost:5170/swagger/index.html
```

## Alta disponibilidad con Cassandra

Se configuró un clúster Cassandra de dos nodos utilizando Docker Compose. La verificación se realizó mediante el comando:

```bash
docker exec -it voluntariado-cassandra-node1 nodetool status
```

El resultado mostró ambos nodos en estado `UN`, lo que significa:

- `U`: Up, el nodo está activo.
- `N`: Normal, el nodo forma parte correctamente del anillo Cassandra.

Esta configuración permite demostrar una arquitectura básica de alta disponibilidad para el proyecto.

## Backups

### Backup manual

Se ejecutó un backup manual del keyspace `voluntariado` utilizando el comando:

```bash
docker exec -it voluntariado-cassandra nodetool snapshot voluntariado
```

Este comando genera una copia de respaldo de las tablas Cassandra sin detener el servicio.

### Backup automatizado local

También se creó un script PowerShell llamado:

```text
backup_cassandra.ps1
```

Este script ejecuta el snapshot del keyspace `voluntariado` y copia los archivos físicos generados hacia una carpeta local de backups.

## Archivos principales del proyecto

```text
Proyecto_Voluntariado_Cassandra/
│
├── cassandra/
│   ├── docker-compose.yml
│   ├── docker-compose-ha.yml
│   ├── schema.cql
│   ├── insert_data.cql
│   ├── consultas.cql
│   └── backup_cassandra.ps1
│
├── VoluntariadoApi/
│   ├── Program.cs
│   └── VoluntariadoApi.csproj
│
├── backups/
│
└── README.md
```

## Conclusión técnica

El módulo Cassandra permite almacenar y consultar información de alto volumen generada por la plataforma, como logs de actividad e historial de participación.

El diseño utiliza `usuario_id` como `Partition Key` para consultar rápidamente la información de un voluntario específico, mientras que las fechas se utilizan como `Clustering Key` para ordenar los resultados de forma descendente.

Además, se implementó una API REST en ASP.NET Core conectada a Cassandra mediante el driver oficial `CassandraCSharpDriver`, incluyendo consultas paginadas, evidencia de alta disponibilidad con dos nodos y procesos de backup manual y automatizado.