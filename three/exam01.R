
##6장-데이터가공##

install.packages("dplyr")
library(dplyr)
exam<- read.csv("D:/rpawork/workspace/rstudy/Data/csv_exam.csv")

exam
exam%>%filter(class == 1) # %>% -> 파이프 연산자 ctrl shift m
exam%>%filter(class ==2) # == -> 같다

exam%>%filter(class!=1) # != -> 같다
exam%>%filter(class!=3)

exam%>%filter(math>50) # <,>,>=,<= -> 비교연산자
exam%>%filter(math<50)
exam%>%filter(english>=80)
exam%>%filter(english<=80)

exam%>%filter(class==1 & math >=50) # & -> and연산자
exam%>%filter(class==2 & english>=80)
exam%>%filter(math>=90|english>=90) # | -> or연산자
exam%>%filter(english<90|science<50)
exam%>%filter(class==1|class==3|class==5)

exam%>%filter(class %in% c(1,3,5)) # %n% -> 매치연산자

class1<- exam %>% filter(class==1) # 특정조건으로 추출한 내용을 재할당
class2<- exam %>% filter(class==2)
mean(class1$math) # 재할당한 데이터의 math값 평균 
mean(class2$math)

#배기량이 4이하인 자동차와 5이상인 자동차의 고속도로 연비 평균 비교
mpg
displyfour<-mpg %>% filter(displ<=4)
displyfive<-mpg %>% filter(displ>=5)
mean(displyfour$hwy)
mean(displyfive$hwy)

#아우디와 도요타의 도시연비 평균 비교
brandaudi<-mpg %>% filter(manufacturer=="audi")
brandtoyota<-mpg %>% filter(manufacturer=="toyota")
mean(brandaudi$cty)
mean(brandtoyota$cty)

#쉐보레,포드,혼다 세 브랜드의 고속도로 연비 평균
brandchevofordhonda<-mpg %>% filter(manufacturer=="chevolet"|manufacturer=="ford"|manufacturer=="honda")
brandchevofordhonda<-mpg %>% filter(manufacturer %in% c("chevolet","ford","honda")) # 다양한 조건 찾기 방법을 활용하기 
cfhhwymean<-mean(brandchevofordhonda$hwy)
cfhhwymean


exam %>% select(math) # select -> 일부 변수만 추출하는 기능
exam %>% select(english)
exam %>% select(class,math,english)
exam %>% select(-math) # (-)변수 -> 일부 변수만 제외하고 추출하는 기능
exam %>% select(-math,-english)

exam %>% filter(class==1) %>% select(english) # dplyr함수조합 -> 1학생의 영어점수 추출
exam %>% # dplyr함수조합시 줄바꿈으로 가독성 높이기
  filter(class==1) %>% 
  select(english)
exam %>% 
  select(id, math) %>% 
  head(3)

#class와 cty로만 이루어진 데이터 생성
classcty<-mpg %>% select(class, cty)

#위의 데이터를 이용해 class가 suv, compact인 두 도시연비 평균을 비교
suvcty<-classcty %>% 
  filter(class=="suv") %>% 
  select(cty)
compactcty<-classcty %>% 
  filter(class=="compact") %>% 
  select(cty)
mean(suvcty$cty)
mean(compactcty$cty)

exam %>% arrange(math) #수학점수를 기준으로 정렬(점수 낮은 순 -> 오름차순)
exam %>% arrange(desc(math)) # (점수 높은 순 -> 내림차순)
exam %>% arrange(class,math) # class를 오름차순으로 정렬후 math를 오름차순으로 정렬

# audi 자동차 중 고속도로 연비가 높은 모델 1~5위 추출
mpg %>% 
  filter(manufacturer=="audi") %>% 
  arrange(desc(hwy)) %>% 
  head(5)

exam %>% 
  mutate(total = math+english+science) %>% # mutate ->새 변수 추가 (변수명 = 변수를 만드는 공식)
  head
exam %>% 
  mutate(total = math+english+science,
         mean = (total)/3) %>%
  head
exam %>% 
  mutate(test = ifelse(science>=60,"pass","fail")) %>% 
  head
exam %>% 
  mutate(total = math+english+science) %>%  
  arrange(total) %>% # mutate 로 만든 새변수를 바로 dplyr코드에 이어서 사용가능
  head

#고속도로, 도시연비의 합산과 합산평균목록을 생성하고 평균을 기준으로 정렬해 1~3위 데이터를 구함
mpg %>% 
  mutate(sumctyhwy=cty+hwy,
         aveg=sumctyhwy/2) %>% 
  arrange(aveg) %>% 
  head(3)

# summarise -> 집단별 평균,빈도 같은 요약값을 구할때 사용(변수명 = 변수를 만드는 공식),group by를 조합해 사용
exam %>% summarise(mean_math = mean(math)) 
exam %>% group_by(class) %>% # class별로 그룹지어 그룹들의 math평균을 구함
  summarise(mean_math=mean(math))
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n=n()) # n() -> 학생 수 count(행을 카운드)
mpg %>% 
  group_by(manufacturer,drv) %>% # 제조사>구동 방식별로 묶음
  summarise(mean_cty = mean(cty)) %>% 
  head(10) 

mpg %>% 
  filter(class=="suv") %>% 
  group_by(manufacturer) %>% 
  mutate(total=cty+hwy) %>% 
  summarise(aveg=mean(total)) %>% 
  arrange(desc(aveg)) %>% 
  head(5)

#자동차구동방식별 자동차제조사의 도시연비평균 비교, 어느 차종의 도시연비가 높은지 도시연비평균이 높은 순으로 정렬 
mpg %>% 
  group_by(class) %>% 
  summarise(avegcty=mean(cty)) %>% 
  arrange(desc(avegcty))

#고속도로연비평균이 가장 높은 회사 세곳
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(aveghwy=mean(hwy)) %>% 
  arrange(desc(aveghwy)) %>% 
  head(3)

#compact경차를 제일 많이 생산하는 회사, 생산 차종 수를 내림차순으로 정렬
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n=n())%>% 
  arrange(desc(n))

#데이터에 다른 데이터를 담은 변수추가
test1<-data.frame(id=c(1,2,3,4,5),
                  midterm = c(60,80,70,90,85))
test2<-data.frame(id=c(1,2,3,4,5),
                  final=c(70,83,65,95,80))

test1
test2
total<-left_join(test1,test2,by = "id")
total

name<-data.frame(class=c(1,2,3,4,5),
                 teacher = c("kim","lee","park","choi","jung"))
name
exam_new<-left_join(exam,name,by = "class")
exam_new

#데이터를 세로로 합침 -> 변수명이 같아야함
group_a<-data.frame(id=c(1,2,3,4,5),
                    test=c(60,80,70,90,85))
group_b<-data.frame(id=c(6,7,8,9,10),
                    test=c(70,83,65,95,80))
group_all<-bind_rows(group_a,group_b)
group_all

mpg$fl


#연료종류와 가격 항목 mpg데이터에 추가
fuel<-data.frame(fl=c("c","d","e","p","r"),
                 price_fl=c(2.35,2.38,2.11,2.76,2.22))
fuel
mpg<-left_join(mpg,fuel,by = "fl") # 공통 항목인 fl을 기준으로 합침
mpg %>% 
  select(model,fl,price_fl) %>% 
  head(5)
names(mpg)[17:18]<-c("price_fl","price_fl2") # 열 이름 변경
mpg[,-18] # 18열 삭제
