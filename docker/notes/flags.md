## Docker command line flags

### Containers
- `docker run:` Creating and running a container
  - `-t or --tty:` Use to run a container in pseudo-TTY mode. This flag is used to run an interactive shell in a container.
  - `-i or --interactive:` Use to run a container in interactive mode. This flag is used to keep STDIN open even if not attached.
  - `-d or --detach:` Use to run a container in detached mode. This flag is used to run a container in the background.
  - `--restart <no|on-failure|always|unless-stopped>`
  - `--mount source=<vol_name>,target=</container_dir>:` Mount a volume during container creation
  - `--network <network_name>:` Attach a network other than the default one.
  - `--name <continer_name>:` A name for the container
  - `-p <host>:<continer>`: Port mapping during container creation in short mode
  - `--published published=<host_port>,target=<container_port>,mode=<host|ingress>`: Port mapping and host specification in long mode.
  - `--dns=8.8.8.8:` Custom domain name service
  - `--dns-search=google.com:` custom domain namespace
- `docker rm:` Removing a container
  - `-f --force:` Force the removal of running container
  - `-l --link:` Remove specified link
  - `-v --volumes:` Remove anonymous volumes associated with container

### Images
- `-a:` Show all images including intermediates
- `-q:` Show image id only 
- `--digests`: Show image digests

### Networks
- `-d <[bridge|overlay|macvlan]>:` Specify network driver
- `--subnet=<subnet>:` Specify subnet when using macvlan driver
- `--parent=<parent>:` Specify parent when using  macvlan driver
- `--ip-range=<ip-range>:` Specify IP Range when using macvlan
- `--gateway=<gateway>:` Specify gateway

### Top level
- `docker build`: Build an image from a docker file
  - `--target <image_name>`: target image for multi-image dockerfile
  - `-f <dockerfile_name>`: dockerfile name to build from
  - `-t <image>:[tag]`:
