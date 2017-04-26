FROM ubuntu:16.10 

RUN apt-get update && apt-get upgrade -y && apt-get install build-essential libpcre3 libpcre3-dev libssl-dev wget libevent-dev -y

EXPOSE 4201
COPY . mushsource
WORKDIR /mushsource

RUN ./configure && make update && make install && \
    cd game && sed -i 's/^GAMEDIR=.*/GAMEDIR=\/mushsource\/game/' ./restart && \ 
    sed -i 's/^ip_addr/ip_addr 0.0.0.0/' ./mushcnf.dst && \

RUN useradd newuser   
RUN chown -R newuser /mushsource/game
USER newuser

ENTRYPOINT /mushsource/game/restart   
