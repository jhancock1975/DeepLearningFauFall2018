library(pixmap)  
library(gdata)

png(filename="right-example.png")
right1<-read.pnm(file="/home/jhancock2010/git/DeepLearningFauFall2018/hw-2/right/tammo_right_angry_sunglasses_4.pgm")
plot(right1)
dev.off()

png(filename="left-example.png")
left1<-read.pnm(file="/home/jhancock2010/git/DeepLearningFauFall2018/hw-2/left/karyadi_left_neutral_open.pgm")
plot(left1)
dev.off()

png(filename="straight-example.png")
left1<-read.pnm(file="/home/jhancock2010/git/DeepLearningFauFall2018/hw-2/straight/tammo_straight_happy_open_4.pgm")
plot(left1)
dev.off()


left1.matrix<-left1@grey
# left1

left1.vector<-unmatrix(left1.matrix,byrow=T)
left1.frame<-data.frame(left1.vector)
left1.frame
dim(left1.frame)

loadImages <- function(pathName,fileNames, clasLabel) {
  files<-list.files(path=pathName,pattern=fileNames,all.files=T,full.name=T,no..=T)
  list_of_images=lapply(files,read.pnm)
  plot(list_of_images[[1]])
  n.images<-length(list_of_images)
  image.matrix<-list_of_images[[1]]@grey
  image.vector<-unmatrix(image.matrix,byrow=T)
  for(ii in 2:n.images) {
   i.matrix<-list_of_images[[ii]]@grey
   i.vector<-unmatrix(i.matrix,byrow=T)
   image.vector<-rbind(image.vector,i.vector)
  }
  image.frame<-data.frame(image.vector)
  n.rows<-nrow(image.frame)
  class1.label<-rep(clasLabel,n.rows)
  image.frame<-cbind(image.frame,class1.label)
  return (image.frame)
}

left.frame <- loadImages("/home/jhancock2010/git/DeepLearningFauFall2018/hw-2/left/","*left*",1)

right.frame <- loadImages("/home/jhancock2010/git/DeepLearningFauFall2018/hw-2/right/","*right*",-1)

total.frame<-rbind(left.frame,right.frame)
dim(total.frame)

train.index<-sample(nrow(total.frame),nrow(total.frame)*0.4)

training.set<-total.frame[train.index,]

test.set<-total.frame[-train.index,]

library(neuralnet)

for (num_hidden in c(3,5,7,9,11)){
  myform <- as.formula(paste('class1.label ~ ',
    paste(names(training.set[!names(training.set) %in% 'class1.label']), 
    collapse = ' + ')))
  face.classifier <- neuralnet(myform, training.set, hidden = num_hidden, rep=5, 
    linear.output = FALSE, threshold = 0.1)
  
  
  summary(face.classifier)
  
  class.index<-length(test.set)
  face.prediction<-compute(face.classifier,test.set[,-class.index])
  face.prediction$net.result
  
  classifications<-ifelse(face.prediction$net.result>0.5,1,-1)
  
  table(test.set[,class.index],classifications)
  
  face.4.3.classifier <- neuralnet(myform, training.set, hidden = c(4,3), rep=1000, linear.output = FALSE, threshold = 0.1)
  face.prediction<-compute(face.4.3.classifier,test.set[,-class.index])
  face.prediction$net.result
  classifications<-ifelse(face.prediction$net.result>0.5,1,-1)
  classifications
  
  table(test.set[,class.index],classifications)
}
