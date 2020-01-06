#This is a comment. 
install.packages("ggplot2")
install.packages("plotly")
install.packages("dplyr")
install.packages("reshape2")

mystat<-function(x){
  return (c(max(x), min(x), sum(x), mean(x)))
}
mystat(c(90,80,95,75))

library(ggplot2)
x <-c("a", "b", "c", "b", "a", "e")
qplot(x)

#반복문: repeat
test_repeat <- function(to = 9){ #define default value to the parameter
  num <- 1
  
  repeat{
    # no conditional statement: code runs at least once.
    print(num)
    
    if(num >= to){
      break
    }
    num <- num + 1
  }
}

test_repeat(5)
test_repeat(to=7)
test_repeat()


test_while <- function(to = 9){
  num <- 1
  
  while(num <= to){
    print(num)
    
    num <- num + 1
  }
}

test_while(5)
test_while(to=7)
test_while()



test_for <- function(){
  nums = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
  
  for(num in nums){
    print(num)
  }
}

test_for()


#연습문제
#구구단 출력

test_gugu <- function(){
  for(num in 2:9){
    for(i in 1:9) {
      print(paste(num,'x', i, '=', num*i))
    }
    print('-------------------')
  }
}

test_gugu()


seq(from = 1, to = 10, by = 3)
seq(from =1, to =10)
seq(1, 10)
rep(1:3, 3)
rep(c(1,3,5), 2)
seq(from = 1, to =10, length.out = 6)

