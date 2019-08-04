library("adegenet")
library("ggplot2")
############################################
myFile <- import2genind("pumas-CO.stru") 
############################################
help(scaleGen)
X <- scaleGen(myFile, NA.method="zero")
pca1<-dudi.pca(X,cent=FALSE,scale=FALSE,scannf=FALSE,nf=3)
############################################
myCol <-c("darkgreen","darkblue")
s.class(pca1$li,pop(myFile), col=myCol)
add.scatter.eig(pca1$eig[1:20], 3,1,2)
############################################
s.label(pca1$li)
############################################
dapc1<-dapc(X,pop(myFile))
scatter(dapc1)
summary(dapc1)
contrib<-loadingplot(dapc1$var.contr,axis=1,thres=.07,lab.jitter=1)
############################################
compoplot(dapc1,posi="bottomright",lab="",
			ncol=1,xlab="individuals") 
############################################
assignplot(dapc1, subset=1:40)			
assignplot(dapc1, subset=41:80)
assignplot(dapc1, subset=81:100)
assignplot(dapc1, subset=101:134)
############################################
install.packages('hierfstat', dependencies=TRUE)
library(hierfstat)

############################################
myFile <- import2genind("Msi_GP_in.gen") 
