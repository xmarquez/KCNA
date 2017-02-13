#' KCNA headlines, January 1997-September 2014
#'
#' A collection of all headlines in the Japanese-hosted [KCNA
#'  website](http://www.kcna.co.jp/index-e.htm) as of September 2014.
#'
#' \describe{
#'
#' \item{date}{Date of the headline. N = 114633, unique = 6087, min =
#' 1997-01-01, max = 2014-09-25.}
#'
#' \item{title}{The actual headline. N = 114633, unique = 101878. }
#'
#' \item{english}{For `english_prob > 0.5`, we assume the headline is in
#' English. This is a reasonable assumption, but it may not be perfect; some
#' spanish language headlines may slip through, and some english headlines may
#' be misclassified, despite extensive checking.}
#'
#' \item{english_prob}{A number signifying the degree of agreement of four
#' different algorithms with respect to the question of whether the headline is
#' in English. 0 means none of the algorithms used classified the headline as
#' being in English; 1 means all of them do. See the `language_detection` file
#' in the [`data-raw` folder on
#' Github](https://github.com/xmarquez/KCNA/data-raw) for details. Headlines not
#' in english are in spanish.}
#'
#' \item{story.link}{Link to the original story in the KCNA website. May have
#' changed since headlines were harvested; KCNA has been known to delete stories
#' or change links. Unique = 114319. }
#'
#' \item{index.link}{Link to the original index page in the KCNA website. May
#' have changed since headlines were harvested; KCNA has been known to delete
#' stories or change links. Unique = 6087. }
#'
#' }
#' @family headline data
#'
"headlines"


#' KCNA stories, 2011
#'
#' All KCNA stories for 2011 harvested from the Japanese-hosted [KCNA
#'  website](http://www.kcna.co.jp/index-e.htm) as of September 2014
#'
#' \describe{ \item{story}{The actual story. N = 11997, unique = 11940. }
#'
#' \item{date}{Date of the story. N = 13907, unique = 363, min = 2011-01-01, max
#' = 2011-12-31. }
#'
#' \item{index.link}{Original link to the index page. N = 13907, unique = 363.}
#'
#' \item{language}{Whether the story was in English ("en") or Spanish ("es"),
#' according to KCNA itself. This classification is not wholly accurate; some
#' Spanish language stories appear as English language and vice-versa. N =
#' 13907, unique = 2. Best to use the classification in [headlines]. }
#'
#' \item{title}{The headline. N = 13322, unique = 12689. }
#' }
#' @family story data
#'
"KCNA_2011"

#' KCNA stories, 2012
#'
#' All stories for January-November 2012 harvested from the Japanese-hosted
#' [KCNA website](http://www.kcna.co.jp/index-e.htm) as of September 2014
#'
#' \describe{
#'
#' \item{story}{The actual story. N = 10340, unique = 10307.}
#'
#' \item{date}{Date of the story. N = 10869, unique = 335, min = 2012-01-01, max
#' = 2012-11-30.}
#'
#' \item{index.link}{Original link to the index page. May have changed since the
#' stories were harvested. N = 10869, unique = 10838. }
#'
#' \item{language}{Whether the story was in English ("en") or Spanish ("es"),
#' according to KCNA itself. N = 10869, unique = 2. This classification is not
#' wholly accurate; some Spanish language stories appear as English language and
#' vice-versa. Best to use the classification in [headlines].  }
#'
#' \item{title}{The headline. N = 10869, unique = 10400.}
#'
#' }
#'
#' @family story data
#'
"KCNA_2012"

#' Korean name components
#'
#' A list with the three possible components of a Korean name. [Harvested from
#' Wikipedia](https://en.wikipedia.org/wiki/List_of_Korean_given_names) and
#' updated manually to take into account KCNA's spelling preferences and some
#' unique names. Used in the file `Extracting_North_Korean_politicians.Rmd` in
#' the [`data-raw` folder on Github](https://github.com/xmarquez/KCNA/data-raw);
#' check that file for details.
#'
#' \describe{
#'
#' The list has three slots.
#'
#' \item{family_name}{Possible family names. N = 1002.}
#'
#' \item{first_syllable}{Possible first syllable of name. N = 268.}
#'
#' \item{Second syllable}{Possible second syllable of name. N = 266.}
#'
#' }
#'
"korean_names"

#' Potential names
#'
#' A data frame with patterns that are likely to be named entities within the headlines.
#'
#' \describe{
#'
#' \item{pattern}{A regular expression indicating a named entity.}
#'
#' \item{change_to}{A string indicating a useful substitution.}
#' }
#'
"potential_names"

#' Pre-processed corpus of KCNA headlines, January 1997-September 2014
#'
#' A preprocessed version of [headlines], suitable for some text analysis tasks.
#'
#' \describe{
#'
#' \item{date}{Date of the headline. Unique = 6087, min = 1997-01-01, max =
#' 2014-09-25. There are more duplicates here than in the [headlines] data file
#' because of the \code{mentioned} variable below.}
#'
#' \item{title}{The actual headline title. Unique = 101878. There are more
#' duplicates here than in the [headlines] data file because of the
#' \code{mentioned} variable below. }
#'
#' \item{english}{For \code{english_prob} > 0.5, we assume the headline is in
#' English. This is a reasonable assumption, but it isn't perfect; some spanish
#' language headlines may slip through, and some english headlines may be
#' misclassified, despite extensive checking.}
#'
#' \item{english_prob}{A number signifying the degree of agreement of four
#' different algorithms with respect to the question of whether the headline is
#' in English. 0 means none of the algorithms used classified the headline as
#' being in English; 1 means all of them do. See the `language_detection` Rmd
#' file in the [`data-raw` folder on
#' Github](https://github.com/xmarquez/KCNA/data-raw) for details. Headlines not
#' in english are in spanish. N = 115924}
#'
#' \item{story.link}{Link to the original story in the KCNA website. May have
#' changed since headlines were harvested; KCNA has been known to delete stories
#' or change links. N = 115924, unique = 114319. }
#'
#' \item{index.link}{Link to the original index page in the KCNA website. May
#' have changed since headlines were harvested; KCNA has been known to delete
#' stories or change links. N = 115924, unique = 6087. }
#'
#' \item{AFINN}{Sentiment score of the headline using the AFINN lexicon. `NA` if
#' no tokens in the sentence appear in the lexicon; note this should be `NA` for
#' all Spanish-language headlines. }
#'
#' \item{bing}{Sentiment score of the headline using the bing lexicon. `NA` if
#' no tokens in the sentence appear in the lexicon; note this should be `NA` for
#' all Spanish-language headlines.}
#'
#' \item{nrc}{Sentiment score of the headline using the NRC lexicon. `NA` if no
#' tokens in the sentence appear in the lexicon; note this should be `NA` for
#' all Spanish-language headlines.}
#'
#' \item{mentioned}{If a Korean-language name is detected (e.g., Kim Jong Il),
#' it is listed here.}
#'
#' \item{mentions_korean}{Logical. Whether a Korean person is mentioned.}
#'
#' \item{mentions_us}{Logical. Whether the headline mentions the USA or
#' Americans.}
#'
#' \item{mentions_south_korea}{Logical. Whether the headline mentions South
#' Korea or South Koreans.}
#'
#' \item{mentions_japan}{Logical. Whether the headline mentions Japan or
#' Japanese.}
#'
#' \item{mentions_china}{Logical. Whether the headline mentions China or
#' Chinese.}
#'
#' }
#' @family headline data
#'
"preprocessed_corpus"

#' A syntactically parsed corpus of the English-language KCNA headlines
#'
#' A syntactically parsed version and cleaned up version of the English-language
#' headlines  of [preprocessed_corpus], suitable for some text analysis tasks.
#' Includes part-of-speech (POS) tags for the words in the headlines, generated
#' by running the corpus through the [openNLP::Maxent_POS_Tag_Annotator()] POS
#' annotator.
#'
#' \describe{ \item{date}{Date of the headline. Unique = 6087, min = 1997-01-01,
#' max = 2014-09-25.}
#'
#' \item{processed_title}{The pre-processed headline title, for use with the
#' [openNLP::Maxent_POS_Tag_Annotator()] annotator. Processing the title
#' involves lowercasing, transforming many names to unigrams (e.g., "Kim Jong
#' Il" to "Kim_Jong_Il"), expanding many appreviations and standardazing
#' mentions of many organizations in preparation for part-of-speech (POS)
#' tagging. For details of the exact pre-processing steps, See the
#' `process_corpus` file in the [`data-raw` folder on
#' Github](https://github.com/xmarquez/KCNA/data-raw).}
#'
#' \item{words}{The word tokens found by the [openNLP] tokenizer tool. These are
#' not always identical to the tokens one would find by running a simpler
#' tokenizer tool, like [tokenizers::tokenize_words()].}
#'
#' \item{tags}{The part of speech (POS) tag, from the [Penn
#' Treebank](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html).
#' These tags are generated by running each headline through
#' [openNLP::Maxent_POS_Tag_Annotator()]. More accurate results could perhaps be
#' obtained by running the headlines through the a state-of-the art parser like
#' Stanford POS annotator (see http://stanfordnlp.github.io/CoreNLP/). But that
#' requires more memory and processing power than I had!}
#'
#' \item{probs}{The estimated probability (by
#' [openNLP::Maxent_POS_Tag_Annotator()]) that the word actually functions as
#' the tag says it does.}
#'
#' }
#' @family headline data
#'
"processed_corpus"

#' Abbreviations
#'
#' A short list of abbreviations found in the headlines and their expansion.
#'
#' \describe{
#'
#' \item{abbreviation}{A regular expression capturing an abbreviation
#' found in the headlines.}
#'
#' \item{replacement}{An expansion of the abbreviation. Used in conjunction with
#' [qdap::mgsub()] to expand the abbreviations in the headlines in the file
#' [processed_corpus]. See the `process_corpus` file in the [`data-raw` folder on
#' Github](https://github.com/xmarquez/KCNA/data-raw) for details.}
#' }
#' @family other data
#'
"abbreviations"

#' Country mentions
#'
#' A data frame containing country and demonym mentions in the headlines. It is
#' as comprehensive as possible, but there may be errors in it.
#'
#' \describe{
#'
#' \item{country_name}{The country name of the country or demonym found in the
#' headline.}
#'
#' \item{demonym_match}{An expression capturing the demonym (e.g., American,
#' Russian) found in the headline, if anything. If a country name is found, but
#' not a demonym, this defaults to `NA`. }
#'
#' \item{processed_title}{The title of the headline, as in [processed_corpus].
#' (This will not match exactly the original headline due to abbreviation
#' expansion, lowercasing, and the like, but it can be used for joins with
#' [processed_corpus]).}
#'
#' \item{lon}{The approximate longitude of the country.}
#'
#' \item{lat}{The approximate latitude of the country.}
#'
#' }
#' @family other data
#'
"country_mentions"


#' Person categories
#'
#' A data frame containing identifying material about the Korean people
#' mentioned in the headlines, taken from Wikipedia.
#'
#' \describe{
#'
#' \item{mentioned}{The person mentioned. Names are lowercased and formatted
#' with underscores instead of spaces.}
#'
#' \item{category}{A broad category to which the person belongs, according to
#' Wikipedia. People can belong to more than one category; for example, Kim Jong
#' Il belongs to "Kim dynasty (North Korea)", "Heads of state of North Korea",
#' "Members of the Supreme People's Assembly" and Worker's Party of Korea
#' Politicians". Not every person mentioned in the headlines is found in
#' Wikipedia, or has sufficient information associated with it in the DBpedia
#' ontology to assign a category. This is especially the case for minor North
#' Korean politicians mentioned perhaps once or twice in the headlines.}
#'
#' \item{uri}{The [http://dbpedia.org](http://dbpedia.org) link from which the
#' information was scraped.}
#'
#' \item{n}{The number of mentions of the person in the English-language
#' headlines.}
#'
#' }
#'
#' @family other data
#'
"person_categories"

#' Potential Names
#'
#' A list of regular expression patterns that typically indicate names of people
#' or organizations found in the headlines.
#'
#' \describe{
#'
#' \item{pattern}{A regular expression capturing an abbreviation found in the
#' headlines.}
#'
#' \item{change_to}{A replacement that expands, uppercases, or disambiguates the
#' regex match in the headlines. Used in conjunction with
#' [qdap::mgsub()] to expand the abbreviations in the headlines in the file
#' [processed_corpus]. See the `process_corpus` file in the [`data-raw` folder on
#' Github](https://github.com/xmarquez/KCNA/data-raw) for details.}
#' }
#'
#' @family other data
#'
"abbreviations"


#' Headlines from the Japanese-hosted [KCNA website](http://www.kcna.co.jp/index-e.htm)
#' as of September 2014.
#'
#' Headlines from the Korean Central News agency, January 1997-September 2014,
#' in a format suitable for Natural Language Processing, along with several other
#' small datasets and convenience functions to work with these headlines. Also
#' includes most of the KCNA stories from 2011 and 2012.
#'
#' The main dataset is [preprocessed_corpus], though you may also need to use
#' [processed_corpus] for some tasks.
#'
"_PACKAGE"
