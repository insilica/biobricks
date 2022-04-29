FROM rocker/r-ver:4.1.2

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  git libcurl4-openssl-dev libssl-dev libsodium-dev libgit2-dev \
  libicu-dev libxml2-dev libpq-dev make zlib1g-dev pandoc

RUN install2.r --error arrow
RUN install2.r --error dplyr
RUN install2.r --error fs
RUN install2.r --error purrr
RUN install2.r --error readr
RUN install2.r --error rvest

RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"

WORKDIR /app
ADD ./ ./
RUN R -e "remotes::install_local('.',dependencies='Imports')"

# ENTRYPOINT R --vanilla -s -e 'biobricks::run()'