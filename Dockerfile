FROM alpine:latest

# Creating a user to avoid backup files as root
RUN addgroup -g 420 mysqlbackup && \
    adduser -G mysqlbackup -h /backup -D -u 420 mysqlbackup

# Installing a mysql client and tar to compress
RUN apk update && apk add mariadb-client

VOLUME [ "/backup" ]
WORKDIR /backup

ADD backup.sh /backup.sh
RUN chmod +x /backup.sh

ENTRYPOINT [ "/backup.sh" ]
