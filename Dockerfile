FROM python:3.6.7-alpine

RUN apk update
RUN apk add postgresql-libs
RUN apk add --virtual .build-deps gcc musl-dev postgresql-dev
RUN python3 -m pip install prometheus-pgbouncer-exporter==2.0.2 --verbose
RUN apk --purge del .build-deps

EXPOSE 9127

COPY config.docker.yml /etc/pgbouncer-exporter/config.yml

ENTRYPOINT ["pgbouncer-exporter"]
CMD ["--config", "/etc/pgbouncer-exporter/config.yml"]
