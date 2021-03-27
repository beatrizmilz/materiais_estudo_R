#' Gera lista de pessoas contribuidoras no repositório
#'
#' @return
#' @export
#'
#' @examples
gerar_lista_contrib <- function(){
  library(magrittr, include.only = "%>%")
  allcontributors::get_contributors(
    org = "beatrizmilz",
    repo = "materiais_estudo_R",
    type = c("code", "issues", "discussion"),
    alphabetical = FALSE
  ) %>%
    tibble::as_tibble() %>%
    dplyr::mutate(url = glue::glue("https://github.com/{logins}")) %>%
    dplyr::filter(!logins %in% c("actions-user", "beamilz-ensino")) %>%
    readr::write_csv2(file = "inst/lista_de_pessoas_contribuidoras.csv")
}

gerar_lista_contrib()
