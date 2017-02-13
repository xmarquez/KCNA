# KCNA

This package bundles into a dataset suitable for text analysis most of the headlines produced by the Chongryon-hosted website of the Korean Central News Agency, [kcna.co.jp website](http://www.kcna.co.jp/index-e.htm) between 1 Jan 1997 to 29 September 2014. It also includes some functions useful for NLP analysis. It was used to create [this blogpost](https://abandonedfootnotes.blogspot.com). To install, use:

``` r
# install.packages("devtools")
devtools::install_github(repo = "xmarquez/KCNA")
```
There are three important datasets in this package. The first, `headlines` (use `?headlines` to access the documentation), contains all the headlines I scraped, along with some metadata (date, links to the original story, etc.). This is the "base" file, and aside from some minimal clean up (changing non-Ascii characters to Ascii or close equivalents), and a column indicating, to the best of my ability, whether the headline is in English or Spanish (a surprisingly difficult thing to teach to the computer for this corpus; see [the code here](https://github.com/xmarquez/KCNA/data-raw/Language_detection.Rmd) for details of the language detection algorithm), it is "as scraped." 

But because processing text files takes a lot of computing time, I've also included a couple of other files, unimaginatively named `preprocessed_corpus` and `processed_corpus` (use `?processed_corpus` in to access its documentation), which contain a "pre-processed" file, and a part-of-speech parsed version of the headlines. (The code used to produce these two datasets lives [here](https://github.com/xmarquez/KCNA/data-raw/process_corpus.Rmd)).

The preprocessing involved three things, apart from the basics like lowercasing all titles. First, I identified all Korean names in the headlines. This basically involved using the [Wikipedia list of components of Korean names](https://en.wikipedia.org/wiki/List_of_Korean_given_names), plus some additional work catching things this might have missed, to extract trigrams containing Korean name combinations (see `?korean_names` for the list of syllables used). The column `mentioned` in the `preprocessed_corpus` file shows who is mentioned in the headline, if anyone. (Note sometimes more than one person is mentioned; in these cases, there is more than one row for the date/headline combination). I also added some basic sentiment scores, using the sentiment indicators in the `tidytext` package. I also tried to determine whether a given headline mentions the USA, South Korea, China, or Japan (columns `mentions_us`,`mentions_south_korea`, etc.).

In the file `processed_corpus` the mentioned person is turned into a single word in the headline (so Kim Jong Il is turned into `Kim_Jong_Il` in the column `processed_title`). I also tried to identify mentions of other people and things (like the newspaper Rodong Sinmun, or foreign political leaders like Fidel Castro or Vladimir Putin) and transformed them into single words (e.g., `Rodong_Sinmun` or `Fidel_Castro_Ruz`), and I expanded all abbreviations I could find, turning "secy." into "secretary" for example. This is an inexact process, using lots of imperfectly debugged regex substitutions, so the results probably contain some errors. I then ran the results of this process through the Apache openNLP part-of-speech tagger to extract verbs, adjectives, etc; the results are included in the file as well, but you might get better results by using a state of the art parser (like the [Stanford parser and part-of-speech tagger](http://nlp.stanford.edu/software/), which taxes my machine too much).   

A couple of other files with entire stories from 2011 and 2012 are also available (`KCNA_2011` and `KCNA_2012`), as well as a file (`country_mentions`) that contains all mentions of countries and demonyms (e.g., Italian, American) I could find. Again the process to produce these is not perfect; the code used to produce them [lives here](https://github.com/xmarquez/KCNA/data-raw/Extract_country_and_demonym_mentions.Rmd).

There are also a couple of functions I used to produce interesting graphs; the most important of these is `create_sankey_network`, which allows one to create Sankey Flow diagrams from a corpus of sentences, as in [my blog post here](https://abandonedfootnotes.blogspot.com). One line is sufficient to use it:

``` r
create_sankey_network(headlines$title, "Kim Jong Il|Kim Jong Un")
```

(You can use it with other text data, as long as the text is split into sentences).
