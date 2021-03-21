gerar_lista_contrib <- function(){
  allcontributors::get_contributors(
    org = "beatrizmilz",
    repo = "materiais_estudo_R",
    type = c("code", "issues", "discussion"),
    alphabetical = FALSE
  ) %>%
    tibble::as_tibble() %>%
    dplyr::mutate(url = glue::glue("https://github.com/{logins}")) %>%
    readr::write_csv2(file = "inst/lista_de_pessoas_contribuidoras.csv")
}

