
##7장-데이터 정제##

library(dplyr)

df<-data.frame(sex = c("M","F",NA,"M","F"), # 결측치값을 가진 행렬 생성
               score = c(5,4,3,4,NA))
df
is.na(df) # 각 데이터의 결측치 확인 -> is.na 는 IS NA? 이것이 NA인지 묻는 함수
table(is.na(df)) # 각 데이터의 결측치 개수
table(is.na(df$sex))
table(is.na(df$score))

# NA결측치 데이터가 들어가 있으면 정상적인 연산이 불가
mean(df$score)
sum(df$score)

df %>% filter(is.na(score))
df %>% filter(!is.na(score))

df_nomiss<-df %>% filter(!is.na(score)) # score에 NA결측치를 뺀 결과를 df_nomiss에 저장
mean(df_nomiss$score) # NA결측치 데이터가 빠져 정상적인 연산 가능
sum(df_nomiss$score)

df_nomiss<-df %>% 
  filter(!is.na(score)&!is.na(sex)) # sex와 score에 NA결측치를 뺀 결과를 df_nomiss에 저장
df_nomiss

df_nomiss2<-na.omit(df) # 모든NA결측치를 뺀 결과를 df_nomiss2에 저장
df_nomiss2

mean(df$score,na.rm = T) # NA결측치 제외하고 평균 산출 (na.rm -> NA remove?)
sum(df$score,na.rm = T) # NA결측치 제외하고 합계 산출

exam<-read.csv("D:/rpawork/workspace/rstudy/Data/csv_exam.csv")
exam[c(3,8,15),"math"]<-NA # math항목의 3,8,15행에 NA 집어넣음
exam
exam %>%  summarise(mean_math = mean(math,na.rm = T),
                    sum_math = sum(math,na.rm = T),
                    median_math = median(math,na.rm = T))

exam$math<-ifelse(is.na(exam$math),55,exam$math) # exam의 math항목의 값이 NA면 55로 출력, NA가 아니라면 그대로 값 출력
table(is.na(exam$math)) # 위의 내용을 결측치 빈도표로 출력 -> FALSE는 결측치 없다는 뜻
mean(exam$math) # 결측치 3,8 15행의 math값이 가 모두 55로 대체되어 정상적으로 출력된다.



#이상치를 NA(결측치)로 처리해 정제하기
outlier<-data.frame(sex=c(1,2,1,3,2,1),
                    score=c(5,4,3,4,2,6))
outlier
table(outlier$sex) # 이상치는 table로 존재 값 확인 가능 성별은 1,2만 있어야하는데 3이 1개가 있으므로 수정해야함
table(outlier$score) # 점수은 1~5의 값으로 그 미만이나 초과의 값은 수정해야함 6이 1개 있으므로 수정필요
outlier$sex<-ifelse(outlier$sex==3,NA,outlier$sex) # 이상치 3은 NA 결측치로 바꾸고 나머지는 그대로 유지
outlier$score<-ifelse(outlier$score==6,NA,outlier$score)
outlier # 이상치들을 NA로 바꿨으니 na.rm으로 NA값 제외하고 연산 가능
outlier %>% 
  filter(!is.na(sex)&!is.na(score)) %>%  # NA값을 제외시킴
  group_by(sex) %>% # 성별로 묶음
  summarise(avegscore=mean(score)) # 성별끼리 묶은 score의 평균을 구함



# 극단치를 NA(결측치)로 처리해 정제하기
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats 
# [1,]부터 순서대로 아래쪽 극단치 경계(12), 1사분위수(18), 중앙값(24), 3사분위수(27),위쪽 극단치 경계(37)로
# 12~37을 넘어가면 극단치로 분류되는걸 확인할 수 있다.

# 극단치를 NA(결측치)처리한다.
mpg$hwy<-ifelse(mpg$hwy<12|mpg$hwy>37,NA,mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy,na.rm = T)) # hwy값 중 NA(결측치)를 제외한 값들로 평균계산



# data.frame - > 데이터 프레임 생성
# as.data.frame -> 다른 객체를 데이터 프레임으로 변환
mpg<-as.data.frame(ggplot2::mpg) 
mpg[c(10,14,58,93),"drv"]<-"k" # 10,14,58,93번행의 drv에 k라는 이상치를 넣어줌
mpg[c(29,43,129,203),"cty"]<-c(3,4,39,42) # 29,43,129,203번행의 cty도시연비 값에 극단적으로 작고(3,4) 큰(129,203) 이상치를 넣어줌
mpg

# 이상치 먼저 확인
table(mpg$drv)
table(mpg$cty)
# 그래프로 극단치와 정상범위 확인
boxplot(mpg$cty)$stats
#이상치에 결측치 집어넣기
mpg$drv<-ifelse(mpg$drv=="k",NA,mpg$drv)
table(mpg$drv)
mpg$cty<-ifelse(mpg$cty<9|mpg$cty>26,NA,mpg$cty)
table(mpg$cty)
#결측치 제외한 값으로 데이터 분석
mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(ctyaveg=mean(cty))
