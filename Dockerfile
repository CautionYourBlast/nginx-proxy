FROM nginx:1.14.1

VOLUME ["/etc/nginx/certs", "/etc/nginx/dhparam"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]

WORKDIR /app/

RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/
COPY network_internal.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/

COPY . /app/
