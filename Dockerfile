FROM adoptopenjdk/openjdk16:alpine

ENV CANTALOUPE_VERSION=5.0.4
ARG OTEL_VERSION=1.4.1

EXPOSE 8182

RUN apk --no-cache add curl ffmpeg unzip openjpeg-tools ttf-dejavu

# Run non privileged
RUN adduser --system cantaloupe

# Get the OpenTelemetry instrumentation agent
RUN curl --silent --fail --output /opentelemetry.jar -L https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_VERSION}/opentelemetry-javaagent-all.jar

# Get and unpack Cantaloupe release archive
RUN curl --silent --fail -OL https://github.com/cantaloupe-project/cantaloupe/releases/download/v$CANTALOUPE_VERSION/cantaloupe-$CANTALOUPE_VERSION.zip \
  && unzip cantaloupe-$CANTALOUPE_VERSION.zip \
  && ln -s cantaloupe-$CANTALOUPE_VERSION cantaloupe \
  && rm cantaloupe-$CANTALOUPE_VERSION.zip \
  && mkdir -p /var/log/cantaloupe /var/cache/cantaloupe \
  && chown -R cantaloupe /cantaloupe /var/log/cantaloupe /var/cache/cantaloupe \
  && cp -rs /cantaloupe/deps/Linux-x86-64/* /usr/

COPY cantaloupe.properties /cantaloupe/cantaloupe.properties
COPY entrypoint.sh /entrypoint.sh

ENV JAVA_ARGS="-Xms1024m -Xmx1024m"
ENV OTEL_SERVICE_NAME="cantaloupe"
ENV OTEL_TRACES_EXPORTER="none"
ENV OTEL_METRICS_EXPORTER="none"

USER cantaloupe
CMD ["/entrypoint.sh"]
