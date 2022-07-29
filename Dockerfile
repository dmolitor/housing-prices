FROM rocker/r-ver:4.2.1
COPY ["DESCRIPTION", "requirements.txt", "./"]
RUN apt-get -y update \
    && apt-get install -y curl gdebi libudunits2-dev libgdal-dev libgeos-dev libproj-dev software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt update -y \
    && apt install -y python3.10 \
    && apt install -y python3.10-venv \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && gdebi --non-interactive quarto-linux-amd64.deb
RUN python3.10 -m venv pyenv \
    && . ./pyenv/bin/activate \
    && pip install --upgrade pip \
    && pip install -r requirements.txt
RUN R -e "install.packages('renv')" \
    && R -e "renv::install()"
ENV QUARTO_PYTHON=pyenv/bin/python