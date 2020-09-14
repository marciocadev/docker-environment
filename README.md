# docker-environment
Environment for development with Docker

## Subir todos as imagens
> docker-compose up -d

## Subir um serviço específico
- Ex.: subindo o **postgres** e o **pgadmin**
> docker-compose up -d postgres pgadmin

## Verificando os logs de um serviço específico
- Ex.: logs do **postgres**
> docker logs -f postgres
