# Volumes
Volumes are separate objects that have their lifecycles decoupled from containers.\
This means you can create and manage volumes independently, and they don’t get deleted when their container is deleted.

## Creating and managing Docker volumes
```bash
docker volume create <volume_name> # creates new volumes with the built-in local driver.
```
Mounting a volume during container creation and deployment. Volume is created here if it is not already existing.
```bash
docker run -it --name cv --mount source=vol2,target=/vol ubuntu
```
Locate volume data for docker desktop at `\\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes`
