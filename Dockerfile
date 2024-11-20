FROM quay.io/keycloak/keycloak:latest

#COPY config/ /opt/jboss/keycloak/standalone/configuration/
#COPY scripts/ /opt/jboss/keycloak/custom-scripts/
COPY realm-export.json /opt/keycloak/data/import/
COPY capture_client_secret.sh /opt/keycloak/
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_KEYCLOAK_USER=admin
ENV KC_KEYCLOAK_PASSWORD=admin
ENV KC_BOOTSTRAP_ADMIN_USERNAME=admin
ENV KC_BOOTSTRAP_ADMIN_PASSWORD=admin
ENV KC_LOG_LEVEL=DEBUG

EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm", "--hostname-strict", "false"]
