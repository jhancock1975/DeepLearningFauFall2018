library(keras)

model <- keras_model_sequential() %>% layer_dense(units=32,input_shape=c(784)) %>% layer_dense(units=10, activation="softmax")

model

model %>% compile(optimizer=optimizer_rmsprop(lr=0.0001),loss="mse", 
  metrics=c("accuracy"))



