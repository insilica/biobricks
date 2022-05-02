#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = T)
bdir <- Sys.getenv("BRICKDIR")
dirs <- fs::dir_ls(bdir,recurse=T,regexp=fs::path(args[[1]],"dvc.yaml"))

sglue <- \(line){stop(glue::glue(line))}
if(length(dirs)>1){ 
  bricks <- paste(dirs,collapse=" ")
  sglue("'{args[[1]]}' matches multiple bricks - {bricks}")
}

if(length(dirs)==0){
  stop(glue::glue("no bricks match name {args[[1]]}"))
}

system(glue::glue("dvc repro {dirs[[1]]}"))
