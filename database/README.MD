# DATABASES

## MONGODB

```
  volumes:
    mymongodata:
  
  services:
    mongo:
      image: mongodb/mongodb-community-server:latest
      restart: unless-stopped
      ports: 
        - 0.0.0.0:27018:27017
        - 0.0.0.0:28018:28017
      volumes:
        - mymongodata:/data/db
      environment:
          - MONGO_INITDB_DATABASE:admin
          - MONGO_INITDB_ROOT_USERNAME=root
          - MONGO_INITDB_ROOT_PASSWORD=mongorootpwd
          - bind_ip=::,0.0.0.0
  
    express:
      image: mongo-express
      environment:
        - ME_CONFIG_MONGODB_SERVER=mongo
        - ME_CONFIG_BASICAUTH_USERNAME=avmesquita
        - ME_CONFIG_BASICAUTH_PASSWORD=123@Mudar
        - ME_CONFIG_MONGODB_ENABLE_ADMIN=true
        - ME_CONFIG_MONGODB_ADMINUSERNAME=root
        - ME_CONFIG_MONGODB_ADMINPASSWORD=mongorootpwd
        - ME_CONFIG_MONGODB_PORT=27017
        - ME_CONFIG_SITE_SSL_ENABLED=false
      ports:
        - 8081:8081
```

## MS SQL SERVER

```
  services:
    sqlserver:
      image: mcr.microsoft.com/mssql/server:2019-latest
      container_name: MS-SQL-SERVER
      ports:
        - 1433:1433
      extra_hosts:
        - "host.docker.internal:host-gateway"
      environment:
        - ACCEPT_EULA=Y
        - MSSQL_SA_PASSWORD=mssqlsapassword
        - MSSQL_PID=Standard
        - MSSQL_AGENT_ENABLED=true
```

## MYSQL SERVER

```
  services:
    db:
        image: mariadb
        restart: always
        environment:
        MARIADB_ROOT_PASSWORD: mysql-root-password
  
    adminer:
      image: adminer
      restart: always
      ports:
        - 8081:8080
  
    phpmyadmin:
        image: docker.io/phpmyadmin
        container_name: PHP_My_Admin
        ports:
            - 8080:80
        extra_hosts:
            - "host.docker.internal:host-gateway"
        volumes:
            - pma_sessions:/sessions
            - pma_themes:/www/themes/themes/ phpmyadmin/phpmyadmin
            - pma_config:/etc/phpmyadmin/config.user.inc.php
            - pma_app_root:/etc/phpmyadmin
        environment:
            - PMA_ARBITRARY=1
            - MYSQL_ROOT_PASSWORD=mysql-root-password
            - PMA_HOSTS=db,host.docker.internal
            - PMA_PORT=3306
            - ZeroConf=false
            - CONFIGURATION_STORAGE_ENABLE=true
            - CONFIGURATION_STORAGE_DB_HOST=db
            - CONFIGURATION_STORAGE_DB_PORT_NUMBER=3306
            - CONFIGURATION_STORAGE_DB_USER=your-user
            - CONFIGURATION_STORAGE_DB_PASSWORD=mysql-root-password
            - CONFIGURATION_STORAGE_DB_NAME=phpmyadmin
  
  volumes:
    pma_sessions:
      driver: local
    pma_themes:
      driver: local
    pma_config:
      driver: local
    pma_app_root:
      driver: local
```

## POSTGRES

```
  services:
    db:
      image: postgres
      restart: always
      volumes:
        - pgdata:/var/lib/postgresql/data
      ports:
        - 5432:5432
      environment:
        POSTGRES_PASSWORD: p057gr35-pwd
        POSTGRES_HOST_AUTH_METHOD: trust
  
  volumes:
    pgdata:
```


## SQLITE SERVER

```
  services:
    sqlite-container:
      image: alpine:latest
      volumes:
        - ./database:/data
      command: sh -c "apk --no-cache add sqlite && cp /data/initial-db.sqlite /data/db.sqlite && sqlite3 /data/db.sqlite < /data/init.sql && tail -f /dev/null"
      container_name: sqlite-container
  
    sqlitebrowser:
      image: linuxserver/sqlitebrowser
      ports:
        - "3000:3000"
      depends_on:
        - sqlite-container
      environment:
        - PUID=1000
        - PGID=1000
        - TZ=UTC
        - ENABLE_UWSGI=true
      volumes:
        - sqlite_data:/data/db
      container_name: sqlitebrowser
  
  volumes:
    sqlite_data:
```
