FROM erlang:22-alpine
MAINTAINER Sackey_Freshia
RUN apk update
RUN apk upgrade
RUN apk add git \
    curl \
    gcc \
    make \
    perl \
    ncurses-dev \
    openssl-dev \
    coreutils \
    bsd-compat-headers \
    libc-dev
WORKDIR EMQ
RUN git clone https://github.com/erlang/rebar3.git && cd rebar3 && ./bootstrap
RUN mkdir emqx && cd emqx && git clone https://github.com/emqx/emqx-rel.git && cd  emqx-rel && make distclean &&  make && cd _build/emqx/rel/emqx 
# ./bin/emqx console 
# RUN adduser -D -u 1000 emqx
# RUN ls
# # RUN chgrp -Rf emqx EMQ 
# # RUN chmod -Rf g+w EMQ 
# RUN chown -Rf emqx emqx

# USER emqx

EXPOSE 1883 8080 8083 8084 8883 11883 18083 4369 5369 6369
COPY start1.sh emqx
COPY docker-entrypoint.sh emqx
RUN chmod +x emqx/start1.sh
RUN chmod +x emqx/docker-entrypoint.sh
RUN cd emqx/emqx-rel/_build/emqx/rel/emqx/bin && ls
#RUN ls EMQ
#WORKDIR emqx/emqx-rel/_build/emqx/rel/emqx
#VOLUME ["/emqx/emqx-rel/_build/emqx/rel/emqx/log", "/emqx/emqx-rel/_build/emqx/rel/emqx/data", "/emqx/emqx-rel/_build/emqx/rel/emqx/lib", "/emqx/emqx-rel/_build/emqx/rel/emqx/etc"]
#ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["./emqx/start1.sh"]
#CMD ["./emqx","console"]
