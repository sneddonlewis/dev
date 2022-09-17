#FROM ubuntu:jammy AS base
#WORKDIR /usr/local/bin
#ENV DEBIAN_FRONTEND=noninteractive
#RUN apt-get update && \
#    apt-get upgrade -y && \
#    apt-get install -y software-properties-common curl git build-essential && \
#    apt-add-repository -y ppa:ansible/ansible && \
#    apt-get update && \
#    apt-get install -y curl git ansible build-essential && \
#    apt-get clean autoclean && \
#    apt-get autoremove --yes

#FROM base AS setup
#ARG TAGS
#RUN addgroup --gid 1000 lewis
#$RUN adduser --gecos lewis --uid 1000 --gid 1000 --disabled-password lewis
#USER lewis
#WORKDIR /home/lewis

#FROM setup
#COPY . .
#CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

FROM ubuntu:jammy
ARG TAGS
WORKDIR /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y software-properties-common && apt-add-repository -y ppa:ansible/ansible && apt update && apt install -y sudo curl git sudo ansible build-essential
COPY . .
CMD ["sh", "-c", "sudo ansible-playbook $TAGS local.yml"]
