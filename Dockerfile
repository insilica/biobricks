FROM rocker/r-ver:4.1.2

RUN apt-get update -qq
RUN apt-get -y --no-install-recommends install \
  git python3.8 python3-pip libxml2-dev

RUN install2.r --error arrow
RUN install2.r --error dplyr
RUN install2.r --error fs
RUN install2.r --error purrr
RUN install2.r --error xml2
RUN install2.r --error readr
RUN install2.r --error rvest

RUN pip install dvc

WORKDIR /biobricks/bricks