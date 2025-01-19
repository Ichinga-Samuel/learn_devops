# Storage in Docker

## Bind Mount

Bind mounts are used to mount a host file or directory into a container. This allows the container to read and write
to the host file system. It is done during container creation with the `--mount` flag.

```bash
docker run -it --name binding --mount type=bind,source="$(pwd)",target=/src ubuntu bash
```

## In memory storage

In-memory storage is used to store data in memory. It is useful for temporary data storage. It is done during
container creation with the `--mount` flag with the `tmpfs` type.

```bash
docker run -it --name in_memory --mount type=tmpfs,dst=/tmpf ubuntu bash
# size and mode can be specified
docker run -it --name in_memory --mount type=tmpfs,dst=/tmpf,tmpfs-size=1G,tmpfs-mode=1777 ubuntu bash
```

## Volume
Docker volumes are named filesystem trees managed by Docker.
```bash
docker volume create vol1
```
