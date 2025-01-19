# Network

## List all network
```bash
docker network ls
```

## create a network
```bash
docker network create <network_name>
```
| Flag       | Options          |Description|
|------------|------------------|-----------|
| `--driver` | bridge           |Specify the driver to use for the network.|
| `--label`  | tag=local        |Add metadata to the network.|
| `--scope`  | local            |Specify the scope of the network.|
| `--attachable`|                  |Specify if the network is attachable.|
| `--ingress`|                  |Specify if the network is an ingress network.|
|`--subnet`| **10.0.42.0/24** |Specify the subnet for the network.|
|`ip-range`| **10.0.42.128/25|Specify the ip range for the network.|

## Connect to an existing network
This won't work for host or none networks. A container can be connected to multiple bridge networks, but a container
connected to host or none network can't be connected to another network.
```bash
docker network connect <network_name> <container_name> # connect a container to a bridge network
```

## Port Mappings
Map host port to container port during container creation, with the `-p` flag in short mode or `--publish` in long mode.
```bash
docker run -it --name <container_name> -p <host_port>:<container_port> <image_name>
docker run -it --name <container_name> --publish <container_port> <image_name> # host port is random
docker port <container_name> # show port mappings for a container
```
