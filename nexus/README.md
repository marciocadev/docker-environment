# Nexus3

# Inicie o container com o comando, abrindo as portas 8081, 8082 e 8083
- docker-compose up -d

Demora um tempo até que o container se inicie, espere uns minutos

# Obtenha o CONTAINER ID
- docker ps
    0cd5d3bf61b8 nexus3

# Entre no container e pegue a senha iniciar do administrador
* docker exec -it 7191939e2ca1  /bin/bash
* cd /nexus-data
* cat admin.password
    - 419760cc-65b4-4074-b80d-188fc54530ca

# Logue a primeira vez com o user e a senha acima, será pedido para alterar a senha

# Acessando a interface do Swagger no Nexus3
- Logue como admin
- Navegue no menu System / API

# Plug-in para APK
* https://github.com/sonatype-nexus-community/nexus-repository-apk