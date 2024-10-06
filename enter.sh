#!/bin/bash

# Start the docker-compose service
# docker compose up -d

# Enter the running container
docker exec -it ubuntu_server bash -c "cd /root && exec bash"
