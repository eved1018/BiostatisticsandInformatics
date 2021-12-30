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
# remove NaN's 
# df<-df[which(!is.na(df$SleepTrouble)), ]
# df<-df[which(!is.na(df$SleepHrsNight)),]
df<-df[which(!is.na(df$HealthGen)),]

df$BMI_qtiles <-  ntile(df$BMI,4)
df$BMI_qtiles_factor <- factor(df$BMI_qtiles,levels=c(1:4),labels = c("T1","T2","T3","T4"))
df$Sleep_qtiles <-  ntile(df$SleepHrsNight,4)
df$Sleep_qtiles_factor <- factor(df$Sleep_qtiles,levels=c(1:4),labels = c("T1","T2","T3","T4"))
df$Weight_factor <- ifelse(df$BMI >= 30,"Obese",
                           ifelse(df$BMI >= 26,"Overweight"
                                  ,ifelse(df$BMI <= 18,"Underweight","Healthy")))

#effect on paramters on sleeptrouble
paramters <-c("Gender","Race1", "HealthGen","BMI_qtiles_factor","Weight_factor")

for (i in paramters){
  df_chi<-df[which(!is.na(df[[i]])),]
  #formula <- as.formula(paste("~",i,"+SleepTrouble"))
  formula <- as.formula(paste("~",i,"+Sleep_qtiles_factor"))
  xt <- xtabs(formula , data=df_chi)
  ptable_total<- prop.table(xt)*100
  ptable_1<- prop.table(xt, margin=1)*100
  ptable_2<- prop.table(xt, margin=2)*100
  ctbl <- table(df[[i]],df$SleepTrouble)
  print(ptable_total)
  print(ptable_1)
  print(ptable_2)
  
  print(chisq.test(ctbl))
}



