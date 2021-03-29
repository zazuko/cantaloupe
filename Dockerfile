FROM adoptopenjdk/openjdk16:alpine

ENV CANTALOUPE_VERSION=5.0

EXPOSE 8182

RUN apk --no-cache add curl ffmpeg unzip openjpeg-tools ttf-dejavu

# Run non privileged
RUN adduser --system cantaloupe

# Get and unpack Cantaloupe release archive
RUN curl --silent --fail -OL https://github.com/cantaloupe-project/cantaloupe/releases/download/v$CANTALOUPE_VERSION/cantaloupe-$CANTALOUPE_VERSION.zip \
  && unzip cantaloupe-$CANTALOUPE_VERSION.zip \
  && ln -s cantaloupe-$CANTALOUPE_VERSION cantaloupe \
  && rm cantaloupe-$CANTALOUPE_VERSION.zip \
  && mkdir -p /var/log/cantaloupe /var/cache/cantaloupe \
  && chown -R cantaloupe /cantaloupe /var/log/cantaloupe /var/cache/cantaloupe \
  && cp -rs /cantaloupe/deps/Linux-x86-64/* /usr/

COPY cantaloupe.properties /cantaloupe/cantaloupe.properties

USER cantaloupe
CMD ["sh", "-c", "java -Dcantaloupe.config=/cantaloupe/cantaloupe.properties -jar /cantaloupe/cantaloupe-$CANTALOUPE_VERSION.jar"]
