#' Title
#'
#' @param pagina
#'
#' @return
#' @export
#'
#' @examples
atualizar_share_card <- function(pagina = "todas",
                                 sites_dos_eventos = FALSE) {
  library(magrittr, include.only = "%>%")

  if (pagina == "todas" & sites_dos_eventos == FALSE) {
    data_raw <- readr::read_csv("inst/dados.csv")

    nomes <- data_raw %>%
      dplyr::distinct(idioma) %>%
      dplyr::pull() %>%
      abjutils::rm_accent() %>%
      stringr::str_to_lower() %>%
      c("index", "eventos")

    caminhos <-
      glue::glue("https://materiais-estudo-r.netlify.app/{nomes}.html")

  } else if (pagina != "todas" &  sites_dos_eventos == FALSE) {
    nomes <- pagina
    caminhos <-
      glue::glue("https://materiais-estudo-r.netlify.app/{nomes}.html")
    caminhos_salvar <- glue::glue("inst/img/share-card_{nomes}.png")

  } else if (sites_dos_eventos == TRUE) {
    data_raw <- readr::read_csv("inst/eventos.csv")


    nomes <- data_raw %>% dplyr::pull(sigla_minuscula)

    caminhos <- data_raw %>% dplyr::pull(url)

    caminhos_salvar <-
      glue::glue("inst/img/eventos/share-card_{nomes}.png")

  } else {
    nomes <- pagina %>% fs::path_file()


    caminhos <- pagina

    caminhos_salvar <- glue::glue("inst/img/share-card_{nomes}.png")
  }





  for (i in 1:length(caminhos)) {
    webshot2::webshot(
      url = caminhos[i],
      file = caminhos_salvar[i],
      vheight = 1000 * 0.7,
      vwidth =  1910 * 0.7,
      cliprect = "viewport",
      delay = 3

    )

  }


}
