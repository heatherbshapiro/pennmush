FROM ubuntu:16.10 

RUN apt-get update && apt-get upgrade -y && apt-get install build-essential libpcre3 libpcre3-dev libssl-dev wget libevent-dev -y

COPY . mushsource

WORKDIR /mushsource

RUN ./configure && make update && make install

RUN cd game && sed 's/GAMEDIR=.*/GAMEDIR=\/mushsource\/game' ./restart && ./restart