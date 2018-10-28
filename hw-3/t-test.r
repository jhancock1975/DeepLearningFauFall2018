num_trials <- 10
nn_acc <- vector("list", num_trials)

# list of RBF accuracies,
# will use to compare mean value of neural network accuracy
rbf_acc <- vector("list", num_trials)

for (trial in 1:num_trials){
  nn_acc[[trial]] <-  runif(1, 0.99999, 1)
  rbf_acc[[trial]] <-  runif(1, 0.99999, 1)
}
t.test(as.numeric(nn_acc), as.numeric(rbf_acc), alternative="two.sided", mu = 0,
  paired = FALSE, var.equal = FALSE, conf.level = 0.95)
