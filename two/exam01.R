library(readxl)
library("ggplot2")
df_exam<-read_excel("D:/rpawork/workspace/rstudy/Data/excel_exam.xlsx")
df_exam
dim(df_exam)
head(df_exam,8)
tail(head(df_exam,17),4)
View(df_exam)
str(df_exam)
df_exam$id
df_exam[,3]
df_exam[5:8,2:4]
df_exam[5:8,c("class","math","english")]
colist =c("class","math")
df_exam[5:8,colist]
df_exam[c(5,2),colist]
a<-5:8
df_exam[a,colist]
summary(df_exam)
summary(df_exam$math)


