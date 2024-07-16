include .env
#export ${shell sed 's/=.*//' .env}

build: 
	@echo "Build docker image..."
	docker build -t ${IMAGE_NAME}:latest .
deploy: build
	@echo "Sending built image to server..."
	docker save ${IMAGE_NAME}:latest | ssh -C ${VPS} docker load
	@echo "Creating remote directory..."
	ssh ${VPS} "mkdir -p ${REMOTE_DIR}/${IMAGE_NAME}"
	@echo "Copying docker-compose.yml to server..."
	rsync -avz docker-compose.prod.yml ${VPS}:${REMOTE_DIR}/${IMAGE_NAME}/docker-compose.yml
	@echo "Starting Docker Compose on server..."
	ssh ${VPS} "cd ${REMOTE_DIR}/${IMAGE_NAME}; docker compose up -d"
	@echo "Deployment complete!"
