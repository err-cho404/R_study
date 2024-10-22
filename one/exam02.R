install.packages("ggplot2")
library(ggplot2)
qplot(c("a","b","a","a","b","c","a","a"))
mpg #샘플 데이터
qplot(data=mpg,x=hwy)
qplot(data=mpg,x=cty)
qplot(data=mpg,x=hwy,y=drv)
qplot(data=mpg,x=drv,y=hwy)
qplot(data=mpg,x=hwy,y=drv,geom = "line")
qplot(data=mpg,x=hwy,y=drv,geom = "boxplot")
qplot(data=mpg,x=hwy,y=drv,geom = "boxplot",color = drv)
?qplot
a<-20
aa
