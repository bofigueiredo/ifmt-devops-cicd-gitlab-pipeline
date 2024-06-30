sshpass -p ${SSH_HOST_DEPLOY_PASS} ssh -o StrictHostKeyChecking=no ${SSH_HOST_DEPLOY_USER}@${SSH_HOST_DEPLOY} << ENDSSH

    docker rm -f $DB_IMAGE $DB_ADMIN_IMAGE $BACKEND_IMAGE $FRONTEND_IMAGE

    docker pull $DOCKER_HUB_USERNAME/$DB_IMAGE:latest
    docker pull $DOCKER_HUB_USERNAME/$BACKEND_IMAGE:latest
    docker pull $DOCKER_HUB_USERNAME/$FRONTEND_IMAGE:latest
    docker pull $DOCKER_HUB_USERNAME/$DB_ADMIN_IMAGE:latest

    docker system prune -f
    docker network create $PROJETCT_NETWORK

    docker run -d --name $DB_IMAGE --network $PROJETCT_NETWORK --network-alias postgresql -e POSTGRES_DB=$POSTGRES_DB -e POSTGRES_USER=$POSTGRES_USER -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD $DOCKER_HUB_USERNAME/$DB_IMAGE:latest
    docker run -d --name $BACKEND_IMAGE  --network $PROJETCT_NETWORK -p 8080:8080 $DOCKER_HUB_USERNAME/$BACKEND_IMAGE:latest
    docker run -d --name $DB_ADMIN_IMAGE --network $PROJETCT_NETWORK -p 8082:8080 $DOCKER_HUB_USERNAME/$DB_ADMIN_IMAGE:latest
    
    docker run -d --name $FRONTEND_IMAGE -p 8081:80 $DOCKER_HUB_USERNAME/$FRONTEND_IMAGE:latest

ENDSSH