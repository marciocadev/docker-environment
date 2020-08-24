# Nexus3

# Inicie o container com o comando, abrindo as portas 8081, 8082 e 8083
- docker-compose up -d

Demora um tempo até que o container se inicie, espere uns minutos

# Entre no container e pegue a senha iniciar do administrador
* docker-compose exec nexus bash
* cd /nexus-data
* cat admin.password
    - 419760cc-65b4-4074-b80d-188fc54530ca

# Logue a primeira vez com o user e a senha acima, será pedido para alterar a senha

# Acessando a interface do Swagger no Nexus3
- Logue como admin
- Navegue no menu System / API

# Plug-in para APK
* https://github.com/sonatype-nexus-community/nexus-repository-apk

# Cria os repositórios
* create-repository.sh <host> <port>
    ex.: create-repository.sh 192.168.15.13 8081

Configuring your clients and projects to use your Nexus repos
To interact with your repo, the first thing is to configure the Docker daemon in your machine to accept working with HTTP instead of HTTPS.

How exactly to do this config depends on your operating system, so you should check dockerd documentation. On RHEL I did it putting this content in /etc/docker/daemon.json:
{
  "insecure-registries": [
    "your-repo:8082",
    "your-repo:8083"
  ]
}
You have to restart the daemon after setting this (sudo systemctl restart docker).

# Now we have to authenticate your machine to the repo with:
* echo "sofiA2011" | docker login -u admin --password-stdin 192.168.15.13:8082
* echo "sofiA2011" | docker login -u admin --password-stdin 192.168.15.13:8083
This will create an entry in ~/.docker/config.json

# To pull images from your repo, use (notice port 8082 being used):
docker pull your-repo:8082/alpine

To push your own images to your repo, you have to tag the image with a tag that points to the repo. This is strange to me, since I was trying to think about Docker tags the same way I do about Git tags, but they seem be somewhat different (notice port 8083 being used):

* docker tag your-own-image:1 your-repo:8083/your-own-image:1
* docker push your-repo:8083/your-own-image:1
To pull your own images from the repo, you can use:

* docker tag your-own-image:1 your-repo:8082/your-own-image:1
or
* docker tag your-own-image:1 your-repo:8083/your-own-image:1

Both ports will work. I suspect that is because using port 8083 will connect directly to the hosted repo, whilst using port 8082 will connect to the group repo, which contains the hosted repo. I suggest you to stick to port 8083 to avoid duplicate images in your machines. If you chose to stick with port 8083 to pull your own images, you probably could skip creating the group repo, if you prefer.
