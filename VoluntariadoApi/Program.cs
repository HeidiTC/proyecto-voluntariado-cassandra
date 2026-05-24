using Cassandra;
using CassandraSession = Cassandra.ISession;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddSingleton<CassandraSession>(sp =>
{
    var cluster = Cluster.Builder()
        .AddContactPoint("127.0.0.1")
        .WithPort(9042)
        .Build();

    return cluster.Connect("voluntariado");
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/", () => "API Plataforma de Voluntariado Comunitario - Cassandra");

app.MapGet("/api/logs/{usuarioId}", async (CassandraSession session, Guid usuarioId, int pageSize = 10) =>
{
    var statement = new SimpleStatement(
        "SELECT usuario_id, fecha_hora, log_id, accion, evento_id, ip_address, dispositivo, resultado, detalles FROM logs_actividad WHERE usuario_id = ?",
        usuarioId
    );

    statement.SetPageSize(pageSize);

    var rows = await session.ExecuteAsync(statement);

    var result = rows.Select(row => new
    {
        usuario_id = row.GetValue<Guid>("usuario_id"),
        fecha_hora = row.GetValue<DateTimeOffset>("fecha_hora"),
        log_id = row.GetValue<Guid>("log_id"),
        accion = row.GetValue<string>("accion"),
        evento_id = row.GetValue<Guid>("evento_id"),
        ip_address = row.GetValue<string>("ip_address"),
        dispositivo = row.GetValue<string>("dispositivo"),
        resultado = row.GetValue<string>("resultado"),
        detalles = row.GetValue<string>("detalles")
    })
.Take(pageSize)
.ToList();

    return Results.Ok(result);
});

app.MapGet("/api/historial/{usuarioId}", async (CassandraSession session, Guid usuarioId, int pageSize = 10) =>
{
    var statement = new SimpleStatement(
        "SELECT usuario_id, fecha_evento, evento_id, nombre_evento, organizacion, horas_aportadas, estado_asistencia, calificacion FROM historial_participacion WHERE usuario_id = ?",
        usuarioId
    );

    statement.SetPageSize(pageSize);

    var rows = await session.ExecuteAsync(statement);

    var result = rows.Select(row => new
    {
        usuario_id = row.GetValue<Guid>("usuario_id"),
        fecha_evento = row.GetValue<DateTimeOffset>("fecha_evento"),
        evento_id = row.GetValue<Guid>("evento_id"),
        nombre_evento = row.GetValue<string>("nombre_evento"),
        organizacion = row.GetValue<string>("organizacion"),
        horas_aportadas = row.GetValue<int>("horas_aportadas"),
        estado_asistencia = row.GetValue<string>("estado_asistencia"),
        calificacion = row.GetValue<int>("calificacion")
    })
.Take(pageSize)
.ToList();

    return Results.Ok(result);
});

app.Run();