qplot(mpg$literperkm) #정리되지 않은 데이터로 표를 만들어 확인할 때 사용
ggplot() #잘 정제된 데이터로 표 만들 때 사용
#컬럼수에 다라서 사용할 수 있는 그래프의 종류가 다르다
#일반적인 그래프의 종류
# -히스토그램(hist)
# -막대그래프(barplot)
# -원형그래프(pie)
# -상자그래프(boxplot)
# -선그래프(lineplot)
# -3차원 그래프(scatterplot3d)
# -산점도 그래프(dotplot)
#컬럼수가 1개 : 히스토그램, 막대그래프(숫자형)/원형그래프, 막대그래프(범주형->월~금 같은 범주가 있는)
#컬럼수가 2개 : 선그래프, 상자그래프
#컬럼수가 3개 : 3차원 그래프

rm(list=ls())

#이산변수의 시각화
chart_data<-c(305,450,320,460,330,480,380,520)
names(chart_data)<-c("22.1","22.2",
                     "22.3","22.4",
                     "23.1","23.2",
                     "23.3","23.4")
str(chart_data)
barplot(chart_data, main = "최근 2년간의 판매 실적",
        col=rainbow(4),
        horiz = T,
        xlim =c(0,600),
        xlab ="판매량[단위:1000]",
        ylab = "22년 ,23년 분기별",
        legend.text = c("1분기","2분기","3분기","4분기") )

pie(chart_data,col = rainbow(8), edges = 8, density = 25 )
hist(chart_data)

