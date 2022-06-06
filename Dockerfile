FROM ubuntu

RUN apt update && apt install -y bash gzip tar

ENTRYPOINT /bin/bash