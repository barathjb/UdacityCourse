# start docker engine
sudo service docker start
sudo docker run hello-world

# start docker desktop
systemctl --user start docker-desktop
systemctl --user enable docker-desktop 
systemctl --user stop docker-desktop

# docker commands
docker build . -t base-image --no-cache
docker run base-image
docker images
docker image rm -f <imageid>
docker build . -t example-image --build-arg key=value
docker run -e key="value" <imageid>


# ECR auth and push
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 311443963984.dkr.ecr.us-east-1.amazonaws.com
docker tag <REPO NAME>:<TAG> <aws_account_id>.dkr.ecr.region.amazonaws.com/<REPO NAME>:tag
docker push aws_account_id.dkr.ecr.<region>.amazonaws.com/<REPO NAME>:<TAG>

docker pull <REMOTE_DOCKER_IMAGE_PATH>


# to create a repo
aws ecr create-repository --repository-name ex3codebuildrepo --image-tag-mutability IMMUTABLE