# Anatomy of a Dockerfile

A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble
an image. Using `docker build`, users can create an automated build that executes several command-line instructions
in succession.

## Format

A Dockerfile consists of a set of instructions that define the image. Each instruction is a command followed by
arguments. The instructions are executed in order from top to bottom.

```Dockerfile
# Comment line 
INSTRUCTION arguments
```    

## FROM

The `FROM` instruction initializes a new build stage and sets the Base Image for subsequent instructions. A valid
Dockerfile must start with a `FROM` instruction. The image can be any valid image, and it can be local or from a
registry. It can be preceded by one or more ARGS commands.

```Dockerfile
FROM ubuntu:20.04
# platform is optional and defaults to the local platform.
# image can be referenced by name, tag, or digest. and can be renamed using the AS keyword
FROM [--platform=<platform>] <image> [AS <name>]
# by tag, defaults to latest
FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]
# by digest
FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]
```
FROM can be used multiple times and Each FROM instruction clears any state created by previous instructions.

## LABEL

The `LABEL` instruction adds metadata to an image. A LABEL is a key-value pair. To add multiple labels, use multiple
`LABEL` instructions.

```Dockerfile
LABEL maintainer="John Doe "
LABEL version="1.0"
# multiple labels on one line
LABEL "com.example.vendor"="ACME Incorporated" "com.example.label-with-value"="foo"
```

## RUN
The RUN instruction will execute any commands to create a new layer on top of the current image. 
RUN has two forms: shell and exec
```Dockerfile
# shell form
RUN [OPTIONS] <command>

# exec form
RUN [options] ["<command>", "param1", "param2", ...]
# cache invalidation
# will cache the update and install
RUN apt-get update && apt-get install -y curl 
# will not cache the update and install
RUN apt-get update && apt-get install -y curl --no-cache 
```

## CMD

The `CMD` instruction provides defaults for an executing container. There can only be one CMD instruction in a Dockerfile.
If you list more than one CMD, then only the last CMD will take effect.

```Dockerfile
# exec form, this is the preferred form
# this runs the executable with the parameters
CMD ["executable","param1","param2"]
# use cmd default parameters for an ENTRYPOINT 
CMD ["param1","param2"] 
# shell form
CMD command param1 param2
```
user specified command will override the default CMD but not the ENTRYPOINT. when used together CMD and ENTRYPOINT 
should be used in exec form.

## ENV

The `ENV` instruction sets the environment variable `<key>` to the value `<value>`. This value will be in the environment
for all subsequent instructions in the build stage and the resulting image.

```Dockerfile
ENV <key>=<value>
# multiple environment variables
ENV <key>=<value> <key1>=<value1>
# environment variable with spaces
ENV <key>="<value with spaces>"
# environment variable without = sign
ENV <key> <value>
```
ENV variables can be used in other instructions using the `${<key>}` syntax. It can be changed when running a container
using the `--env` flag.

## ADD
The `ADD` instruction copies new files, directories, or remote file URLs from `<src>` and adds them to the filesystem of
the image at the path `<dest>`. It has two forms: `ADD <src>... <dest>` and `ADD ["<src>",... "<dest>"]`.

```Dockerfile
ADD <src>... <dest>
# use for paths with spaces
ADD ["<src>",... "<dest>"]
# copy a file from the host to the container
# source files are copied relative to the build context
ADD test.txt /app/
# copy multiple files, the destination must be a directory and must end with /
ADD test1.txt test2.txt /app/
# copy a directory
ADD testdir /app/
# copy a file from a URL
ADD http://example.com/test.txt /app/
```
if the source is a directory, the contents are copied from the source directory but not the directory itself
If the destination path doesn't begin with a leading slash, it's interpreted as relative to the working directory of
the build container. if it begins with a forward slash, it's interpreted as an absolute path.
If destination doesn't exist, it's created, along with all missing directories in its path.

## COPY 

The `COPY` instruction copies new files or directories from `<src>` and adds them to the filesystem of the container at
the path `<dest>`. It has two forms: `COPY <src>... <dest>` and `COPY ["<src>",... "<dest>"]`.

```Dockerfile
COPY <src>... <dest>
# use for paths with spaces
COPY ["<src>",... "<dest>"]
# copy from a build stage
COPY --from=0 /app/ /app/
```

## ARG

The `ARG` instruction defines a variable that users can pass at build-time to the builder with the `docker build` command
using the `--build-arg <varname>=<value>` flag. If a variable is defined without a value, the value will be empty.
If an ARG instruction has a default value and if there is no value passed at build-time, the builder uses the default.

```Dockerfile
ARG <name>[=<default value>]
```

## ENTRYPOINT

The `ENTRYPOINT` instruction allows you to configure a container that will run as an executable. It has two forms:
`ENTRYPOINT ["executable", "param1", "param2"]` (exec form) and `ENTRYPOINT command param1 param2` (shell form).
The exec form of ENTRYPOINT to set fairly stable default commands and arguments and then use either form of CMD to set
additional defaults that are more likely to be changed. The default entrypoint is `/bin/sh`

```Dockerfile
# exec form
ENTRYPOINT ["executable", "param1", "param2"]

# shell form
ENTRYPOINT command param1 param2
```

## WORKDIR

The `WORKDIR` instruction sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions
that follow it in the Dockerfile. If the directory doesn't exist, it will be created.

```Dockerfile
WORKDIR /path/to/workdir
```

## SHELL

The `SHELL` instruction allows the default shell used for the shell form of commands to be overridden. The default shell
on Linux is `/bin/sh -c` and on Windows is `cmd /S /C`.

```Dockerfile
SHELL ["executable", "parameters"]
```

## EXPOSE

The `EXPOSE` instruction informs Docker that the container listens on the specified network ports at runtime. It does not
make the ports of the container accessible to the host.

```Dockerfile
# the default protocol is TCP
EXPOSE <port> [<port>/<protocol>...]
EXPOSE 80/tcp
EXPOSE 80/udp
```

## VOLUME

The `VOLUME` instruction creates a mount point with the specified name and marks it as holding externally mounted volumes
from native host or other containers. It can be used to share data between the host and the container.

```Dockerfile
VOLUME /path/to/volume
VOLUME ["/data"]
```

## USER

The `USER` instruction sets the user name or UID to use when running the image. The user can be specified by its name or
by its UID. When using a UID, the user does not need to exist in the container.

```Dockerfile
USER <user>[:<group>]
USER <UID>[:<GID>]
```
