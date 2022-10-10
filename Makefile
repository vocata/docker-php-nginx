TAG            = 1.0.0
IMAGE_NAME     = mangydog/php-nginx-laravel
TMP_IMAGE_NAME = test-php-nginx-laravel
CONTAINER_NAME = php-nginx-laravel
DOCKERFILE     = ./Dockerfile
DOCKER_CONTEXT = .

$(IMAGE_NAME): Dockerfile
	docker build -f $(DOCKERFILE) -t $(IMAGE_NAME):$(TAG) $(DOCKER_CONTEXT)

.PHONY: run push test clean
run: 
	docker build -f $(DOCKERFILE) -t $(IMAGE_NAME):$(TAG) $(DOCKER_CONTEXT)
	docker run -p 80:8080 -d --name $(CONTAINER_NAME) $(IMAGE_NAME):$(TAG)

push:
	docker push $(IMAGE_NAME):$(TAG)

test:
	docker build -f $(DOCKERFILE) -t $(TMP_IMAGE_NAME) $(DOCKER_CONTEXT)
	docker run -it $(TMP_IMAGE_NAME) /bin/sh
	docker rmi -f $(TMP_IMAGE_NAME)

clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME):$(TAG)


