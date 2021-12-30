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
# Multi t.test 
ttest_group_results <- data.frame()
ttest_var_results <- data.frame()
ttest_group_results_2 <-data.frame()

t_test_1 <-function(df_hyp,group,cont_var){ #<  is there a difference in hours slept btw binary groups
  
  formula <- as.formula(paste(cont_var,"~",group))
  ttest <- t.test(formula, data=df_hyp)
  LL_CI<-ttest$conf.int[1] # <- lower level for confidence interval 
  UL_CI<-ttest$conf.int[2] #<- upper level for CI 
  diff_in_mean<-ttest$estimate[1]-ttest$estimate[2]
  pval <- ttest$p.value #<- p-value 
  alt_null <- ifelse(pval <= 0.05,"reject null","maintain null" )
  diff <- paste(round(diff_in_mean,1)," (",round(LL_CI,1)," to ",round(UL_CI,1),")",sep="")
  #print(paste(var, diff, pval,alt_null))
  new_row <- data.frame( diff = diff, pval = pval, alt_null = alt_null)
  return(new_row)
}
t_test_2 <- function (df_hyp,var,group){ #is there a difference in var btw sleeptrouble and no sleeptrouble 
  formula <- as.formula(paste(var,"~",group))
  ttest <- t.test(formula, data=df_hyp)
  diff_age_all<-ttest$estimate[1]-ttest$estimate[2]  #<- in difference in ttest 
  LL_CI_age_all<-ttest$conf.int[1] # <- lower level for confidence interval 
  UL_CI_age_all<-ttest$conf.int[2] #<- upper level for CI 
  pval <- ttest$p.value #<- p-value 
  alt_null <- ifelse(pval <= 0.05,"reject null","maintain null" )
  diff <- paste(round(diff_age_all,1)," (",round(LL_CI_age_all,1)," to ",round(UL_CI_age_all,1),")",sep="")
  #print(paste(var, diff, pval,alt_null))
  new_row <- data.frame( diff = diff, pval = pval, alt_null = alt_null)
  return(new_row)
  
}

t_test_3 <- function(df_hyp,group,cont_var){ 
  formula <- as.formula(paste(cont_var,"~",group))
  fit <- lm(formula, data=df_hyp)
  result <- anova(fit)
  print(group)
  print("linear model")
  print(summary(result))
  anova_test <- aov(formula,data = df_hyp)
  print("ANOVA")
  print(summary(anova_test))
  print("TukeyHSD")
  print(TukeyHSD(anova_test))
 
  #new_row <- data.frame( diff = diff, pval = pval, alt_null = alt_null)
  #return(fit)
}


# TEST 1) used for comparing different binary groups and one continues var. 
groups <- c("Gender","healthy","SleepTrouble")
for (group in groups){
  cont_var <- "SleepHrsNight"
  new_row <- t_test_1(df,group,cont_var)
  ttest_group_results <- rbind(ttest_group_results,new_row)
}
ttest_group_results<- cbind(groups, ttest_group_results)

# TEST 2) used for comparing many cont. var. against one binry group 

vars <- c("BMI","PhysActiveDays","SleepHrsNight")
for (var in vars){
  group <- "SleepTrouble"
  new_row <- t_test_2(df,var,group)
  ttest_var_results <- rbind(ttest_var_results,new_row)
}

ttest_var_results<- cbind(vars, ttest_var_results)

# TEST 3) used for comparing many non-binary groups to a cont. var.
groups_2<- c("HealthGen","BMI_qtiles_factor","Sleep_qtiles_factor","Weight_factor","Race1")
for (group in groups_2){
  cont_var <- "SleepHrsNight"
  t_test_3(df,group,cont_var)
  #new_row <- t_test_3(df,group)
  #ttest_group_results_2 <- rbind(ttest_group_results_2,new_row)
}
#ttest_group_results_2<- cbind(groups_2, ttest_group_results_2)

#exposure is sleep trouble and our outcome is poor health (BMI)



