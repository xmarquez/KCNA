#' Find local peaks in a vector
#'
#' @param vec a vector
#' @param bw the bandwith for local peak search
#' @param x.coo the set of index values where peaks are to be located
#'
#' @return A list with local maxima and minima and their location in the
#'   original vector. From
#'   https://www.r-bloggers.com/an-algorithm-to-find-local-extrema-in-a-vector/,
#'   by Timothee Poisot
#' @export
#'
#' @examples
#' x <- runif(100)
#' x
#' findpeaks(x, 2)
#' findpeaks(x, 25)
findpeaks <- function(vec, bw=1, x.coo=c(1:length(vec)))
{
  pos.x.max <- NULL
  pos.y.max <- NULL
  pos.x.min <- NULL
  pos.y.min <- NULL
  for(i in 1:(length(vec)-1)) 	{ 		if((i+1+bw)>length(vec)){
    sup.stop <- length(vec)}else{sup.stop <- i+1+bw
    }
    if((i-bw)<1){inf.stop <- 1}else{inf.stop <- i-bw}
    subset.sup <- vec[(i+1):sup.stop]
    subset.inf <- vec[inf.stop:(i-1)]

    is.max   <- sum(subset.inf > vec[i]) == 0
    is.nomin <- sum(subset.sup > vec[i]) == 0

    no.max   <- sum(subset.inf > vec[i]) == length(subset.inf)
    no.nomin <- sum(subset.sup > vec[i]) == length(subset.sup)

    if(is.max & is.nomin){
      pos.x.max <- c(pos.x.max,x.coo[i])
      pos.y.max <- c(pos.y.max,vec[i])
    }
    if(no.max & no.nomin){
      pos.x.min <- c(pos.x.min,x.coo[i])
      pos.y.min <- c(pos.y.min,vec[i])
    }
  }
  return(list(pos.x.max,pos.y.max,pos.x.min,pos.y.min))
}

concordance <- function(text, center = "Kim_Jong_Il",
                     n = 4, type = c("after", "before", "both"),
                     num_levels = 15, other_level = "...") {
  type <- match.arg(type, c("after", "before", "both"))

  concordance_text <- data_frame(text = text,
                                 center = ifelse(str_detect(text,
                                                            center),
                                                 str_extract(text, center),
                                                 NA))

  if(type == "after" | type == "both") {
    data_after <- concordance_text %>%
      filter(!is.na(center)) %>%
      distinct() %>%
      mutate(after = str_extract(text, regex(paste0("(?<=",
                                                    center,
                                                    ")",
                                                    ".*$"),
                                             perl = TRUE))) %>%
      separate(after,
               sep = "[\\W]+",
               into = c(paste0("word_after_", 0:n)),
               extra = "merge") %>%
      select(-word_after_0) %>%
      gather(word_pos, word, starts_with("word_after")) %>%
      group_by(center, word_pos) %>%
      mutate(word = fct_lump(word, n = num_levels, other_level = other_level, ties.method = "first"),
             word_pos_num = str_extract(word_pos, "[0-9]+") %>% as.numeric()) %>%
      rowwise() %>%
      mutate(word = ifelse(!is.na(word),
                           paste0(paste(rep(" ", word_pos_num), collapse = ""), word),
                           NA)) %>%
      ungroup() %>%
      select(-word_pos_num) %>%
      spread(word_pos, word)

  }

  if(type == "before" | type == "both") {
    data_before <- concordance_text %>%
      filter(!is.na(center)) %>%
      distinct() %>%
      mutate(word = str_extract(text, regex(paste0("^.*",
                                                      "(?=",
                                                      center,
                                                      ")"),
                                               perl = TRUE)) %>%
               str_split("[\\W]+")) %>%
      unnest() %>%
      group_by(text) %>%
      filter(word != "") %>%
      mutate(word_pos_num = rev(seq_along(text)),
             key = paste0("word_before_", word_pos_num)) %>%
      filter(word_pos_num <= n) %>%
      group_by(key) %>%
      mutate(word = fct_lump(word, n = num_levels, other_level = other_level, ties.method = "first")) %>%
      rowwise() %>%
      mutate(word = ifelse(!is.na(word),
                           paste0(word, paste(rep(" ", word_pos_num), collapse = "")),
                           NA)) %>%
      select(-word_pos_num) %>%
      group_by(text) %>%
      spread(key, word) %>%
      ungroup()

  }

  if(type == "after") {
    concordance_text <- concordance_text %>%
      left_join(data_after)
    } else if(type == "before") {

    cols <- c("text", paste0("word_before_",n:1), "center")

    concordance_text <- concordance_text %>%
      left_join(data_before) %>%
      select_(.dots = cols)

    } else {
      cols <- c("text", paste0("word_before_",n:1),
                "center", paste0("word_after_",1:n))
      concordance_text <- concordance_text %>%
        left_join(data_before) %>%
        left_join(data_after)  %>%
        select_(.dots = cols)

  }



}

sankeify <- function(text, center = "Kim_Jong_Il",
                     n = 4, type = c("after", "before", "both"),
                     num_levels = 15, other_level = "...") {
  type <- match.arg(type, c("after", "before", "both"))

  data <- concordance(text, center = center, n = n,
                      type = type, num_levels = num_levels, other_level = other_level)

  edges <- data_frame()

  if(type == "after") {
    data <- data %>%
      rename(word_after_0 = center)

    for(i in 1:n-1) {
      cols <- c(paste0("word_after_",i),
                paste0("word_after_",i+1))

      edges_1 <- data %>%
        select_(.dots = cols)

      names(edges_1) <- c("from", "to")

      edges_1 <- edges_1 %>%
        group_by(from, to) %>%
        count() %>%
        rename(weight = n)

      edges <- bind_rows(edges, edges_1)

    }
  }

  if(type == "before") {
    data <- data %>%
      rename(word_before_0 = center)

    for(i in c(n:1)) {
      cols <- c(paste0("word_before_",i),
                  paste0("word_before_",i-1))

      edges_1 <- data %>%
        select_(.dots = cols)

      names(edges_1) <- c("from", "to")

      edges_1 <- edges_1 %>%
        group_by(from, to) %>%
        count() %>%
        rename(weight = n)
      edges <- bind_rows(edges, edges_1)
      }
  }


  edges %>%
    na.omit()

}

create_vertex_list <- function(edge_list) {
  vertex_list <- edge_list %>%
    count(from, wt = weight) %>%
    rename(name = from)

  vertex_list2 <- edge_list %>%
    count(to, wt = weight) %>%
    rename(name = to)

  vertex_list <- bind_rows(vertex_list,
                           vertex_list2) %>%
    count(name, wt = n) %>%
    rename(n = nn) %>%
    mutate(label = str_replace_all(name, "_"," ")) %>%
    ungroup() %>%
    distinct()

  vertex_list %>%
    na.omit() %>%
    arrange(desc(n))

}

make_sankey_list <- function(vertex_list, edge_list) {
  vertex_list <- vertex_list %>%
    mutate(id = seq_along(name) - 1) %>%
    select(id, name, label)

  edge_list <- edge_list %>%
    mutate(source = vertex_list$id[match(from, vertex_list$name)],
           target = vertex_list$id[match(to, vertex_list$name)],
           value = weight) %>%
    select(source, target, from, to, weight)

  list(links = edge_list, nodes = vertex_list)
}

#' Create a Sankey Flow Diagram from a series of texts.
#'
#' @param text A vector of sentences used to generate concordances around a
#'   central word. Though texts of any length can be used, the function
#'   currently works best if the texts are sentences (like the KCNA headlines in
#'   this package) rather than full paragraphs.
#' @param node The central word in the concordance (around which the flow of
#'   text will be computed). This is a regular expression; so, for example,
#' \code{"[Nn]ation(al)?"} will compute concordances around \code{nation},
#' \code{national}, \code{Nation}, and \code{National}. And for various internal
#' reasons, \code{"friend"} will typically match \code{"friendship"} as well as
#' \code{"friend"}. To avoid this, surround the expression with \code{\\b}
#' (e.g., \code{"\\bfriend\\b"}) will match only \code{"friend"} and not
#' \code{"friendship"}).
#' @param type Whether to create the Sankey network "after" the word, or
#'   "before" the word.
#' @param title A title for the visualization, if wanted. Defaults to NULL.
#' @param context_words The number of words of context for the concordance.
#'   Defaults to 4.
#' @param num_levels The maximum number of terms to show in each column of the
#'   graphical summary. Defaults to showing the most common 15 terms.
#'
#' @return A networkD3 htmlwidget. It's automatically included in knitr.
#' @export
#'
#' @import dplyr
#' @import stringr
#' @import tidyr
#' @import networkD3
#'
#' @examples
#' \dontrun{
#' create_sankey_network(headlines$title, "Kim Jo[n|m]g Il")
#' create_sankey_network(headlines$title, "Kim Jo[n|m]g Il", type = "before")
#' create_sankey_network(headlines$title, "Kim Jo[n|m]g Il", context_words = 5,
#' num_levels = 20)
#' create_sankey_network(headlines$title, "Kim Jong Il|Kim Jong Un")
#' }
create_sankey_network <- function(text, node,
                                  type = c("after", "before"),
                                  title = NULL,
                                  context_words = 4,
                                  num_levels = 15) {

  type <- match.arg(type, c("after", "before"))

  edges <- sankeify(text, center = node, type = type,
                    n = context_words, num_levels = num_levels)

  vertices <- create_vertex_list(edges)

  sankey_list <- make_sankey_list(vertices,
                                  edges)

  net <- networkD3::sankeyNetwork(Links = sankey_list$links,
                Nodes = sankey_list$nodes,
                Source = "source",
                Target = "target",
                NodeID = "label",
                Value = "weight",
                units = "times",
                fontSize = 12, nodeWidth = 30)

  if(!is.null(title)) {
    net <- htmlwidgets::prependContent(net,
                                htmltools::HTML(paste0("<center>",
                                                       title,
                                                       "</center>")))
  }

  net

}

fix_html_for_blogpost <- function(htmlfilename) {
  # Not exported - just for cleaning up the HTML so that the result can be posted to blog.

  file <- readr::read_lines(htmlfilename)

  file <- str_replace_all(file, "Reading_KCNA_headlines_files/", "https://raw.githubusercontent.com/xmarquez/KCNA/master/Reading_KCNA_headlines_files/")

  readr::write_lines(file, "blog_post/Reading_KCNA_headlines_blogspot.html")

}
