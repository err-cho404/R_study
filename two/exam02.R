rm(list = ls()) #evironment 메모리 삭제 명령어
mpg<- as.data.frame(ggplot2::mpg)
mpg
head(mpg)
tail(mpg)
dim(mpg)
str(mpg)
summary(mpg)
names(mpg)[8:9]<-c("cty","hwy")
mpg
?mpg
head(mpg,15)
tail(head(mpg,20),10)
mpg[,c(1,8:9)]
mpg$cityhighwaver<-(mpg$cty+mpg$hwy)/2
mpg$cityhighwaveraverkm<-(mpg$cityhighwaver)*1.6
mpg$literperkm<-(mpg$cityhighwaveraverkm)/3.785
mpg
names(mpg)[8:9]<-c("cty","hwy")
summary(mpg)
summary(mpg[,c("cityhighwaver","cityhighwaveraverkm","literperkm")])

head(mpg[order(mpg$literperkm),c(1:2,14)],10)
head(mpg[order(-mpg$literperkm),c(1:2,14)],10)

mpg$test<- ifelse(mpg$cityhighwaver>=15,"pass","fail")
mpg
head(mpg,20)

table(mpg$test)

mpg$grade<-ifelse(mpg$cityhighwaver>=30,"A",
       ifelse(mpg$cityhighwaver>=23,"B",
              ifelse(mpg$cityhighwaver>=15,"C","D")))
table(mpg$grade)

qplot(mpg$grade)
mpg




xor()
c(T,T,F,F) & c(T,F,F,T)
c(T,T,F,F) | c(T,F,F,T)
c(0,1,1,10) | c(T,F,F,T)
c(0,1,1,10) & c(T,F,F,T)

x<-50; y<-4; z<-x*y
z
if(z>=120){
  cat("120 이상입니다")
}else{
  cat("120 이하입니다")    
}

ifelse(z>=120,"120 이상입니다","120 이하입니다")

if(z>=120){
  "120 이상입니다"
}else{
  "120 이하입니다"
}

result <- ifelse(z>=120,"120 이상입니다","120 이하입니다")
result

c(1:10)
for (n in i) {
  cat("영구없다")
}
result <- for (n in i) {
  "영구없다"
}
result

result <- (for (n in i) {
  print("영구없다")
})
result


score<-c(80,60,90)
name<-c("김","이","박")
exam<-data.frame(score,name)
exam
i=1

for(n in names(exam)){
  cat(exam$n,"\n")
}


