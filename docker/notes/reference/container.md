# Container Commands

## Create and run a container

Create start and run a container using the `docker run` command.
```bash
docker run --name <container_name> [-it] <image_name>:<tag> [command]
```
| Flag                                                         | Options | Description                                          |
|--------------------------------------------------------------|---------|------------------------------------------------------|
| `-it`                                                        |         | Run the container in interactive mode                |
| `-d --daemon`                                                |         | Run the container in detached mode                   |
| `--link <container_name>:<alias>`                            |         | Link the container to another container              |
| `--name <name>`                                              |         | Assign a name to the container                       |
| `--rm`                                                       |         | Remove the container when it exits                   |
| `--read-only`                                                |         | Mount the container in read-only mode                |
| `--cidfile <file>`                                           |         | Write the container ID to a file                     |
| `-e --env <key=value>`                                       |         | Set environment variables                            |
| `--restart <no\|on-failure\|always \|unless-stopped>`        |         | Restart policy for the container                     |
| `-p or --publish <host_port>:<container_port>`               |         | Port mapping                                         |
| `--mount type=bind,source=<host_dir>,target=<container_dir>` |         | Bind mount a host directory to a container directory |
| `--mount type=tmpfs,dst=/tmpf,tmpfs-size=1G,tmpfs-mode=1777` |         | Mount a tmpfs volume                                 |
| `--mount source=vol2,target=/vol`                            |         | Mount a volume during container creation             |
| `--mount type=volume,src=vol2,dst=/vol`                      |         | Mount a volume during container creation             |
| `--volume <sourcevolume>:<target mount>`                     |         | Mount a volume during container creation             |
| `--network <network_name> or host or none`                   |         | Attach a network other than the default one          |
| `hostname`                                                   |         | Set the hostname of the container                    |
| `--dns`                                                      |         | Set the dns server for the container                 |
| `--dns-search docker.com`                                    |         | Set the dns search domain for the container          |

## List all containers
```bash
docker ps
docker container ls
```
| Flag          | Description                                |
|---------------|--------------------------------------------|
| `-a`          | Show all containers including stopped ones |
| `-q`          | Show only container IDs                    |
| `-l --latest` | Show the latest created container          |
| `-n <number>` | Show the last n created containers         |

## Restart a container
```bash
docker restart <container_name>
```

## Execute a command in a container
Execute a command in a running container. The flags are mostly the same as the `docker run` command flag
```bash
docker exec [flags] <container_name> <command>
```

## Run a container with host namespace
```bash
docker run --pid host <image_name> [command]
```

## Rename a container
```bash
docker rename <old_name> <new_name>
```

## See the processes running in a container
```bash
docker top <container_name>
```

## remove a container
```bash
docker rm <container_name| container_id>
```

## attach terminal to a container
```bash
docker attach <container_name>
```

## Stop a container
```bash
docker stop <container_name>
```

## remove a container
```bash
docker rm <container_name>
```
| Flag           | Description                                                |
|----------------|------------------------------------------------------------|
| `-f --force`   | Force remove a running container                           |
| `-v --volumes` | Remove the anonymous volumes associated with the container |

## Status of a container
```bash
docker container inspect <container_name>
docker inspect -f "{{json .State}}" <container_name>
```

## Remove all stopped containers
```bash
docker container prune [-f] # -f flag to force remove
```
