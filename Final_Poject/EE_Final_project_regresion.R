# Evan Edelstein 
# Final Project 
# regresion analyses 

library(doBy)
library(dplyr)
library(NHANES)
library(aod)
library(ROCR)
library(zeallot)

# load Nhanes data set
df <- NHANES
summary(df)
# remove NaN's 
df<-df[which(!is.na(df$SleepTrouble)), ]
df<-df[which(!is.na(df$SleepHrsNight)),]
df<-df[which(!is.na(df$HealthGen)),]
#df<-df[which(!is.na(df$Poverty)),]
# if patient self-reports Heath is poor then "healthy" is 0 else it is 1
df$healthy <- ifelse(df$HealthGen == "Poor",0,1)

#split data into healthy and non healthy members 
df_healthy <- subset(df,healthy %in% c(1))
df_not_healthy <- subset(df,healthy %in% c(0))
# 
logit_results <- data.frame()
#general logit function 
Logit_test <- function(df,IV_param,DV_param) {
  #summary, anova and ROC-AUC 
  #train and test sets 
  cutoff <- nrow(df)
  cut2 <- round(cutoff/2)
  cutplus <- cut2+1
  
  train <- df[1:cut2,]
  test <- df[cutplus:cutoff,]
  
  test_rows <- nrow(test)
  train_rows <- nrow(train)
  
  train <- head(train,nrow(test))
  
  #logit model 
  
  formula <- as.formula(paste(IV_param,"~."))
  model <- glm(formula,family=binomial(link='logit'),data=train)
  summary(model)
  anova(model, test="Chisq")
  DV <-  df[,DV_param]
  IV <-  df[,IV_param]
  p <- predict(model, DV, type="response")
  pr <- prediction(p, IV)
  prf <- performance(pr, measure = "tpr", x.measure = "fpr")
  auc <- performance(pr, measure = "auc")
  auc <- auc@y.values[[1]]
  
  return(auc)
  
}

df_logit_sleep <- df[,c("SleepTrouble", "SleepHrsNight", "healthy")]
#factor sleep trouble -> if have sleep trouble then 1 else 0
df_logit_sleep$SleepTrouble <- ifelse(df$SleepTrouble == "Yes",1,0)
#DV_param<- c("SleepTrouble","SleepHrsNight")
#IV_param <- c("healthy")
#Logit_test(df_logit_sleep,IV_param,DV_param)



df <-df[which(!is.na(df$Poverty)), ]
df <-df[which(!is.na(df$HHIncomeMid)), ]
df_logit_stress <- df[,c("Poverty","HHIncomeMid","healthy")]
#DV_param<- c("Poverty","HHIncomeMid")
#IV_param <- c("healthy")
#Logit_test(df_logit_stress,IV_param,DV_param)



df <-df[which(!is.na(df$HardDrugs)), ]
df <-df[which(!is.na(df$RegularMarij)), ]
df_logit_drugs<- df[,c("HardDrugs","RegularMarij","healthy")]
df_logit_drugs$HardDrugs <- ifelse(df_logit_drugs$HardDrugs == "Yes",1,0)
df_logit_drugs$RegularMarij <- ifelse(df_logit_drugs$RegularMarij == "Yes",1,0)
#DV_param<- c("HardDrugs","RegularMarij")
#IV_param <- c("healthy")
#Logit_test(df_logit_drugs,IV_param,DV_param)

sleep<- list(df_logit_sleep,c("healthy"),c("SleepTrouble","SleepHrsNight"))
stress <- list(df_logit_stress, c("healthy"),c("Poverty","HHIncomeMid"))
drugs <- list(df_logit_drugs,c("healthy"),c("HardDrugs","RegularMarij"))
runs <- list(sleep,stress,drugs)

for (i in runs){
  df_logit<- i[[1]]
  IV <- i[[2]]
  DV <- i[[3]]
  
  auc <-Logit_test(df_logit,IV,DV)
  new_row <- data.frame(IV= IV, DV = paste(DV[1],"and",DV[2],sep = " "), AUC = auc)
  logit_results <- rbind(logit_results,new_row)
}
columnnames <- c("sleep","stress","drugs")
logit_results<- cbind(columnnames, logit_results)

