% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/headlines.R
\docType{data}
\name{preprocessed_corpus}
\alias{preprocessed_corpus}
\title{Pre-processed corpus of KCNA headlines, January 1997-September 2014}
\format{An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 115924 rows and 15 columns.}
\usage{
preprocessed_corpus
}
\description{
A preprocessed version of \link{headlines}, suitable for some text analysis tasks.
}
\details{
\describe{

\item{date}{Date of the headline. Unique = 6087, min = 1997-01-01, max =
2014-09-25. There are more duplicates here than in the \link{headlines} data file
because of the \code{mentioned} variable below.}

\item{title}{The actual headline title. Unique = 101878. There are more
duplicates here than in the \link{headlines} data file because of the
\code{mentioned} variable below. }

\item{english}{For \code{english_prob} > 0.5, we assume the headline is in
English. This is a reasonable assumption, but it isn't perfect; some spanish
language headlines may slip through, and some english headlines may be
misclassified, despite extensive checking.}

\item{english_prob}{A number signifying the degree of agreement of four
different algorithms with respect to the question of whether the headline is
in English. 0 means none of the algorithms used classified the headline as
being in English; 1 means all of them do. See the \code{language_detection} Rmd
file in the \href{https://github.com/xmarquez/KCNA/data-raw}{data-raw folder onGithub} for details. Headlines not
in english are in spanish. N = 115924}

\item{story.link}{Link to the original story in the KCNA website. May have
changed since headlines were harvested; KCNA has been known to delete stories
or change links. N = 115924, unique = 114319. }

\item{index.link}{Link to the original index page in the KCNA website. May
have changed since headlines were harvested; KCNA has been known to delete
stories or change links. N = 115924, unique = 6087. }

\item{AFINN}{Sentiment score of the headline using the AFINN lexicon. \code{NA} if
no tokens in the sentence appear in the lexicon; note this should be \code{NA} for
all Spanish-language headlines. }

\item{bing}{Sentiment score of the headline using the bing lexicon. \code{NA} if
no tokens in the sentence appear in the lexicon; note this should be \code{NA} for
all Spanish-language headlines.}

\item{nrc}{Sentiment score of the headline using the NRC lexicon. \code{NA} if no
tokens in the sentence appear in the lexicon; note this should be \code{NA} for
all Spanish-language headlines.}

\item{mentioned}{If a Korean-language name is detected (e.g., Kim Jong Il),
it is listed here.}

\item{mentions_korean}{Logical. Whether a Korean person is mentioned.}

\item{mentions_us}{Logical. Whether the headline mentions the USA or
Americans.}

\item{mentions_south_korea}{Logical. Whether the headline mentions South
Korea or South Koreans.}

\item{mentions_japan}{Logical. Whether the headline mentions Japan or
Japanese.}

\item{mentions_china}{Logical. Whether the headline mentions China or
Chinese.}

}
}
\seealso{
Other headline data: \code{\link{headlines}},
  \code{\link{processed_corpus}}
}
\keyword{datasets}
