# Docker Images 
Images contain just enough operating system to run a specific application. They are built in layers, and each layer is
a set of changes to the previous layer. The layers are stacked on top of each other to create the final image.

## Pulling an Image from Docker Hub
To pull an image from Docker Hub, use the `docker pull <image>:<tag>` command or the `docker image pull <image>:<tag>`
If you don't specify a tag, Docker will pull the latest version of the image with the `latest` tag.
To pull from an unofficial repository, you need to specify the username and the repository name.

```bash
docker pull <dockerhub_username>/<repository_name>/<image>:<tag>
```
To pull from other registries than Docker Hub, you need to specify the registry URL.
```bash
docker pull <registry_url>/<repository_name>/<image>:<tag>
```

## Listing Images
To list the images on your system, use the `docker images` command.
```bash
docker images
```
| Option                                    | Default | Description                                                |
|-------------------------------------------|---------|------------------------------------------------------------|
| `-a`                                      |         | Show all images including intermediates                    |
| `-q`                                      |         | Show image id only                                         |
| `--digests`                               |         | Show image digests                                         |
| `--filter <before, since, label>=<image>` |         | Filter output based on conditions provided                 |
| `--filter reference=<*:tag>`              |         | Filter output with reference based on tag                  |
| `--filter danglin=true`                   | false   | List dangling images i.e. images that are no longer tagged |


### Image Layers
A docker image is made up of multiple read only layers. We can see the layers of a docker image using the inspect command.
```bash
docker inspect <image_name>
```
All Docker images start with a base layer, and as changes are made and new content is added, new layers are added on top.
All images get a cryptographic content hash which we shall call a hash. Use the `--digests` flag to see the hash.
```bash
docker images --digests
```
The hash is used to uniquely identify the image and its layers. An image can be pulled using the hash instead of the tag.
```bash 
docker pull <image_name>@<hash>
```
In someways a docker image is just a manifest file that describe the layers that make up the image
and each layer is fully independent with no concept of being part of something bigger.

### Multi Architecture Images
Docker images can be built for multiple architectures. This is take care of at the registry level via manifest lists and manifests.
A **manifest list** is a list of **manifests** for different architectures supported by the image.
A **manifest** is a list of layers that make up the image for a specific architecture.
Use `docker buildx` to build multi architecture images.
```bash
docker buildx build --platform linux/arm/v7 -t myimage:arm-v7 .
```

### Deleting Images
To delete an image, use the `docker rmi` command. An image can be deleted by its name or its ID. An image can only be deleted
if it is not being used by a container.
```bash
docker rmi <image_name>
docker rmi <image_id>
docker rmi $(docker images -q) -f # Delete all images. -q flag returns only the image IDs
```

### Image Tagging
An image can have multiple tags. To tag an image, use the `docker tag` command. The tag is in the format `repository:tag`.
```bash
docker tag <image_id> <repository>:<tag>
```

### Image Build 
When building an image, Docker uses the build context to access files and directories. The build context is the directory
where the Dockerfile is located. The build context is sent to the Docker daemon, so it should be kept small.
To specify a different build context, use the `-f` flag with the `docker build` command.
```bash
docker build -f <dockerfile_name> -t <image>:<tag> <build_context>

docker build -t <image>:<tag> . # Use the current directory as the build context
```

## Saving and loading images

Dockers images can be saved to a tarball file and loaded back into the system. This is useful when you want to move an image
from one system to another without pushing it to a registry.

```bash
docker save -o <filename> <image>:[tag]
docker load -i <filename>
```
| Flags | Description                              |
|-------|------------------------------------------|
| `-o`  | Save file instead of streaming to stdout |
| `-i`  | Load from file                           |

## Create Image from a container
```bash
docker container commit <containername> <imagename>
```
| Flag           | Description         |
|----------------|---------------------|
| `-a --author`  | Author of the image |
| `-m --message` | Commit message      |

## Build images from a Dockerfile
```bash
docker build -t <image_name>:<tag> <path_to_dockerfile>
docker build -t <image_name>:<tag> -f <dockerfile_name> <path_to_dockerfile>
```
| Flag          | Description                              |
|---------------|------------------------------------------|
| `-t`          | Tag the image                            |
| `-f`          | Specify the Dockerfile name              |
| `--build-arg` | Pass build arguments to the Dockerfile   |
| `--no-cache`  | Do not use cache when building the image |
