ARG KAFKA_CONNECT_ELASTICSEARCH_TAG=feature-redmicSupport-latest

FROM registry.gitlab.com/redmic-project/confluent/kafka-connect-elasticsearch:${KAFKA_CONNECT_ELASTICSEARCH_TAG} AS kce

FROM alpine:3.8

LABEL maintainer="info@redmic.es"

ARG KAFKA_CONNECT_ELASTICSEARCH_TARGET=/build/target/redmic-kafka-connect-elasticsearch-5.0.1-package/share/java/kafka-connect-elasticsearch/

COPY --from=kce ${KAFKA_CONNECT_ELASTICSEARCH_TARGET} /jar
