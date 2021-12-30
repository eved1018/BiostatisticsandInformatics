# DAYS_FROM_FDD – running time counter, NLR – neutrophil lymphocyte ratio, 
#SBP and DBP – systolic and diastolic blood pressure.
library(dplyr) 
library(survival)
df <- read.csv("/Users/user/Desktop/School/2021/Spring2021/BTM-6000/Module11/Module 11 - Practice Lab.csv")


# 1) Aggregate all parameters to a patient-level (using the aggregate function) 
#by building means of all continuous parameters
df_agg<-data.frame("Patient_ID"=unique(df$PATIENT_ID))

params <- c("SBP","DBP","NLR","ALBUMIN")
for (p in params){
  temp1<-aggregate(df[[p]][which(!is.na(df[p]))],by=list(df$PATIENT_ID[which(!is.na(df[p]))]),FUN=mean)
  colnames(temp1)<-c("Patient_ID",paste(p,"_mean",sep = ""))
  df_agg<-left_join(df_agg,temp1,"Patient_ID")
  
}
temp1<-aggregate(df$MALE,by=list(df$PATIENT_ID),FUN=unique)
colnames(temp1)<-c("Patient_ID","MALE")
df_agg<-left_join(df_agg,temp1,"Patient_ID")

temp1<-aggregate(df$DIED,by=list(df$PATIENT_ID),FUN=max)
colnames(temp1)<-c("Patient_ID","DIED")
df_agg<-left_join(df_agg,temp1,"Patient_ID")

temp1<- aggregate(df$DAYS_FROM_FDD,by=list(df$PATIENT_ID),FUN=max)
colnames(temp1)<-c("Patient_ID","EXP_DAYS")
df_agg<-left_join(df_agg,temp1,"Patient_ID")

# 2) Count the number of deaths.
deaths <- sum(df_agg$DIED)
deaths
survival <- 1 -sum(df_agg$DIED)/length(df_agg$DIED)
survival
rate_per_thousand <- sum(df_agg$DIED)/sum(df_agg$EXP_DAYS) * 1000
rate_per_thousand
# 3) Was there a difference between SBP and DBP between those that died and those that didn’t?

Q3a <- t.test(df_agg$SBP_mean ~ df_agg$DIED)
Q3a
# no difference is found between the two 
Q3b <- t.test(df_agg$DBP_mean ~ df_agg$DIED)
Q3b
# no difference is found between the two 

# 4) Did Albumin differ between men and women?
Q4 <- t.test(df_agg$ALBUMIN_mean ~ df_agg$MALE)

# 5) Did NLR differ between the highest and the lowest tertile of SBP?
df_agg$SBP_tertile <-  ntile(df_agg$SBP_mean,3)

t.test(df_agg$NLR_mean[df_agg$SBP_tertile==1],df_agg$NLR_mean[df_agg$SBP_tertile==3])
