#!/bin/sh

# Criar diretórios necessários e ajustar permissões
mkdir -p /var/lib/mysql /var/log/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/log/mysql /run/mysqld

# Inicializar o banco de dados (somente se não estiver inicializado)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando o banco de dados..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "Banco de dados inicializado."
fi

# Inicializar o MariaDB
mysqld_safe --datadir=/var/lib/mysql &

# Espera o MySQL inicializar
sleep 10

# Configurar o banco de dados
mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${DB_NAME};
        CREATE USER IF NOT EXISTS '${ADMIN_NAME}'@'%' IDENTIFIED BY '${ADMIN_PASSWORD}';
        GRANT ALL ON ${DB_NAME}.* TO '${ADMIN_NAME}'@'%';
        FLUSH PRIVILEGES;
EOSQL

# Manter o processo do MariaDB em execução
wait