# Data Preprocessing with dplyr

install.packages("dplyr")
library(dplyr)


# 데이터 준비
scores <- read.csv("class_scores.csv")
scores

str(scores)
summary(scores) # stat summary 

# head, tail 등을 이용해서 데이터 살펴보기

# filter: 조건에 맞는 행을 선택 - WHERE절과 비슷
# scores의 grade == 1인 레코드 선택 
scores[scores$grade ==1, ] # in R
filter(scores, grade == 1) # dplyr
head(filter(scores, grade ==1 )) # 타 함수와의 조합

# gender == F인 데이터 선택
scores[scores$gender == 'F',] # in R
filter(scores, gender == 'F') # dplyr

# 논리 값의 조합
# scores에서 grade == 1이고 class == 'B'인 데이터
filter(scores, grade==1 & class=='B') # 논리곱

# select: 특정 변수의 추출 - SQL의 SELECT
# Math, English, Writing 변수 추출
select(scores, Math, English, Writing)
# 특정 변수의 배제
select(scores, -gender, -Stu_ID) # omit gender and studentID
# 컬럼의 범위를 이용한 변수 추출:
select(scores, Math:Writing)

# filter와 select를 이용해서
# 성별이 F고 grade 가 3인 관측치 선택
# Stu_ID와 Math:Writing까지의 변수 선택
select(
  filter(scores, 
         gender=='F' & grade==3), 
  c(Stu_ID, Math:Writing)
)

# mutate: 파생변수 
# scores 데이터에 Total, Avg 파생 변수 추가
mutate(scores, 
       Total = Math+English+Science+Marketing+Writing, 
       Avg = (Math+English+Science+Marketing+Writing)/5)



# 연습문제
# scores 데이터프레임에서 grade==1, gender==F인 데이터를 추출하고
# 합계(Total)와 평균(Avg) 파생변수를 만들고
# Math, English, Science, Marketing, Writing 변수를 제외한 나머지 변수만 추출
# scores.refined변수에 담아보기

# Solution 1
temp.filtered <- filter(scores, grade==1 & gender=='F')
temp.mutated <- mutate(temp.filtered,
                       Total = Math + English + Science + Marketing + Writing, 
                       Avg = (Math + English + Science + Marketing + Writing) / 5
)
scores.refined <- select(temp.mutated, -c(Math:Writing))
scores.refined

# Solution 2
scores.refined <-
  select(
    mutate(
      mutate(
        filter(scores, grade == 1 & gender == 'F'), 
        Total = Math + English + Science + Marketing + Writing), 
      Avg = (Math + English + Science + Marketing + Writing) / 5),
    -c(Math:Writing)
  )
scores.refined


# Chain Operator
# 앞쪽의 출력을 뒤쪽 함수의 입력 값으로 전달
scores.refined <- scores %>%  #입력 데이터셋
  filter(grade == 1 & gender == 'F') %>%
  mutate(Total = Math + English + Science + Marketing + Writing) %>%
  mutate(Avg = Total/5) %>%
  select(-c(Math:Writing))
scores.refined

# Mutate 함수 내에서 ifelse를 이용한 변수 파생
scores.result <- scores.refined %>%
  mutate(Result = ifelse(Avg >= 90, 
                         "A",
                         ifelse(Avg >= 80, 
                                "B",
                                ifelse(Avg >= 70,
                                       "C",
                                       ifelse(Avg >= 60, 
                                              "D",
                                              "F")))))
scores.result
str(scores.result)

# scores.result$Result 변수는 순서형 변수가 될 수 있음
scores.result$Result <- ordered(scores.result$Result, 
                                levels = c("F", "D", "C", "B", "A"))
str(scores.result)
head(scores.result)

# scores.result에서 "C"이상 성적을 받은 학생을 
# 높은 성적 순으로 출력. (Sorting 필요 -> arrange 사용)
# 역순 정렬 desc()로 바꿈
scores.result %>%
  filter(Result >= "C") %>%
  arrange(desc(Avg))

# Summarise와 group_by
# scores 데이터 셋 Math 점수의 평균
scores %>% summarise(mean(Math))
scores %>% summarise(mean.math = mean(Math),
                     mean.english = mean(English),
                     mean.writing= mean(Writing))

# group_by: 특정 조건으로 데이터를 그룹화
scores.group <-scores %>%
  group_by(grade, class)

scores.group %>% head(10)

# 반별 총점 평균 구하기 연습
scores.group <- scores %>%
  group_by(grade, class) %>%
  mutate(Total = Math + English + Science + Marketing + Writing) %>%
  mutate(Avg = Total/5) %>%
  summarise(sum_total = sum(Total), mean_total = mean(Total)) %>%
  arrange(desc(mean_total))
scores.group %>% head(10)


# Missing Value, Outliers
# 결측치가 포함된 데이터를 산술연산하면 NA
library(ggplot2)
?mpg

str(mpg) # 구조 확인

# mpg의 hwy 변수를 상자 그림으로 확인
bp <- boxplot(mpg$hwy)
bp$stats # 상단극단치, 하단극단치경계, 중앙값 등을 보여줌

# mpg의 hwy 변수의 정상 범주는 12~37이다.
mileage <- mpg %>% select(cyl, cty, hwy)
mileage

# 극단치 확인
outliers <- mileage %>%
  filter(hwy < 12 | hwy > 37)
outliers

# 극단치를 결측치로 대체
mileage$hwy <- ifelse(mileage$hwy < 12 | mileage$hwy > 37,
                      NA,
                      mileage$hwy)
mileage$hwy # NA로 대체된 극단치값 확인

# mileage$hwy 평균 확인
mean(mileage$hwy, na.rm = TRUE) # 결측치 배제한 산술평균균

# 결측치가 많아도 통계 결과를 왜곡할 수 있다
# 대푯값으로 NA를 대체해 줘야 한다.
hwy.median <- median(mileage$hwy, na.rm=T)
hwy.median

# mileage$hwy 값이 na이면 중앙값으로 대체. 그렇지 않은경우엔 그대로 둠. 
mileage$hwy <- ifelse(is.na(mileage$hwy),
                      hwy.median,
                      mileage$hwy)

# 최종 연비의 평균
mean(mileage$hwy)


