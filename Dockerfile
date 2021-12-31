FROM ubuntu:21.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y sudo vim software-properties-common wget

# RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# COPY --chown=ubuntu:root install.sh .
# RUN pwd
# RUN ls -la
# RUN chmod +x install.sh

ENTRYPOINT ["/bin/bash"]
