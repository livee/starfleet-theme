This project is designed for developing Starfleet theme for keycloak

## How to start
### Variant 1
1. `docker-compose up -d` 
2. `docker ps -a` and find container with 'starfleet-theme_keycloak_*' name
3. Copy default **base** theme to project `docker cp <container_name>:/opt/jboss/keycloak/themes/base ./themes`
4. Copy default **keycloak** theme to project
   `docker cp <container_name>:/opt/jboss/keycloak/themes/keycloak ./themes`
5. Copy modified for development standalone.html to keycloak
   `docker cp standalone.xml <container_name>:/opt/jboss/keycloak/standalone/configuration/standalone.xml`
6. Copy modified for development standalone-ha.html to keycloak
   `docker cp standalone-ha.xml <container_name>:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml`

### Variant 2
1. `docker run -d --name postgres -e DB_ADDR=postgres -v /var/lib/postgresql/data --net keycloak-network -e POSTGRES_DB=keycloak -e POSTGRES_USER=keycloak -e POSTGRES_PASSWORD=password postgres`
2. `docker run -d -p 8080:8080 -p 8443:8443 --name keycloak -e DB_VENDOR=postgres -e DB_ADDR=postgres -e DB_USER=keycloak -e DB_DATABASE=keycloak -e DB_PASSWORD=password -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=password -v "D:\projects\starfleet-theme\themes\starfleet:/opt/jboss/keycloak/themes/starfleet"  --net keycloak-network jboss/keycloak:14.0.0`
3. Items 3 - 6 from **Variant 1**
