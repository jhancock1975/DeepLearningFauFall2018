# this code and some comments are copied from chapter 3 of
# Deep Learning with R
# by François Chollet with J. J. Allaire
# Published by Manning Publications, 2018

library(keras)

imdb <- dataset_imdb(num_words=10000)

c(c(train_data, train_labels) , c(test_data, test_labels)) %<-% imdb

# word index is a named list mapping words to an integer index
word_index <- dataset_imdb_word_index() 

# One-hot encode your lists to turn them into vectors of 0s and 1s. 
# This would mean, for instance, turning the sequence [3, 5] into a 
# 10,000-dimensional vector that would be all 0s except for indices 3 and 5, 
# which would be 1s. Then you could use as the first layer in your network a 
# dense layer, capable of handling floating-point vector data.
vectorize_sequences <- function(sequences, dimension = 10000) {
  results <- matrix(0, nrow = length(sequences), ncol = dimension) 
  for (i in 1:length(sequences))
    results[i, sequences[[i]]] <- 1
  results
}

model <- keras_model_sequential() %>%
  layer_dense(units = 16, activation = "relu", input_shape = c(10000)) %>%
  layer_dense(units = 16, activation = "relu") %>%
  layer_dense(units = 1, activation = "sigmoid")

model %>% compile(
  optimizer = "rmsprop",
  loss = "binary_crossentropy",
  metrics = c("accuracy")
)

x_train <- vectorize_sequences(train_data)
x_test <- vectorize_sequences(test_data)


val_indices <- 1:10000

x_val <- x_train[val_indices,]
partial_x_train <- x_train[-val_indices,]
y_val <- y_train[val_indices]
partial_y_train <- y_train[-val_indices]

history <- model %>% fit(
  partial_x_train,
  partial_y_train,
  epochs = 20,
  batch_size = 512,
  validation_data = list(x_val,y_val)
)
