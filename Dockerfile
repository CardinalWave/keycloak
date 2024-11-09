FROM quay.io/keycloak/keycloak:latest

COPY config/ /opt/jboss/keycloak/standalone/configuration/
COPY scripts/ /opt/jboss/keycloak/custom-scripts/
COPY realm-export.json /opt/jboss/keycloak/data/import/

ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin

EXPOSE 8080

ENTRYPOINT ["/opt/jboss/keycloak/bin/kc.sh", "start", "--import-realm"]

