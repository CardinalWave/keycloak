FROM quay.io/keycloak/keycloak:latest

#COPY config/ /opt/jboss/keycloak/standalone/configuration/
#COPY scripts/ /opt/jboss/keycloak/custom-scripts/
COPY realm-export.json /opt/keycloak/data/import/
COPY capture_client_secret.sh  /opt/keycloak/data/capture_client_secret.sh
USER root
RUN chmod +x /opt/keycloak/data/capture_client_secret.sh

ENV KC_KEYCLOAK_USER=admin
ENV KC_KEYCLOAK_PASSWORD=admin
ENV KC_BOOTSTRAP_ADMIN_USERNAME=admin
ENV KC_BOOTSTRAP_ADMIN_PASSWORD=admin

EXPOSE 5010
EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]