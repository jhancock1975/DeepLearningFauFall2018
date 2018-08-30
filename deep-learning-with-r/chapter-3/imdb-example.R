"this code and some comments are copied from chapter 3 of" 
"Deep Learning with R"
"by François Chollet with J. J. Allaire"
"Published by Manning Publications, 2018"

library(keras)

imdb <- dataset_imdb(num_words=10000)

c(c(train_data, train_labels) , c(test_data, test_labels)) %<-% imdb

str(train_data[1])

train_labels[[1]]

"word index is a named list mapping words to an integer index"
word_index <- dataset_imdb_word_index() 

"reverse it mapping integer indices to words"
reverse_word_index <- names(word_index)
decoded_review <- sapply(trainn_data[[1]], function(index){
  word <- if(index >= 3) reverse_word_index[[as.character(index -3)]]
  if (! is.null(word)) word else "?"
})

