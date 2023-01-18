FROM ubuntu:22.04

ENV TZ=Europe/Warsaw

RUN apt-get update && apt-get install -y wget vim git curl

RUN apt-get install -y build-essential libreadline-dev unzip

RUN curl -R -O http://www.lua.org/ftp/lua-5.1.5.tar.gz
RUN tar -zxf lua-5.1.5.tar.gz
RUN cd lua-5.1.5 && make linux test && make install

RUN wget https://luarocks.org/releases/luarocks-3.9.2.tar.gz
RUN tar zxpf luarocks-3.9.2.tar.gz
RUN cd luarocks-3.9.2 && ./configure &&  make && make install

RUN luarocks install moonscript
RUN apt-get install -y libssl-dev
RUN luarocks install lapis
RUN apt-get install -y libexpat-dev
RUN luarocks install cloud_storage
RUN luarocks install luasocket
RUN luarocks install lua-cjson2

RUN useradd -ms /bin/bash student
RUN adduser student sudo


EXPOSE 80

VOLUME /home/student/skrypty/

USER student
WORKDIR /home/student/
RUN mkdir skrypty
