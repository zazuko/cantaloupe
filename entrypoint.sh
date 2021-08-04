#!/bin/sh

export OTEL_RESOURCE_ATTRIBUTES="container.id=$(hostname),$OTEL_RESOURCE_ATTRIBUTES"

exec "java"                       \
  $JAVA_ARGS                      \
  -javaagent:"/opentelemetry.jar" \
  -Xshare:off                     \
  -Dcantaloupe.config=/cantaloupe/cantaloupe.properties \
  -jar /cantaloupe/cantaloupe-$CANTALOUPE_VERSION.jar
