# Volumes
Volumes are separate objects that have their lifecycles decoupled from containers.
This means you can create and manage volumes independently, and they don’t get deleted when their container is deleted.

## Creating and managing Docker volumes
```bash
docker volume create <volume_name> # creates new volumes with the built-in local driver.
```
Locate volume data for docker desktop at `\\wsl.localhost\docker-desktop-data\data\docker\volumes`.
Enter with `\\wsl$` from windows explorer.

| Flag                | Options | Description                               |
|---------------------|---------|-------------------------------------------|
| `-d --driver`       | local   | Specify the driver to use for the volume. |
| `--label tag=local` |         | Add metadata to the volume.               |

Mounting a volume during container creation and deployment. Volume is created here if it is not already existing.
```bash
docker run -it  --name cv --mount source=vol2,target=/vol ubuntu
docker run -it --rm --mount type=volume,src=volo,dst=/var/lib ubuntu
docker run -it --rm --volume source:/var/lib ubuntu
```

## Anonymous Volumes

Create anonymous volumes that are not named during container creation
```bash
docker run -it --name avl --mount type=volume, dst=/var/lib ubuntu # anonymous volume
docker run -it --rm --volumes-from avl ubuntu # reuse anonymous volume by referencing the container
```

## Listing and removing volumes
```bash
docker volume ls # list all volumes
docker volume rm <volume_name> # remove a volume
docker volume prune # remove all volumes
```
