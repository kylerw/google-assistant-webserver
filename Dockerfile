FROM lsiobase/alpine.python:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="kylerw"

# Install packages
RUN \
 pip install jq tzdata libportaudio2 alsa-utils \
   google-assistant-library google-auth \
   requests_oauthlib cherrypy flask flask-jsonpify flask-restful \
   grpcio google-assistant-grpc google-auth-oauthlib && \
   rm -rf /var/lib/apt/lists/*

# Copy data
COPY run.sh /
COPY *.py /

RUN chmod a+x /run.sh

VOLUME /data
COPY *.json /data/
EXPOSE 9324
EXPOSE 5000

ENTRYPOINT [ "/run.sh" ]