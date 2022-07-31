FROM python:3.10.5-slim-bullseye
COPY ["requirements.txt", "./"]
RUN apt-get -y update \
    && apt-get install -y curl gdebi \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && gdebi --non-interactive quarto-linux-amd64.deb \
    && apt-get install -y git \
    && apt-get update \
    && apt-get install -y rsync
RUN python3.10 -m pip install --upgrade pip \
    && python3.10 -m pip install -r requirements.txt
