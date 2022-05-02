#!/usr/bin/env Rscript

# clone url https repos to owner/repo
# > url=https://github.com/biobricks-ai/clinvar.git 
# > install.sh $url
# creates $BRICKDIR/biobricks-ai/clinvar
url   <- commandArgs(trailingOnly = T)[[1]]
split <- strsplit(url,'/+')[[1]]

if(!startsWith(url,"https") || !(fs::path_ext(url) != ".git" )){
  stop(glue::glue("url must be https://.../owner/repo.git not {url}"))
}

owner <- split[3]
repo  <- fs::path_ext_remove(split[4])

bdir  <- Sys.getenv("BRICKDIR")
brick <- fs::path(owner,repo)

system(glue::glue('git submodule add {url} {brick}'))
