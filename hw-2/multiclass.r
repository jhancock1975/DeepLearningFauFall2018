library (neuralnet)

data(iris)

#Add a "fake" class to allow for all factors
levels(iris$Species) <- c(levels(iris$Species),"fake")
print(levels)

#Relevel to make the fake class the factor
iris$Species <- relevel(iris$Species,ref = "fake")
#Create dummy variables and remove the intercept
iris_multinom <- model.matrix(~Species+Sepal.Length+
                                Petal.Length+Petal.Width,
                              data=iris)[,-1]
 
colnames(iris_multinom)[1:3] <- c("setosa","versicolor","virginica")
 
 
nn_multi <- neuralnet(setosa+versicolor+virginica~
                 Sepal.Length+Petal.Length+Petal.Width,
               data=iris_multinom,hidden=5,lifesign = "minimum",
               stepmax = 1e+05,rep=10)
res <- compute(nn_multi, iris_multinom[,-c(1:3)])
