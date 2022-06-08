FROM ubuntu

RUN apt update && apt install -y bash gzip tar
WORKDIR /root/bashtextbank
COPY . .
RUN bash configure.sh && make install

ENTRYPOINT /bin/bash