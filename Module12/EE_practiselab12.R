df_source <- read.csv("/Users/user/Desktop/School/2021/Spring2021/BTM-6000/Module12/Module 12 - Practice Lab - NHANES subset.csv")
df<- df_source[,2:6]
summary(df)

# 1) Test the data for an association between Age and SBP in
# 1A) The overall population
cor(df$SBP,df$age,method = c("pearson"))
cor(df$SBP,df$age,method = c("kendall"))
cor(df$SBP,df$age,method = c("spearman"))
fitall <- lm(df$SBP ~df$age)
fitall
summary(fitall)
#plot(fitall)
# 1B) males 
fit_male <- lm(SBP ~age,data = df[df$gender == 1,])
fit_male
summary(fit_male)
#plot(fit_male)

# 1C) females

fit_female <- lm(SBP ~age,data = df[df$gender == 2,])
fit_female
summary(fit_female)
#plot(fit_female)

# 2) Plot the regression function (and R2) for 

# 2A) the overall population (with males and females with different dots),
plot(SBP~age, data = df)
abline(fitall, lty = 2, col = "red")
text(x=25,y=210,labels=paste("R2=",round(summary(fitall)$adj.r.squared,2),sep=""))


# 2B) males 
plot(SBP~age,data=df[df$gender==1,])
abline(fit_male, lty = 2, col = "red")
text(x=25,y=210,labels=paste("R2=",round(summary(fit_male)$adj.r.squared,2),sep=""))

# 2C) females
plot(SBP~age, data = df[df$gender == 2,])
abline(fit_female, lty = 2, col = "red")
text(x=25,y=210,labels=paste("R2=",round(summary(fit_female)$adj.r.squared,2),sep=""))

# 3A) Is there an association between pulse pressure (SBP-DBP) and age?
# Does inclusion of SBP change the association between pulse pressure and age? 
# For Mean arterial blood pressure (1/3 SBP + 2/3 DBP)?
df$MAP <- (1/3 * df$SBP + 2/3 *df$DBP)
fit_MAP_all <- lm(MAP~age,data = df)
fit_MAP_all
summary(fit_MAP_all)

# 5) If there is an association between age and either of these parameters –
#is the association robust against inclusion of other parameters (i.e. eGFR, male gender)?
df$gender_factor <- factor(df$gender, levels = c(1,2), labels = c("male","female"))
fit_multi_all <- lm(MAP~age + gender_factor,data = df)
fit_multi_all
summary(fit_multi_all)


