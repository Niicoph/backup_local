#!/bin/bash

# Solicitar al usuario los datos de la base de datos
read -p "db_username: " DB_USER
read -s -p "db_password: " DB_PASS
echo # Salto de línea después de la entrada de la contraseña
read -p "db_name: " DB_NAME
read -p "docker_container_name: " CONTAINER_NAME
read -p "backup_directory: " BACKUP_DIR
read -p "backup_name: " BACKUP_NAME  

# Nombre del archivo de respaldo
BACKUP_FILE="$BACKUP_DIR/$BACKUP_NAME$(date +'%Y%m%d_%H%M%S').sql"


# Comando para realizar el respaldo dentro del contenedor Docker
docker exec $CONTAINER_NAME mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

# Verificar si el respaldo fue exitoso
if [ $? -eq 0 ]; then
    echo "Backup succesfully at $BACKUP_FILE"
else
    echo "Error"
fi