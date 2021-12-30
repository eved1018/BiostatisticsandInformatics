df <- read.csv("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Module6/Module 6 - NHANES subset.csv")

ls(df)
# Stages
df$CKD3_new <- ifelse(df$eGFR < 60,1,0 )

# 
df$MALE <- ifelse(df$gender ==1,1,0)
df$SCr_elevated_new <- NA
df$SCr_elevated_new[df$MALE ==1] <- ifelse(df$creatinine[df$MALE ==1] > 1.2,1,0 )
df$SCr_elevated_new[df$MALE ==0] <- ifelse(df$creatinine[df$MALE ==0] > 1.1,1,0 )
#2 contigencey table  2x2 
df <- df[which(!is.na(df$SCr_elevated_new)),]
TP<-length(df$SCr_elevated_new[df$SCr_elevated_new==1 & df$CKD3_new == 1])
FP<-length(df$SCr_elevated_new[df$SCr_elevated_new==1 & df$CKD3_new == 0])
TN<-length(df$SCr_elevated_new[df$SCr_elevated_new==0 & df$CKD3_new == 0])
FN<-length(df$SCr_elevated_new[df$SCr_elevated_new==0 & df$CKD3_new == 1])

df$SCr_elevated_factor<-factor(df$SCr_elevated,labels=c("SCr elevated","SCr not elevated"),levels=1:0)
df$CKD_progressed<-factor(df$CKD3,labels=c("CKD3 or more","no CKD to CKD 2"),levels=1:0)
table1 <- table(df$SCr_elevated_factor,df$CKD_progressed)
Sensitivity<-table1[1,1] / (table1[2,1]+table1[1,1] )
Specificity<-table1[2,2] / (table1[2,2]+table1[1,2] )
PPV<-table1[1,1] / (table1[1,2]+table1[1,1] )
NPV<-table1[2,2] / (table1[2,2]+table1[2,1] )
Sensitivity
Specificity
PPV
NPV
#ROC CURVE 
library(pROC)
roc1 <- roc(df$CKD_progressed,df$creatinine,plot=TRUE,grid=TRUE,print.auc=TRUE,ci=TRUE, show.thres=TRUE)
ls(roc1)
roc1$auc
roc1$ci
roc1$sensitivities
roc1$specificities


