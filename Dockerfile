# docker build -t insilica/biobricks:2.0 .
# docker login
# docker push insilica/biobricks:2.0
FROM rocker/r-ver:4.2

RUN apt-get update -y
RUN apt-get -y --no-install-recommends install git libxml2-dev

RUN apt-get install -y python3 python3-pip
RUN pip install dvc
RUN pip install dvc-s3

# Biobricks dependencies
RUN install2.r --error arrow
RUN install2.r --error dplyr
RUN install2.r --error fs
RUN install2.r --error purrr
RUN install2.r --error xml2
RUN install2.r --error readr
RUN install2.r --error rvest
RUN install2.r --error DBI
RUN install2.r --error RSQLite

# Biobricks testing
RUN install2.r --error remotes
RUN Rscript -e "remotes::install_github('biobricks-ai/biobricks-r')"
RUN Rscript -e "remotes::install_github('biobricks-ai/bricktools')"
