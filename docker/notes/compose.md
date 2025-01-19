## What is Compose
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to\
configure your application’s services. Then, with a single command, you create and start all the services from your\
configuration.

### Ensure That Compose is Available
```bash
docker compose version
```

### Examining the Compose File
The docker compose file is a YAML file that contains the configuration for the services that make up the application.\
It is used to define the services, networks, volumes and other top level components that make up the application.
```yaml
services:
    web-fe:
      build: .
      command: python app.py
      ports:
        - target: 8080
          published: 5001
    networks:
      - counter-net
    volumes:
      - type: volume
        source: counter-vol
        target: /app
    
    redis:
        image: "redis:alpine"
        networks:
          - counter-net:
networks:
  counter-net:

volumes:
  counter-vol:
```
This sample compose file defines two services, `web-fe` and `redis`. One volume and one network are also defined.
- `build:` is used to build the image with a dockerfile from the current directory.
- `command:` is used to specify the command to run when the container starts.
- `ports:` is used to map the container port to the host port. The target is the container port and the published is the host port.
- `networks:` is used to specify the networks that the service should be connected to. The networks are defined at the top level or existing networks can be used.
- `volumes:` is used to specify the volumes that the service should use. The volumes are defined at the top level or existing volumes can be used. The source is the volume name and the target is the mount point in the container.
- `image:` is used to specify the image to use for the service. The image can be pulled from a registry or a local image can be used. It tells docker to start a stand alone container with the specified image.

### Start the services
```bash
docker compose up # Start the services, assuming the compose file is in the current directory and named compose.yml
docker compose up -d # Start the services in detached mode --detach
docker compose up --build # Start the services and rebuild the images
docker compose down # Stop the services. --rmi all flag will delete all images built or pulled when starting the services.
```
Container started by compose are named by combining the project name and the service name.\
The project name is the name of the directory containing the compose file.\
List the process running inside the container
```bash
docker compose top
```
Stop the services without deleting resources
```bash
docker compose stop
```
restart the services after stopping them
```bash
docker compose restart
```
see running services
```bash
docker compose ps
```
