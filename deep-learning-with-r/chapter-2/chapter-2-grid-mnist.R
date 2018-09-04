# this code is copied from 
#Deep Learning with R
#by François Chollet with J. J. Allaire
#Published by Manning Publications, 2018

library(keras)

num_networks = 2

num_units_list=c(512,600)

activation_func_list=c("relu","softmax", "elu", "selu", "softplus", "softsign",
  "tanh", "sigmoid", "hard_sigmoid", "linear")

create_networks <- function(){ 
  networks <- vector("list", num_networks)
  for (num_units in num_units_list){
   for (activ_func in activation_func_list){ 
    network <- keras_model_sequential() %>%

     layer_dense(units = num_units, activation = activ_func, 
       input_shape = c(28 * 28)) %>%

     layer_dense(units = 10, activation = "softmax")
   
   network %>% compile(
     optimizer = "rmsprop",
     loss = "categorical_crossentropy",
     metrics = c("accuracy")
     )   
    }
  }
  return(networks)
}

mnist <- dataset_mnist()
train_images <- mnist$train$x
train_labels <- mnist$train$y
test_images <- mnist$test$x
test_labels <- mnist$test$y



train_images <- array_reshape(train_images, c(60000, 28 * 28))
train_images <- train_images / 255

test_images <- array_reshape(test_images, c(10000, 28 * 28))
test_images <- test_images / 255

train_labels <- to_categorical(train_labels)
test_labels <- to_categorical(test_labels)

networks <- create_networks()

for (network in networks){
  network %>% fit(train_images, train_labels, epochs = 5, batch_size = 128)
  metrics <- network %>% evaluate(test_images, test_labels)
  metrics
}


