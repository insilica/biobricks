kiln <- function(){
  name <- "biobricks"
  res  <- glue("docker inspect {name}") |> system(intern=T) |> jsonlite::fromJSON()
  bd   <- res$Mounts |> purrr::detect(~ .$Destination == "/biobricks/bricks")
  list(
    name     = name,
    brickdir = bd$Source,
    exec     = \(cmd,.envir=parent.frame()){  
      cmd <- glue::glue(cmd,.envir = .envir)
      cmd <- glue("docker exec -it {kiln()$name} {cmd}") 
      cat(cmd,"\n")
      system(cmd)
    }
  )
}

#' @export
install <- function(url){ kiln()$exec("install.r {url}") }

#' @export
bake <- function(brick){
  kiln()$exec("repro.r {brick}")
  data <- fs::dir_ls(kiln()$brickdir,recurse=T,regexp=fs::path(brick,"data$"))
  fs::dir_ls(data)
}

# attempts to parse a data directory into dplyr lazy tables
#' @export
lzy <- function(files){
  pqt <- files |> purrr::keep(~ fs::path_ext(.) == "parquet")
  nm  <- fs::path_file(pqt) |> fs::path_ext_remove()
  purrr::map(pqt,~arrow::read_parquet(.,as_data_frame=F)) |> purrr::set_names(nm)
}
