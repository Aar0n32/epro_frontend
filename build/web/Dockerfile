FROM    mhart/alpine-node

RUN     npm install -g http-server

WORKDIR /site
COPY     build/web/    /site

EXPOSE  80

CMD ["http-server", "--cors", "-p80", "/site"]