# Import and export data

# csv, tsv (comma separated, tab separated)
# read.csv, read.table 함수로 임포트
# -> DataFrame으로 변환

thieves <- read.csv("thieves.txt",
                    fileEncoding="utf-8" )


# \t문자를 구분자로, header는 없음으로 설정
thieves <- read.csv("thieves.txt", 
                    fileEncoding="utf-8",
                    sep="\t",
                    header = FALSE)

# column에 이름 붙이기: names()
names(thieves) <- c("Name", "Height", "Weight")     # Vector


# 엑셀 파일 import
# 외부 패키지 필요
install.packages("readxl")

# 라이브러리 로드
library(readxl)

# wstudents.xlsx를 로드
wstudents <- read_excel("wstudents.xlsx",
                        col_names=TRUE,
                        sheet=1)
wstudents



# 연습
# 1. import class_scores.csv 
# 2. 데이터 확인
# 3. 데이터 정제: 2학년(grade==2) 데이터만 따로 분류
# 4. rdata 파일로 저장
class_scores <- read.csv("class_scores.csv",
                         header = TRUE)
# 데이터 구조 확인
str(class_scores)

# grade는 명목 변수로 변경
class_scores$grade <- as.factor(class_scores$grade)

# 2학년 데이터만 필터링
length(class_scores) # column 수
nrow(class_scores) # record 수

class_scores$grade == 2
class_scores.grade2 <- class_scores[class_scores$grade == 2,] #열 범위는 전체니까.

str(class_scores.grade2)

# class_scores.grade2 객체를 rdata 파일로 저장
save(class_scores.grade2, file="class_scores.grade2.rda")

# class_scores.grade2 객체 삭제
rm(class_scores.grade2)

# 객체 복원 테스트
load("class_scores.grade2.rda")

# csv로 저장
write.csv(class_scores.grade2, "class_scores.grade2.csv")

# 행번호 제외하고 저장하기
write.csv(class_scores.grade2, 
          "class_scores.grade2.csv",
          row.names = FALSE
)



# EDA: 탐색적 데이터 분석
# 가지고 있는 데이터를 살펴보면서
# 알아내지 못한 가치가 있는지 확인하는 작업

## 기본적인 작업
# 데이터의 전반적 구조 확인
# 데이터의 변수들
# 실제 데이터의 모습들

# 내장 데이터셋 mtcars
?mtcars
dim(mtcars)
str(mtcars)
# 데이터의 앞 부분 확인: head(기본 값은 6)
head(mtcars)
head(mtcars, n=10)
# 데이터의 뒷 부분 확인: head(기본 값은 6)
tail(mtcars)
tail(mtcars, n=10)

# 컬럼과 행의 이름 확인
colnames(mtcars)
rownames(mtcars)

# 요약 통계량 확인: summary
summary(mtcars)

# 특정 변수의 요약 통계량
summary(mtcars[c("mpg", "wt")])


# 중량(wt) 변수의 boxplot
boxplot(mtcars$wt)

wt.median <- median(mtcars$wt)
wt.quantile <- quantile(mtcars$wt)
wt.quantile
# boxplot의 통계치 추출
bp <- boxplot(mtcars$wt)$stat
bp
wt.1q <- bp[2]
wt.3q <- bp[4]

# IQR: 3사분위수 - 1사분의수 
wt.iqr <- wt.3q - wt.1q
wt.iqr
IQR(mtcars$wt)

wt.top_border <- wt.3q+wt.iqr*1.5
wt.top_border # 상단 극단치 경계
wt.bottom_border <- wt.1q-wt.iqr*1.5
wt.bottom_border


# Outlier 확인
wt.outliers <- mtcars$wt[mtcars$wt > wt.top_border] # 상단극단치

