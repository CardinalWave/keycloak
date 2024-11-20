sleep 15

# Obter token de acesso usando o usuário e senha de administrador
ACCESS_TOKEN=$(curl -s -X POST "http://localhost:8080/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d "password=admin" \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token')

# Buscar o clientId do cliente PythonClient
CLIENT_ID=$(curl -s -X GET "http://localhost:8080/admin/realms/master/clients" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" | jq -r '.[] | select(.clientId=="PythonClient") | .id')

# Capturar o client secret
CLIENT_SECRET=$(curl -s -X GET "http://localhost:8080/admin/realms/master/clients/$CLIENT_ID/client-secret" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" | jq -r '.value')

# Salvar o segredo em um local acessível
echo "CLIENT_SECRET=$CLIENT_SECRET" > /opt/keycloak/client_secret.env

