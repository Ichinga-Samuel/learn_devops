## Common  Docker Commands

### Containers 
Most docker commands have an alias that has the word `container` before the command
- `docker run -d --name <container_name> <image> [command]`: Create and run a container in daemon mode and an optional command
- `docker ps [-a][-q] | docker container ls`: Show running containers, `-a` flag will show all containers and `-q` will output only ids
- `docker start <name>:` Start a stopped container
- `docker stop <name>:` Stop a running container gracefully
- `docker kill <name>:` Kill a container
- `docker rm <container_name|id>:` Remove a container use `-f` to forcefully remove running containers
- `docker container prune [-f]:` Remove all container `-f` removes without confirmation prompt.
- `docker container attach <container_name>:` Attach terminal to a running container. Use `Ctrl + P + Q` to detach


### Images
- `docker images:`: Show all images on the host
- `docker history <image>:<tag>`: Show the instructions used in building the image.
- `docker image rm <image_name>:<tag>:` Remove an unused image
- `docker rmi <id|name>`: Remove an image
- - `docker build -t <image_name>:<tag> .`: Build an image with the dockerfile in the current directory
- `docker image pull <image>:<tag> | docker pull <image>:<tag>`: Pull an image from the default docker registry
- `docker pull <dockerhub_username>/<repository_name>/<image>:<tag>`: Pull from a personal repository
- `docker pull <registry_url>/<repository_name>/<image>:<tag>`: Pull from another registry
- `docker image prune:` Remove all dangling images, use `--all|-a` and `--force|-f` to remove all unused images and without confirmation prompt  

### Networks
- `docker network create -d <network_type> <name>`: Create a network
- `docker network ls:` See all networks on the host
- `docker network prune:` Remove all unused networks.

### Volume
- `docker volume create <vol_name>`: Create a volume
- `docker volume ls`: See all volumes
- `docker volume rm <vol_name>:` Remove an unmounted volume
- `docker volume prune:` Remove all unmounted volumes

### Top level Commands
- `docker port <container_name>`: Verify port mapping for a container
- `docker inspect <top_level_object>`: Inspect a toplevel object like container, image or volume
- `docker plugin install <plugin>`: install a plugin from docker hub
