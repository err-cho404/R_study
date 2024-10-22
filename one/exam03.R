english<-c(90,80,60,100)
math<-c(50,60,100,95)
df_midterm<-data.frame(english,math)
df_midterm
mean(df_midterm$english) #구분자는 $ 사용
max(df_midterm$english) #최대값 구하기

df_midterm2 <- data.frame( #=>2차원 배열 열과 행(컬럼명)이 있음
  eng=c(90,80,60,100),
  mat=c(50,60,100,95),
  class=c(1,2,1,2)
)
df_midterm2


#vector() =>1차원 배열(list)
#matrix() =>2차원 배열(행렬) 컬럼명이 없음, 일련번호가 붙음
#array() =>3차원이상의 배열