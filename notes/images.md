## Docker Images the Deep Dive
Images contain just enough operating system to run a specific application. They are built in layers, and each layer is
a set of changes to the previous layer. The layers are stacked on top of each other to create the final image.

### Pulling an Image from Docker Hub
To pull an image from Docker Hub, use the `docker pull <image>:<tag>` command or the `docker image pull <image>:<tag>`
If you don't specify a tag, Docker will pull the latest version of the image with the `latest` tag.
To pull from an unofficial repository, you need to specify the username and the repository name.

```bash
docker pull <dockerhub_username>/<repository_name>/<image>:<tag>
```
To pull from other registries than Docker Hub, you need to specify the registry URL.\
```bash
docker pull <registry_url>/<repository_name>/<image>:<tag>
```

### Listing Images
To list the images on your system, use the `docker images` command.\
```bash
docker images
```
Filter images by name or tag using the `--filter` flag.\
```bash
docker images --filter <filter>
docker images --filter dangling=true # List dangling images i.e. images that are no longer tagged
```
Other filters include 
- `before` - List images created before a specific image
- `since` - List images created since a specific image
- `label` - List images with a specific label
- `reference` - List images with a specific reference `docker images --filter=reference="*:latest`
Images listed by the `docker images` command include the image ID, repository, tag, image size, and creation date.\
This output can be filtered using the `--format` flag. This flag takes a Go template as an argument.

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
