sshpass -p ${SSH_BOFIGUEIREDO_PASS} ssh -o StrictHostKeyChecking=no bofigueiredo@172.17.0.1 << ENDSSH

    docker rm --force $DB_IMAGE
    docker rm --force $DB_ADMIN_IMAGE

    docker system prune -f

    docker network create db-network

    docker pull $DOCKER_HUB_USERNAME/$DB_IMAGE:latest
    docker pull $DOCKER_HUB_USERNAME/$DB_ADMIN_IMAGE:latest

    docker run -d --name $DB_IMAGE --network $DB_NETWORK -p 3306:3306 --network-alias mysql $DOCKER_HUB_USERNAME/$DB_IMAGE:latest
    docker run -d --name $DB_ADMIN_IMAGE --network $DB_NETWORK -p 8080:80 $DOCKER_HUB_USERNAME/$DB_ADMIN_IMAGE:latest


ENDSSH