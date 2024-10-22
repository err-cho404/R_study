
##8장-그래프 만들기##

library(ggplot2)

ggplot(data=mpg,aes(x=displ,y=hwy)) # x(배기량),y(고속도로연비)축 항목 설정해 그래프의 배경 생성
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_point() # ggplot2 패키지는 %>% 가 아닌 +로 함수를 연결함/그래프에 산점도 추가

ggplot(data=mpg,aes(x=displ,y=hwy))+ # 그래프 배경 생성
  geom_point()+ # 산점도 추가
  xlim(3,6)+ # x축 범위 지정
  ylim(10,30) # y축 범위 지정(지정범위 외 값이 있으면 경고메세지 뜸)


# mpg데이터를 이용한 도시연비와 고속도로연비간의 관계를 나타내는 산점도 그래프 만들기
ggplot(data=mpg,aes(x=cty,y=hwy))+
  geom_point()

# midwest데이터를 이용한 전체인구(50만명이하)와 아시안인구(1만명이하)의 관계를 나타내는 산점도 그래프 만들기
ggplot(data = midwest,aes(x=poptotal,y=popasian))+
  geom_point()+
  xlim(0,500000)+
  ylim(0,10000)




library(dplyr)

# 평균 막대그래프 만들기
df_mpg<-mpg %>%  
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy)) # 평균표를 먼저 만들어야함
df_mpg
ggplot(data = df_mpg, aes(x=drv,y=mean_hwy))+geom_col()
ggplot(data = df_mpg, aes(x=reorder(drv,-mean_hwy),y=mean_hwy))+geom_col() # x축 크기순 정렬(고속도로연비 내림차순으로)

# 빈도 막대그래프 만들기
ggplot(data = mpg,aes(x=drv))+geom_bar() # 원본자료를 그대로 사용-> 어쩐 자료를 이용하느냐에 따라 결과값이 달라질 수 있다.
ggplot(data = mpg,aes(x=hwy))+geom_bar()


# suv 차종의 평균 도시연비가 가장 높은 회사 5곳을 막대그래프로 표현(연비 높은 순으로 정렬)
suvctyaveg<-mpg %>% 
  filter(class=="suv") %>% 
  group_by(manufacturer) %>% 
  summarise(ctyaveg=mean(cty)) %>% 
  arrange(desc(ctyaveg)) %>% 
  head(5)
suvctyaveg
ggplot(data=suvctyaveg,aes(x=manufacturer,y=ctyaveg))+geom_col()


# 어떤 자동차 종류가 가장 많은지 표현한 막대그래프
ggplot(data = mpg,aes(x=class)) + geom_bar()
table(mpg$class)




#시계열 그래프
ggplot(data = economics,aes(x=date,y=unemploy)) + geom_line() #시간에 따른 실업자 수 변화
ggplot(data = economics,aes(x=date,y=psavert)) + geom_line() #시간에 따른 개인저축률의 변화



#상자그림 만들기-집단간 분포 차이 표현
ggplot(data = mpg,aes(x=drv,y=hwy))+geom_boxplot()



#치트시트 [Help -> Cheatsheet -> Data Visualzation with ggplot2]
ggplot(data = economics,aes(x=date,y=unemploy)) + geom_blank()
ggplot(data = economics,aes(x=date,y=unemploy)) + expand_limits()

ggplot(data = seals,aes(x=long,y=lat)) + geom_curve(aes(xend=long+1,yend=lat+1),curvature=1)
ggplot(data = economics,aes(x=date,y=unemploy)) + geom_path(lineend = "butt",linejoin = "round",linemitre = 1)
ggplot(data = economics,aes(x=date,y=unemploy)) + geom_polygon(aes(alpha = 50))

ggplot(data = seals,aes(x=long,y=lat)) + geom_rect(aes(xmin = long, ymin = lat, xmax = long + 1, ymax = lat + 1))

ggplot(data = economics,aes(x=date,y=unemploy)) +  geom_ribbon(aes(ymin = unemploy - 900, ymax = unemploy + 900))

ggplot(data = seals,aes(x=long,y=lat)) + geom_abline(aes(intercept = 0, slope = 1))
ggplot(data = seals,aes(x=long,y=lat)) + geom_hline(aes(yintercept = lat))
ggplot(data = seals,aes(x=long,y=lat)) + geom_vline(aes(xintercept = long))
ggplot(data = seals,aes(x=long,y=lat)) + geom_segment(aes(yend = lat + 1, xend = long + 1))
ggplot(data = seals,aes(x=long,y=lat)) + geom_spoke(aes(angle = 1:1155, radius = 1))



c <- ggplot(mpg, aes(hwy))
c
c + geom_area(stat = "bin")
c + geom_density(kernel = "gaussian")
c + geom_dotplot()
c + geom_freqpoly()
c + geom_histogram(binwidth = 5)
c2 <- ggplot(mpg)
c2
c2 + geom_qq(aes(sample = hwy))

# ggplot2으로 만든 다양한 그래프와 코드들 https://r-graph-gallery.com/
# 확장 패키지들 https://exts.ggplot2.tidyverse.org/


# mpg데이터를 이용해 compact,subcompact,suv 세종의 차량 도시연비를 상자그림으로 비교
comsubsuvcty <- mpg %>%
  filter(class==c("compact","subcompact","suv"))
ggplot(data=comsubsuvcty,aes(x=class,y=cty))+geom_boxplot()



# 의존 패키지를 같이 설치하는 방법->패키지를 설치했는데도 안된다면 해보기
install.packages("ggplot",dependencies = T) 

