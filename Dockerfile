FROM ubuntu:latest

# command line tools for flutter
RUN apt update && apt install -y curl file git unzip xz-utils zip python3

WORKDIR /home

RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/flutter/bin"
RUN echo flutter sdk-path

RUN flutter doctor

COPY . /code
RUN rm -rf /code/.devcontainer
RUN rm -rf /code/node_modules
RUN rm -rf /code/*.json

WORKDIR /code
RUN flutter pub get

RUN flutter build web
EXPOSE 4040

RUN ["chmod", "+x", "/code/server/server.sh" ]
ENTRYPOINT [ "/code/server/server.sh" ]