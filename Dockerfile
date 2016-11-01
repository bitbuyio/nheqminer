FROM debian
MAINTAINER BitBuyIO <developer@bitbuy.io>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl ca-certificates wget nano git screen cmake build-essential libboost-all-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN cd /tmp && \
    git clone https://github.com/sarath-hotspot/nheqminer.git /tmp/nheqminer && \
    cd /tmp/nheqminer/nheqminer && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    mv nheqminer /usr/local/bin/nheqminer && \
    rm -rf /tmp/*

ADD oneshot /usr/local/bin/oneshot
RUN chmod a+x /usr/local/bin/*

VOLUME /app
WORKDIR /app
CMD oneshot
