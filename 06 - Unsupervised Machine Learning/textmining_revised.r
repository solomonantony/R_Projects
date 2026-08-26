# uncomment following lines and execute if packages are not installed yet
# install.packages("tm")    
# install.packages("SnowballC")
# install.packages("ggplot2")
# install.packages("wordcloud")
# install.packages("RColorBrewer")

library(tm)
library(SnowballC)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)

#read in collection of documents in raw form
original_corpusdf <- read.csv("triad_r.csv")

# read in collection of documents using VCorpus function
corpusdf <- VCorpus(DataframeSource(read.csv("triad_r.csv", header = TRUE)))

# summary information on corpus just read in
corpusdf

# remove punctuation from corpus
corpusdf <- tm_map(corpusdf, removePunctuation)

# remove numbers from corpus 
corpusdf <- tm_map(corpusdf, removeNumbers)

# remove extraneous blanks from corpus
corpusdf <- tm_map(corpusdf, stripWhitespace)

# convert all text to lower case
corpusdf <- tm_map(corpusdf, content_transformer(tolower))

# remove common words (a, an, the, and, but, is, etc.)
corpusdf <- tm_map(corpusdf, removeWords, stopwords("english"))

# execute stemming to reduce words to common roots
corpusdf <- tm_map(corpusdf, stemDocument)

# generate frequency document-term matrix
dtmFreq <- DocumentTermMatrix(corpusdf)
freqMatrix <- as.matrix(dtmFreq)

# compute frequency of terms over entire corpus
# store in list in decreasing order of frequency
wordfreq <- colSums(freqMatrix)
v <- sort(wordfreq, decreasing = TRUE)
v

# create data frame containing words and their frequencies
df_terms <- data.frame(word = names(v), freq = v)

# generate binary (absence-presence) document-term matrix
dtmBin <- DocumentTermMatrix(corpusdf, control = list(weighting = weightBin))
binaryMatrix <- as.matrix(dtmBin)

# compute frequency of documents containing terms
# store in list in decreasing order of frequency
wordfreq <- colSums(binaryMatrix)
w <- sort(wordfreq, decreasing = TRUE)
w

# create data frame containing terms and in how many documents they appear
df_docs <- data.frame(word = names(v), freq = w)


# create word cloud using words and frequencies from df_wc
# specify minimum frequency = 1, maximum number of words = 200, 
# words plotted in decreasing frequency (not random order),
# 35% of words plotted with 90 degree rotation, 
# and use 8 different colors from Dark2 palette in RColorBrewer library
wordcloud(words = df_terms$word, freq = df_terms$freq, min.freq = 1,
          max.words=200, rot.per=0.35, random.order = FALSE, colors=brewer.pal(8, "Dark2"))

# create binary document-term matrix based on 
# five most frequent terms in corpus
binMat5 <- binaryMatrix[,c("flight", "seat", "servic", "delay", "horribl")]
# View(binMat5)

# write out binary document-term matrix to file
write.csv(binMat5, file = "triad_binarydtm.csv")



