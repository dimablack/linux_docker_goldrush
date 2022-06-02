FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt dist-upgrade -y

RUN apt-get install -y curl
RUN apt-get install -y nano
RUN apt-get install -y zip
RUN apt-get install -y unzip
RUN apt-get install -y git
RUN apt-get install -y parallel
RUN apt-get install -y jq

RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update

RUN apt-get install python3 -y
RUN apt-get install python3-distutils -y

RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python3 get-pip.py --user

RUN echo "complete -C aws_completer aws" >> ~/.bashrc
RUN echo "export LDAP="${LDAP} >> ~/.bashrc
RUN echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc

COPY .bashrc /root/.bashrc_temp
RUN cat /root/.bashrc_temp >> /root/.bashrc

RUN apt-get install python3-pip -y
RUN pip install awsebcli --upgrade --user

RUN echo "" >> ~/.bashrc
RUN echo "complete -C aws_completer aws" >> ~/.bashrc
RUN echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc

CMD source /root/.bashrc

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY ./.ssh /root/.ssh
COPY ./.aws /root/.aws

RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

WORKDIR /app
RUN git clone git@github.com:bazaarvoice/goldrush.git
