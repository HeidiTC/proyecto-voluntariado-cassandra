# Script de backup local para Cassandra
# Proyecto: Plataforma de Voluntariado Comunitario

$containerName = "voluntariado-cassandra"
$keyspaceName = "voluntariado"
$backupDate = Get-Date -Format "yyyyMMdd_HHmmss"
$localBackupPath = "..\backups\backup_$backupDate"

Write-Host "Creando carpeta local de backup..."
New-Item -ItemType Directory -Force -Path $localBackupPath | Out-Null

Write-Host "Ejecutando snapshot en Cassandra..."
docker exec $containerName nodetool snapshot $keyspaceName

Write-Host "Copiando archivos de datos respaldados desde el contenedor..."
docker cp "${containerName}:/var/lib/cassandra/data/$keyspaceName" "$localBackupPath"

Write-Host "Backup finalizado correctamente."
Write-Host "Ubicación del backup local: $localBackupPath"