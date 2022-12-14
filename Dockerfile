FROM openjdk:8-jdk-alpine
#------------------------

# add wget and tar
RUN apk add --update wget
RUN apk add --update tar
RUN apk add --update unzip

# copy file
COPY service /etc/s6

VOLUME ["/run"]

# skaware s6 daemon runner
RUN mkdir s6; \
    wget --no-check-certificate  https://github.com/just-containers/skaware/releases/download/v2.0.7/s6-2.11.0.0-linux-amd64-bin.tar.gz; \
    tar -xvzf s6-2.11.0.0-linux-amd64-bin.tar.gz --directory /s6 --strip-components=1; \
    mv /s6/bin/* /usr/bin; \
    rm s6-2.11.0.0-linux-amd64-bin.tar.gz; \
    rm -rf s6

RUN chmod -R 755 /usr/bin

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]