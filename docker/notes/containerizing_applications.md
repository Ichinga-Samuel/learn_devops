# The Dockerfile
The dockerfile is a template for creating images. It consists for a series of instructions that are executed in order
to create the image. It is a text file that contains all the commands a user could call on the command line to assemble an image. 
The instructions are case-insensitive but are written in uppercase. 

## Building an image
To build an image from a dockerfile, use the `docker build` command. The command requires the path to the directory
containing the dockerfile. The command will build the image and tag it with the name provided.
```bash
docker build -t <image_name> <path_to_dockerfile> # it is common to use the current directory
```

## Anatomy of a Dockerfile
Dockerfiles normally start with the FROM instruction. This pulls an image that will be
used as the base layer for the image the Dockerfile will build – everything else will be
added as new layers above this base layer. 

## Multi-stage builds
Multi-stage builds are a feature of docker that allows you to create a build environment and then copy the artifacts
to a new image. This allows you to keep the final image small and only include the necessary artifacts.
```dockerfile
FROM <base_image> AS <stage_name>
# build the application
FROM <base_image>
COPY --from=<stage_name> /app /app
```
A sample multi-stage build for a Go application:
```dockerfile
FROM golang:1.20-alpine AS base
WORKDIR /src 
# after creating a working directory it can be refered to as .
COPY go.mod go.sum .
RUN go mod download
COPY . .
FROM base AS build-client
RUN go build -o /bin/client ./cmd/client
FROM base AS build-server
RUN go build -o /bin/server ./cmd/server
FROM scratch AS prod
COPY --from=build-client /bin/client /bin/
COPY --from=build-server /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]
```
A dockerfile can also be used to build multiple images. This is done by using the `FROM` instruction multiple times
and providing `ENTRYPOINT` for each image.

```dockerfile
FROM golang:1.20-alpine AS base
WORKDIR /src
COPY go.mod go.sum .
RUN go mod download
COPY . .
FROM base AS build-client
RUN go build -o /bin/client ./cmd/client

FROM base AS build-server
RUN go build -o /bin/server ./cmd/server

FROM scratch AS prod-client
COPY --from=build-client /bin/client /bin/
ENTRYPOINT [ "/bin/client" ]

FROM scratch AS prod-server
COPY --from=build-server /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]
```
Use the target flag to specify the image to build from
```bash
docker build -t multi:client --target prod-client -f Dockerfile-final .
docker build -t multi:server --target prod-server -f Dockerfile-final .
```

### Speeding up the build process with caching and squashing
Docker uses a cache to speed up the build process. It will cache the results of each instruction and reuse them 
if the instruction has not changed. To invalidate the cache, use the `--no-cache` flag. Docker invalidates the cache
for the rest of the build process once it encounters a cache miss. 
Squashing is a technique used to reduce the size of the image by combining all the layers into a single layer.
To squash the image, use the `--squash` flag. This will reduce the size of the image but will make it harder to 
debug the image and will make it harder to reuse the layers.
