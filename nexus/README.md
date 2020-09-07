# Nexus3

## Inicie o container com o comando, abrindo as portas 8081, 8082 e 8083
- docker-compose up -d

Demora um tempo até que o container se inicie, espere uns minutos

## Entre no container e pegue a senha iniciar do administrador
* docker-compose exec nexus bash
* cd /nexus-data
* cat admin.password
    - 419760cc-65b4-4074-b80d-188fc54530ca

## Logue a primeira vez com o user e a senha acima, será pedido para alterar a senha

## Acessando a interface do Swagger no Nexus3
- Logue como admin
- Navegue no menu System / API

## Pegue o IP no Linux 
- ip addr show

## Cria os repositórios
* create-repository.sh <host> <port>
    ex.: create-repository.sh 127.0.0.1 8081 <user> <password>

# Docker

## Crie a autorização para o docker se comunicar com o nexus:
* echo "<password>" | docker login -u admin --password-stdin 127.0.0.1:8082
* echo "<password>" | docker login -u admin --password-stdin 127.0.0.1:8083
Isto vai criar o arquivo ~/.docker/config.json

## Baixe uma image apontando no Nexus
- docker pull 127.0.0.1:8082/<image>

## Configurar o docker para enviar suas imagens para o Nexus
### Permite que o docker se comunique com HTTP inves de HTTS

Coloque no /etc/docker/daemon.json o seguinte código:
<code>
{
  "insecure-registries": [
    "127.0.0.1:8082",
    "127.0.0.1:8083"
  ]
}
</code>

### Reinicie o docker
- sudo systemctl restart docker



To push your own images to your repo, you have to tag the image with a tag that points to the repo. This is strange to me, since I was trying to think about Docker tags the same way I do about Git tags, but they seem be somewhat different (notice port 8083 being used):

* docker tag your-own-image:1 your-repo:8083/your-own-image:1
* docker push your-repo:8083/your-own-image:1
To pull your own images from the repo, you can use:

* docker tag your-own-image:1 your-repo:8082/your-own-image:1
or
* docker tag your-own-image:1 your-repo:8083/your-own-image:1

Both ports will work. I suspect that is because using port 8083 will connect directly to the hosted repo, whilst using port 8082 will connect to the group repo, which contains the hosted repo. I suggest you to stick to port 8083 to avoid duplicate images in your machines. If you chose to stick with port 8083 to pull your own images, you probably could skip creating the group repo, if you prefer.




# Plug-in para APK
* https://github.com/sonatype-nexus-community/nexus-repository-apk


## APT

