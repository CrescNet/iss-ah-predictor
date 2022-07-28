FROM perl
LABEL MAINTAINER Christoph Beger <christoph.beger@medizin.uni-leipzig.de>

RUN cpanm Carton

WORKDIR /app

COPY lib ./lib
COPY t/ ./t
