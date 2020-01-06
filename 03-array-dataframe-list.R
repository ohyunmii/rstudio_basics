# Array 2차원 이상 n차원의 데이터
# 데이터는 Vector 생성으로, 차원정보는 dim 옵션으로 부여한다
# array 객체의 차원 정보는 dim 함수로 확인

vec <- 1:18
vec

arr <- array(vec, dim=c(3,3,2)) # 3행 3열 2 매트릭스의 배열
arr


# 배열 요소의 이름 dimnames
dimnames(arr) <- list(
  paste0("R", 1:3),
  paste0("C", 1:3),
  paste0("M", 1:2)
)

dim(arr)




#############################

# Data frame
name <- c("홍길동", "전우치", "임꺽정", "장길산")
height <- c(175.8, 170.2, 186.7, 188.3)
weight <- c(73.2, 66.3, 88.2, 90)
thieves <- data.frame(name, height, weight)
thieves

colMeans(thieves[c("height", "weight")])
colMeans(thieves[c(2,3)])

# rbind - 세로로 합치기 (새 데이터를 행으로 연결)
thieve.new <- data.frame(name="일지매", height=170.5, weight=63)
rbind(thieves, thieve.new)

# cbind - 가로로 합치기 (새 데이터를 열로 연결)
bt <-data.frame(bloodtype = c("A", "B", "O", "AB"))
cbind(thieves, bt)

# Merge - 가로로 합치기(특성 column을 기준으로 매칭하여 합치는 경우)
# by 인자로 주어진 column의 이름을 기준으로 두 데이터 셋을 병합
footsizes <- data.frame(name=c("전우치", "장길산", "임꺽정", "홍길동"), footsize=c(260, 300, 290, 275))
cbind(thieves, footsizes)
merge(thieves, footsizes, by="name")

# $기호를 사용하여 새로운 column 추가
thieves$bmi <- thieves$weight / (thieves$height/ 100)^2
thieves




##############################
# List
lst <- list(name="홍길동",
            physical = c(175.8, 73.2),
            scores = data.frame(intellect = 95, health = 90))
lst['name']
