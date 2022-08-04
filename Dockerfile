FROM perl
LABEL MAINTAINER Christoph Beger <christoph.beger@medizin.uni-leipzig.de>

RUN cpanm Carton

WORKDIR /app

COPY cpanfile* ./
RUN carton install

COPY lib ./lib
COPY t/ ./t
