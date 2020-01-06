# Vector의 작성
# c, seq, rep 함수로 작성
# 벡터의 인덱스는 1부터 시작
# 단일 벡터는 단일 자료형만 저장
# 결측치는 NA로 표기

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, NA)

# 통계 함수
mean(v) # 결측치가 포함된 벡터의 연산은 NA
mean(v, na.rm=TRUE)


# seq 함수
seq(1, 10, 3) # 1부터 10까지 3간격으로 증가하는 수
seq(from=1, to=10, by=3)
seq(from=1, to=100, length.out = 12)

# rep 함수 (반복)
rep(1:3, 3) # 1~3까지의 수열을 3번 반복
rep(c(1,3,5), 2) #1,3,5 수열을 2번 반복
rep(c(1,3,5), each =3) #개별요소를 each 개만큼 반복


# 벡터의 요소에 이름 붙이기
scores <- c(80, 90, 85)

# 벡터 이름의 벡터 확인
names(scores) #null로 나옴
names(scores) <- c("Eng", "Math", "Science")
# 요소에 이름 부여하면 이름으로 요소에 접근할 수 있다
scores['Eng']
# 벡터 관련 함수들
x <- seq(1, 12, by=2)
x
y <- seq(2, 7)
y

cor(x,y) #상관계수 : 1.0에 가까울수록 정상관계
rev(x)
cor(rev(x), y) #x의 역수열과 y는 역상관관계
sd(x)
var(x)


summary(x) # x의 통계량 요약
summary(x)['3rd Qu.']

quantile(x)


v <- seq(1, 10)
v
v+2
v*2
v1 <- c(1,3,5)
v2 <- c(2,3,6)
v1+v2 # 벡터의 같은 위치에 있는 요소들이 개별연산
v1==v2 # 벡터의 비교(논리) 연산 -> 논리벡터

# 논리 벡터를 이용하여 필요한 요소를 추출
v1[c(TRUE, FALSE, TRUE)]
# Fancy Indexing
# 벡터로 인덱싱할 때, TRUE, FALSE 논리값으로 요소 추출

c <-seq(1, 10)
# 벡터 c에서 짝수만 추출하고자 할 경우
c%%2==0
c[c%%2==0]


# Matrix
# 모양이 다른 Vector로 취급
# 벡터의 특징과 벡터 함수가 그대로 사용

# c, seq, rep 등으로 벡터를 만들어 데이터로 사용
m1 <- matrix(1:10, ncol=2) # 1~10 벡터, 칼럼수 2
m2 <- matrix(1:10, nrow=2, byrow = TRUE) #1~10 벡터, 행수2, 행기준 채움
m3 <- matrix(1:10, ncol=3, byrow = T) #갯수가 맞지 않을 경우, 순환 규칙에 따라 채움

# 행렬의 인덱스 Row 인덱스, Col 인덱스
m1[3,2] == 8

# 행렬의 행과 열에 이름 붙이기
# colnames(), rownames()
m1 
colnames(m1) <- paste0("C", 1:2)
rownames(m1) <- paste0("R", 1:5)
nrow(m1)
ncol(m1)
dim(m1)



# slicing 
# Row Index Range, Col Index range
m1[2:3, 1:2]
m1[2:3, ] #범위를 생략하면 해당 범위 전체임
m1[,1]
m1[,]


# 행렬의 연산
x <- matrix(1:4, ncol=2, byrow=FALSE)
x
y <- matrix(1:4, ncol=2, byrow = TRUE)
y
x+y

# 선형대수 행렬 곱의 연산자는 %*%로 사용
x%*%y

# 매트릭스의 주요 함수들
x
sum(x) # 벡터의 함수: 데이터 전체를 대상으로 함
mean(x) # 벡터의 함수

colSums(x) # 열의 합계 벡터
rowSums(s) # 행의 합계 벡터
colmeans(x) # 열의 평균 벡터
rowmeans(x) # 행의 평균 벡터

m1
dim(m1)

# 전치 행렬: 행 <->열
t(m1)

# cbind(열 기준으로 행렬을 연결), rbind(행 기준으로 행렬을 연결)
# 주의: 기준에 맞는 행, 열의 갯수가 일치해야 한다.
m1
m4 <- matrix(1:4, ncol=2)

# 행 기준으로 매트릭스 연결
rbind(m1, m4)
cbind(m1, m4) # 두행렬의 행수가 일치히애야 
cbind(t(m1), m4)


# apply
# 행렬에서 행기준, 혹은 열기준으로 계산 함수를 적용하고자 할 경우 사용
# MARGIN == 1 :행 기준
# MARGIN == 2 :열 기준

scores<- matrix(c(80, 90,70,65,75,90,80,70, 85), ncol=3)
scores
rownames<-paste0("R", 1:3)
colnames<- paste0("C", 1:3)

apply(scores, 1, median)
apply(scores, MARGIN = 2, FUN=median)
apply(scores,FUN=summary, MARGIN=1)


