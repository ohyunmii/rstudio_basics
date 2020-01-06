# 산점도 그래프(Scatter Plot)
# 두 개의 변수간의 상관 관계를 표시하는 그래프
mtcars

# plot 기본 문법: plot(x, y, main, xlab, ylab, xlim, ylim, axes)

# wt(중량), mpg(연비)의 상관관계 확인
# 상관계수
cor(mtcars$wt, mtcars$mpg) # -0.8677 역상관관계
plot(mtcars$wt, mtcars$mpg,
     xlab = "차량중량", # x-axis label
     ylab = "연비", # y-axis label
     main = "Weight vs MPG" # title of the graph
)
?plot


# 산점도 매트릭스(Scatterplot Matrix)
# 여러 개의 변수간의 상관 관계를 일목요연하게 보여주는 그래프
# 기본 문법: pairs(formula, data)
pairs(data=mtcars, #데이터
      ~wt + mpg + disp + cyl, # 쌍으로 사용될 일련의 변수
      main = "산점도 매트릭스"
)


# 파이 차트 (Pie Chart)
# 전체 데이터 중에서 해당 데이터의 기여도를 비율로 표시
# 기본 문법: pie(x, labels, radius, main, col, clockwise)
midterm <- data.frame(grade=c("A", "B", "C", "D"),
                      cnt = c(3, 12, 11, 2))
pie(midterm$cnt, #데이터
    labels = midterm$grade, # 조각에 표시할 라벨
    radius = 1,
    # col = c("blue", "green", "yellow", "red") #색상팔레트
    #col = c("#0000FF", "#00FF00", "#FFFF00", "#FF0000") #16진수 색상
    col = rainbow(4)
)

# 응용: 파이차트 라벨을 비율로 대체
# 응용2: 범례(legend) 넣기
midterm$percent <- round(100* midterm$cnt/sum(midterm$cnt), 1)
midterm$percent

pie(midterm$cnt, #데이터
    labels = midterm$percent,
    col = rainbow(4),
    main = "Midterm Scores",
)

legend("topright", # 범례의 위치 표시
       legend=midterm$grade, # 범례의 사용될 라벨 
       fill=rainbow(4))

# Bar Chart
# 기본문법: barplot(H, xlab, ylab, main, names.arg, col)
rev <- sample(1:20, 6, rep=T) # rep = T -> 복원 추출 허용
barplot(rev)
names <- c("MAR", "APR", "MAY", "JUN", "JUL", "AUG")
barplot(rev, # data
        names.arg = names, # 항목 표시 이름
        xlab = "월", # x-axis label
        ylab = "Revenue", # y-axis label
        main = "Revenue Chart", 
        col = "blue", # bar fill color
        border = "red" # bar outline color
)


# barplot에 matrix를 전달하면 stacked bar chart 생성
rev2 <- sample(1:20, 18, rep=T)
rev2 <- matrix(rev2, byrow=T, nrow =3)

barplot(rev2,
        names.arg = names,
        xlab = "Month",
        ylab = "Revenue",
        col= c("yellow", "orange", "red"),
        main = "Stacked Bar Chart"
)

# legend
legend("topright", #범례 위치
       c("Part A", "Part B", "Part C"), #각 요소의 이름
       fill=c("yellow", "orange", "red")
)



# Histogram
# 기본문법: hist(v, main, xlab, xlim, ylim, breaks, col, border)
# 특정 구간에 데이터의 출연 빈도, 혹은 밀도를 표현
wstudents$height
hist(wstudents$height, # dataset
     main = "Height of WStudents", # chart title
     xlab = "Height", # x-axis label
     col = "yellow", # color palette
     border = "gray"
)

# Probability Density Graph
hist(wstudents$height,
     main="Height of WStudents",
     xlab= "Height",
     col = "yellow",
     border = "gray",
     freq = F)

stat <- hist(wstudents$height, freq = F)
stat
stat$density # 각 구간의 밀도
stat$breaks # histogram을 생성하기 위한 각 구간

# 확률밀도 그래프의 경우
# 바 너비(구간의 크기)와 density(밀도)를 곱한 합은
# 1이 된다.
sum(stat$density *5)


# Line graph
# 기본 문법: plot(v, type, col, main, xlab, ylab)
v <- sample(10:20, 5, rep=T)
plot(v, type="p") #점그래프
plot(v, type="l") #선그래프
plot(v, type="o") #점과 선그래프


plot(v, 
     type = "o",
     main = "Line Graph",
     xlab = "HORZ Label",
     ylab = "VERT Label",
     col = "blue",
     ylim=c(11, 20)
)     
# plot을 그린 후 lines 함수, points 함수를 이용하면
# 기존 그래프 위에 추가 그래프를 덧그릴 수 있다
v2 <- sample(10:20, 5, rep=5)
lines(v2, 
      type="o",
      col= "red",
)
