library(doBy)
library(dplyr)
library(NHANES)
library(pwr)
library(nhanesA)
library(ggplot2)
# load Nhanes data set
df <- NHANES
#remove kids for now 
#df <- filter(df, Age>=18)
#summary(df)
# startify healthy into binary group 

df<-df[which(!is.na(df$HealthGen)),]
df$healthy <- ifelse(df$HealthGen == "Poor",0,1)
#squartile bmi and hours slept 
df$BMI_qtiles <-  ntile(df$BMI,4)
df$BMI_qtiles_factor <- factor(df$BMI_qtiles,levels=c(1:4),labels = c("T1","T2","T3","T4"))
df$Sleep_qtiles <-  ntile(df$SleepHrsNight,4)
df$Sleep_qtiles_factor <- factor(df$Sleep_qtiles,levels=c(1:4),labels = c("T1","T2","T3","T4"))
df$Weight_factor <- ifelse(df$BMI >= 30,"Obese",
                           ifelse(df$BMI >= 26,"Overweight"
                                  ,ifelse(df$BMI <= 18,"Underweight","Healthy")))


# vars <- c("BMI","SleepHrsNight","DaysPhysHlthBad")
# for (i in vars){
#   hist(df[[i]])
#   abline(v=mean(df[[i]]),col="red",cex=1.2,lty=4)
#   abline(v=mean(df[[i]])+sd(df[[i]]),col="blue",cex=1.2,lty=4)
#   abline(v=mean(df[[i]])-sd(df[[i]]),col="blue",cex=1.2,lty=4)
# }
# 
# vars <- c("HealthGen","Weight_factor","Race1", "Gender","Sleep_qtiles_factor")
# for (i in vars){
#   barplot(prop.table(table(df[[i]])),cex.names=0.75, main = i, ylab = "Frequency")
#   
# }


avrg_tbl <- data.frame()
vars <- c("BMI","SleepHrsNight","DaysPhysHlthBad", "DaysMentHlthBad")
for (var in vars){ # compared variable to health and sleeptrouble
  df<-df[which(!is.na(df[[var]])),]
  # total_avrg <- paste(round(mean(df[[var]],1)),"+/-",round(sd(df[[var]]),1),sep="")
  # avrg_healthy <- paste(round(mean(df[[var]][df$healthy ==1]),1),"+/-",round(sd(df[[var]][df$healthy ==1]),1),sep="")
  # avrg_unhealthy <- paste(round(mean(df[[var]][df$healthy ==0]),1),"+/-",round(sd(df[[var]][df$healthy ==0]),1),sep="")
  # avrg_sleepwell <- paste(round(mean(df[[var]][df$SleepTrouble =="No"]),1),"+/-",round(sd(df[[var]][df$SleepTrouble =="No"]),1),sep="")
  # avrg_sleeptrouble <- paste(round(mean(df[[var]][df$SleepTrouble =="Yes"]),1),"+/-",round(sd(df[[var]][df$SleepTrouble =="Yes"]),1),sep="")
  # new_row <- data.frame(total_avrg = total_avrg, avrg_healthy = avrg_healthy , avrg_unhealthy = avrg_unhealthy, avrg_sleepwell = avrg_sleepwell, avrg_sleeptrouble = avrg_sleeptrouble)
  # avrg_tbl <- rbind(avrg_tbl,new_row)

  
}
#avrg_tbl<- cbind(vars, avrg_tbl)


tsize <- nrow(df)
h_size <- length(which(df$healthy == 1))
u_size <- length(which(df$healthy == 0))
s_size <-length(which(df$SleepTrouble == "Yes"))
trouble_size <-length(which(df$SleepTrouble == "No"))
print(tsize)
print(h_size)
print(u_size)
print(s_size)
print(trouble_size)


 
