#!/bin/bash

echo "Setting up ansible lab......"

select_os() {
    echo "Select OS"
    read -p "Enter OS (debian/mac): " os
    os=$(echo "$os" | tr '[:upper:]' '[:lower:]')

    if [ "$os" = "debian" ]; then
        echo "Debian selected"
    elif [ "$os" = "mac" ]; then
        echo "MAC selected"
    else
        echo "Invalid OS!"
        exit 1
    fi
}

option="$1"

start() {
    docker-compose up -d
    echo "Lab environment has been spun up!"
    echo "Create a new terminal and run 'docker exec -it host bash' to access the ansible control node"
    echo ""
    docker logs --follow host
}

stop() {
    docker-compose down
    echo "Lab environment has been torn down!"
}

status() {
    docker-compose ps
}

clean() {
    docker-compose down
    echo "Lab environment has been torn down!"
    docker system prune -a -f
    echo "Docker system has been cleaned!"
}

init() {
    select_os

    if [ "$os" = "debian" ]; then
        sudo apt update
        sudo mkdir keys
        sudo ssh-keygen -t rsa -b 4096 -C "ansible-lab" -f keys/id_rsa -N ""
        sudo apt install docker.io -y || { echo "Docker installation failed!"; exit 1; }
        sudo apt install docker-compose -y || { echo "Docker Compose installation failed!"; exit 1; }
        echo "Docker and Docker Compose installed successfully!"
    fi

    if [ "$os" = "mac" ]; then
        mkdir keys
        ssh-keygen -t rsa -b 4096 -C "ansible-lab" -f keys/id_rsa -N ""
        brew install docker || { echo "Docker installation failed!"; exit 1; }
        brew install docker-compose || { echo "Docker Compose installation failed!"; exit 1; }
        echo "Docker and Docker Compose installed successfully!"
        brew install ansible || { echo "Ansible installation failed!"; exit 1; }
        echo "Ansible installed successfully!"
    fi
}

if [ "$option" = "start" ]; then
    start
elif [ "$option" = "stop" ]; then
    stop
elif [ "$option" = "status" ]; then
    status
elif [ "$option" = "init" ]; then
    init
elif [ "$option" = "clean" ]; then
    clean
else
    echo "Usage: $0 {start|stop|status|init|clean}"
    exit 1
fi