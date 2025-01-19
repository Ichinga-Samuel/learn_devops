# An Example dockerfile that installs and starts git in an ubuntu container
# based on the latest ubuntu image
FROM ubuntu:latest
LABEL maintainer="Samuel Ichinga"
RUN apt-get update && apt-get install -y git
ENTRYPOINT ["git"]
