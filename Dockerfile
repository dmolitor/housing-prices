FROM rocker/r-ver:4.2.1
COPY ["DESCRIPTION", "requirements.txt", "./"]
RUN apt-get -y update \
    && apt-get install -y curl gdebi libudunits2-dev libgdal-dev libgeos-dev libproj-dev software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && add-apt-repository -y ppa:git-core/ppa \
    && apt update -y \
    && apt install -y python3.10 \
    && apt install -y python3.10-venv \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && gdebi --non-interactive quarto-linux-amd64.deb \
    && apt-get install -y git \
    && apt-get update \
    && apt-get install -y rsync
RUN Rscript -e "install.packages('renv'); renv::install()"
RUN python3.10 -m ensurepip \
    && python3.10 -m pip install --upgrade pip \
    && python3.10 -m pip install -r requirements.txt