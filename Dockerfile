ARG KAFKA_CONNECT_ELASTICSEARCH_TAG=feature-redmicSupport-latest

FROM registry.gitlab.com/redmic-project/confluent/kafka-connect-elasticsearch:${KAFKA_CONNECT_ELASTICSEARCH_TAG} AS kce

FROM docker:18.09

LABEL maintainer="info@redmic.es"

COPY --from=kce /jar/ /jar

COPY script /

ENTRYPOINT ["/entrypoint.sh"]
