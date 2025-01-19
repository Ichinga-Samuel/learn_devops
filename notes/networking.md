
## Intro
Docker networking is based on an open-source pluggable architecture called the **Container Network Model (CNM)**.\
_libnetwork_ is the reference implementation of the CNM, and it provides all of Docker’s core networking capabilities.

## The Container Network Model (CNM)
The CNM has three building blocks
- **Sandbox**: A sandbox is an isolated network stack in a container. It includes Ethernet interfaces, ports, routing tables, and DNS config.
-**Endpoints**: This are virtual network interfaces, the responsible for making connections eg. connecting sandboxes to networks.
- **Networks**: This is a software implementation of a switch, It groups together and isolate a collection of endpoints that need to communicate.

## Drivers
Docker ships with several built-in drivers, known as native drivers or local drivers. These include _bridge_, _overlay_,\
and _macvlan_, and they build the most common network topologies. Every network is owned by a driver, the driver is\
responsible for the creation and management of a network. The name of a network is the same as that of the driver used in creating it.

## Single Host Bridge Network
This spans only a single docker host and can only connect containers that are on the same host.\
It is an implementation of a layer 2 switch 802.1d bridge.\
When two containers are connected to the same bridge network we can ping one from the other

### See all networks
```bash
docker network ls
```
```
Beware: The default bridge network, the one called “bridge”, doesn’t support
name resolution via the Docker DNS service. All other user-defined bridge
networks do.
```
### Port Mappings
With port mapping two containers on different bridge networks can communicate with each other. It allows us to map port
on the container to a host

### Connecting to existing networks with MACVLAN driver
With the **macvlan** driver each container gets its own ip and mac address on the external physical network.\
However, it requires the host NIC to be in promiscuous mode, which isn’t allowed on many corporate networks and public cloud platforms.\
To create a macvlan network additional information for the network plumbing is needed such as `subnet, gateway, ip-range parent
```bash
docker network create -d macvlan \
--subnet=10.0.0.0/24 \
--ip-range=10.0.0.0/25 \
--gateway=10.0.0.1 \
-o parent=eth0.100 \
macvlan100
```

### Service Discovery
This is provided by _libnetwork_ and allows all containers and swarm services to locate each other by name.
This is enabled by the fact that all docker containers have a DNS resolver and the docker DNS server.
However, service discovery is network-scoped, meaning name resolution only works for containers and Services on the same network.
Use the `--dns` and `--dns-search` flags to enable custom dns service and dns domain name search space during container creation.

### Ingress Load Balancing
Swarm services can be published via _ingress_ mode by default or via _host_ mode. Services published via ingress
mode can be accessed from any node in the Swarm even nodes not running a service replica. Services published via host
mode can only be accessed by hitting nodes running service replicas. To specify host mode use the `--published` flag in
long mode. `--published published=<host_port>,target=<container_port>,mode=<host|ingress>`
