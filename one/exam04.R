install.packages("readxl")
library(readxl)
df_exam<-read_excel("D:/rpawork/workspace/rstudy/Data/excel_exam.xlsx")
df_exam2<-read_excel("D:/rpawork/workspace/rstudy/Data/excel_exam.xlsx",sheet='Sheet2',col_names = FALSE)
df_exam
df_exam2
names(df_exam2)
names(df_exam2) <- c("id","class","kor","eng","mat")
names(df_exam2)
str(df_exam2) #데이터 프레임의 구조확인
summary(df_exam)

mean(df_exam$math)
max(df_exam$math)
max(df_exam$english)
mean(df_exam$english)
mean(df_exam$science)
min(df_exam$science)
?read_excel



#csv_exam<-read.csv("D:/rpawork/workspace/rstudy/Data/csv_exam.csv")
csv_exam<-read.csv("../Data/csv_exam.csv",header = F,skip = 3)
csv_exam
summary(csv_exam)

#===============================================
df_text<-read.table("D:/rpawork/workspace/rstudy/Data/csv_exam.txt",header = T,sep = ",")
df_text

summary(df_text)

