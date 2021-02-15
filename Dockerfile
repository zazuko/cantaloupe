FROM alpine:3.13.1

ENV CANTALOUPE_VERSION=4.1.7

EXPOSE 8182

RUN apk --no-cache add curl imagemagick ffmpeg unzip openjdk11-jdk graphicsmagick openjpeg-tools

# Run non privileged
RUN adduser --system cantaloupe

# Get and unpack Cantaloupe release archive
RUN curl --silent --fail -OL https://github.com/medusa-project/cantaloupe/releases/download/v$CANTALOUPE_VERSION/Cantaloupe-$CANTALOUPE_VERSION.zip \
  && unzip Cantaloupe-$CANTALOUPE_VERSION.zip \
  && ln -s cantaloupe-$CANTALOUPE_VERSION cantaloupe \
  && rm Cantaloupe-$CANTALOUPE_VERSION.zip \
  && mkdir -p /var/log/cantaloupe /var/cache/cantaloupe \
  && chown -R cantaloupe /cantaloupe /var/log/cantaloupe /var/cache/cantaloupe \
  && cp -rs /cantaloupe/deps/Linux-x86-64/* /usr/

USER cantaloupe
CMD ["sh", "-c", "java -Dcantaloupe.config=/cantaloupe/cantaloupe.properties.sample -jar /cantaloupe/cantaloupe-$CANTALOUPE_VERSION.war"]
