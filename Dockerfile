
ARG PG_VERSION
ARG POSTGIS_VERSION

FROM postgis/postgis:${PG_VERSION}-${POSTGIS_VERSION}

ARG PG_VERSION

LABEL maintainer="vincent@developmentseed.org"

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-${PG_VERSION}-pgtap
