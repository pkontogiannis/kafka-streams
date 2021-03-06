FROM phusion/baseimage

ENV HOME /cryptocoinrisk
WORKDIR $HOME

# Install Java
RUN add-apt-repository ppa:webupd8team/java -y  && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get --allow-unauthenticated install -y  oracle-java8-installer && \
    apt-get clean

# Install SBT
RUN wget https://piccolo.link/sbt-1.2.6.tgz && \
    tar -xvzf sbt-1.2.6.tgz && \
    rm sbt-1.2.6.tgz

# Configure environment variables
ENV PATH $PATH:$HOME/sbt/bin

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ADD . $HOME/project

ENTRYPOINT /bin/bash

CMD ["bash"]