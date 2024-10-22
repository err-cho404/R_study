m <- matrix(c(1:6))
m
m2 <- matrix(c(1:10), nrow = 2)
m2
m3 <- matrix(c(1:10), ncol = 2)
m3
m4<- matrix(c(1:10), ncol = 2, byrow = T)
m4

x1 <- c(5,40,50:52)
x2 <- c(30,6:9)
x1
x2
m5 <- cbind(x1,x2)
m5*3

m6 <- matrix(c(1,"hong",150,
               2,"lee",250,
               3,"kim",350),3, by=T)
m6

m7 <- matrix(c(1,hong,150,
               2,lee,250,
               3,kim,350),3, by=T)

hong<-"hong"
lee<-150
kim<-100
df_metdata<-data.frame(m7)
df_metdata

df_vector <- data.frame(hakbun=c(1:3),name=c("kim","lee","park"))
df_vector

write.csv(df_vector,file = "test.csv") #공용 언어에서 사용할 수 있도록

#R전용 데이터(.rds)로 만들 수 있다
saveRDS(df_vector,file = "test.rds")


aa<-readRDS("test.rds")
aa

