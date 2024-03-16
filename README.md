apt-get update && apt-get install pip vim -y

docker image build -t emersonrrd/linuxtips-redis-distroless:1.0 .
docker run -p 6379:6379 --name redis-distroless -d emersonrrd/linuxtips-redis-distroless:1.0

trivy image emersonrrd/linuxtips-redis-distroless:1.0
docker scout cves emersonrrd/linuxtips-redis-distroless:1.0

docker push emersonrrd/linuxtips-redis-distroless:1.0


docker image build -t emersonrrd/linuxtips-giropops-senhas-distroless:1.0 .
docker container run -d --name giropops-senhas-distroless -p 5000:5000 -e REDIS_HOST=10.2.0.2 emersonrrd/linuxtips-giropops-senhas-distroless:1.0 .

trivy image emersonrrd/linuxtips-giropops-senhas-distroless:1.0
docker scout cves emersonrrd/linuxtips-giropops-senhas-distroless:1.0

docker push emersonrrd/linuxtips-giropops-senhas-distroless:1.0



docker rm redis-distroless -f
docker rm giropops-senhas-distroless -f
