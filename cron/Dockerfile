FROM alpine:latest

ADD crontab.txt /crontab.txt
COPY scripts/entry.sh /entry.sh
RUN chmod 755 /entry.sh

#custom scripts
ADD scripts/db-backup.sh /db-backup.sh
ADD scripts/sync-cloud.sh /sync-cloud.sh
RUN chmod 755 /db-backup.sh /sync-cloud.sh

RUN /usr/bin/crontab /crontab.txt

RUN apk update

#mysql client
RUN apk add mysql-client

#rclone configuration
ARG CLOUD_URL
ARG CLOUD_USER
ARG CLOUD_PASS
ARG CLOUD_VENDOR
ARG CLOUD_TYPE

RUN apk -U add ca-certificates fuse wget dcron tzdata \
  && rm -rf /var/cache/apk/*

RUN URL=http://downloads.rclone.org/current/rclone-current-linux-amd64.zip ; \
  URL=${URL/\/current/} ; \
  cd /tmp \
  && wget -q $URL \
  && unzip /tmp/rclone-current-linux-amd64.zip \
  && mv /tmp/rclone-*-linux-amd64/rclone /usr/bin \
  && rm -r /tmp/rclone* \
  && rclone config create remote ${CLOUD_TYPE} vendor ${CLOUD_VENDOR} url ${CLOUD_URL} user ${CLOUD_USER} pass ${CLOUD_PASS}

CMD ["/entry.sh"]