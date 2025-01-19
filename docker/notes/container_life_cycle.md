## Containers
Containers perform OS virtualization — they carve OS resources into virtual versions called containers.


Stop a container using the `docker stop` command.
```bash
docker stop <container_name>
```
Start a stopped container using the `docker start` command.
```bash
docker start <container_name>
```
List running containers using the `docker ps` command.
```bash
docker ps
docker ps -a # List all containers
```
Restart a container using the `docker restart` command.
```bash
docker restart <container_name>
```
Force stop a container using the `docker kill` command.
```bash
docker kill <container_name>
```
Pause a running container using the `docker pause` command.
```bash
docker pause <container_name>
```
Unpause a paused container using the `docker unpause` command.
```bash
docker unpause <container_name>
```
Remove a stopped container using the `docker rm` command.
```bash
docker rm <container_name>
```
Remove all stopped containers using the `docker container prune` command.
```bash
docker container prune [-f] # -f flag to force remove
```

### Docker Restart Policies
Docker containers can be configured to restart automatically when they exit as a self-healing mechanism. 
Use the `--restart` flag with the `docker run` command to set the restart policy. They can also be specified in configuration files.
The restart policy can be set to either of the following.
 
- `always` - Always restart the container, unless explicitly stopped. Restarting the Docker daemon will restart the container 
even if it was in the stopped state and explicitly stopped.
```bash
docker run --restart always <image_name>
```
 
- `unless-stopped` - Always restart the container, unless explicitly stopped. Restarting the Docker daemon will not restart the container.
```bash
docker run --restart unless-stopped <image_name>
```

- `on-failure` - Restart the container only if it exits with a non-zero status. It will also restart a stopped container 
during daemon restart.
```bash
docker run --restart on-failure <image_name>
```

- `no` - Do not restart the container. This is the default restart policy.
```bash
docker run --restart no <image_name>
```
Inspect a container to see the restart policy using the `docker inspect` command.
```bash
docker inspect <container_name> --format '{{.HostConfig.RestartPolicy.Name}}'
```
