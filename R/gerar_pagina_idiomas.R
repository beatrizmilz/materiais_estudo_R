#' Title
#'
#' @return
#' @export
#'
#' @examples
gerar_pagina_idiomas <- function(){

library(magrittr, include.only = "%>%")

data_raw <- readr::read_csv("inst/dados.csv")

idiomas <- data_raw %>%
  dplyr::distinct(idioma) %>%
  dplyr::pull()


idiomas_minusculo <- abjutils::rm_accent(idiomas) %>%
  stringr::str_to_lower() # %>%
  # stringr::str_replace(pattern = "portugues", "index")

caminhos <- glue::glue("_site/{idiomas_minusculo}.html")


for (i in 1:length(idiomas)) {
  idioma_atual<- idiomas[i]
  caminho <- caminhos[i]

  rmarkdown::render(
    'inst/template.Rmd',
    output_file = caminho,
    params = list(idioma = idioma_atual),
     envir = parent.frame()
  )

}
}
