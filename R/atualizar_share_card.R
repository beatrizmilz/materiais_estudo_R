#' Title
#'
#' @return
#' @export
#'
#' @examples
atualizar_share_card <- function(){

  library(magrittr, include.only = "%>%")

  data_raw <- readr::read_csv("inst/dados.csv")

  nomes <- data_raw %>%
    dplyr::distinct(idioma) %>%
    dplyr::pull() %>%
    abjutils::rm_accent() %>%
    stringr::str_to_lower() %>%
    c("index")

  caminhos <- glue::glue("https://materiais-estudo-r.netlify.app/{nomes}.html")

  caminhos_salvar <- glue::glue("inst/img/share-card_{nomes}.png")

  for (i in 1:length(caminhos)) {

    webshot2::webshot(

      url = caminhos[i],
      file = caminhos_salvar[i],
      vheight = 1000*0.7,
      vwidth =  1910*0.7,
      cliprect = "viewport"

      )

  }


}
