# Import dependencies
library(tidyverse)

#######################################################
# MPG Regression

# Load csv file and rename headers to be legit
mecha <- read.csv("MechaCar_mpg.csv", check.names=TRUE)

# Plot relationships to mpg for visual AND determine correlation coef
plt <- ggplot(mecha,aes(x=mpg,y=vehicle.length))
plt + geom_point() # looks midly related
cor(mecha$mpg,mecha$vehicle.length) # 0.609 moderate

plt <- ggplot(mecha,aes(x=mpg,y=vehicle.weight))
plt + geom_point() # looks unrelated
cor(mecha$mpg,mecha$vehicle.weight) # 0.091 none

plt <- ggplot(mecha,aes(x=mpg,y=spoiler.angle))
plt + geom_point() # looks unrelated
cor(mecha$mpg,mecha$spoiler.angle) # -0.021 none

plt <- ggplot(mecha,aes(x=mpg,y=ground.clearance))
plt + geom_point() # looks very midly related
cor(mecha$mpg,mecha$ground.clearance) # 0.329 weak

# Get linear model equation for mpg and vehicle length
lm(mpg ~ vehicle.length,mecha) # y=4.673x-25.062

# Get p and r squared values
summary(lm(mpg ~ vehicle.length,mecha))
# r^2 0.3715
# p 2.632e-06 -- H0 can be rejected

# Test for normality
shapiro.test(mecha$vehicle.length) # p-value 0.008

# H0: MPG is not correlated with vehicle length
# H1: MPG is correlated with vehicle length

# Plot linear model
model <- lm(mpg ~ vehicle.length,mecha) # create linear model
yvals <- model$coefficients['vehicle.length']*mecha$vehicle.length + model$coefficients['(Intercept)'] #determine y-axis values from linear model

plt <- ggplot(mecha,aes(x=vehicle.length,y=mpg)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") # plot scatter and linear model

# Multiple linear regression model
summary(lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance,data=mecha))
# When an intercept is statistically significant, it means there are other variables and factors that contribute to the variation in mpg that have not been included in our model. These variables may or may not be within our dataset and may still need to be collected or observed.
#r^2 0.703

# Get p and r squared values
summary(lm(mpg ~ vehicle.length + ground.clearance,mecha))
#r^2 0.674

####################################################
# Suspension Coil Summary

# Load csv file and rename headers to be legit
coil <- read.csv("Suspension_Coil.csv", check.names=TRUE)

# Show table summary
summary(coil)
# Show standard deviation for PSI
sd(coil$PSI) # 7.892PSI
# Show variance for PSI
var(coil$PSI) #62.293PSI

#######################################################
# Suspension Coil T-Test

# Plot to verify if skewy
plt <- ggplot(coil,aes(x=PSI))
plt + geom_density() # minor left skewed

# Transform data to reduce skew
coil$sqrPSI <- (coil$PSI-1369)^2
plt <- ggplot(coil,aes(x=sqrPSI))
plt + geom_density() # left skewed

coil$sqrPSI <- 1/((coil$PSI)^(0.5))
coil$sqrPSI <- (log10(coil$PSI))

# Verify normal distribution
t.test((coil$sqrPSI),mu=(1500-1369)^2) #p-value: 0.1113 u:16904 -> accept H0 & H1 as statistically similar
t.test((coil$PSI),mu=1500) #p-value: 0.060 u:1498.78

#install.packages("moments")
library(moments)
skewness(coil$PSI) # -1.706
shapiro.test(coil$PSI)
skewness(coil$sqrPSI) # 0.006
shapiro.test(coil$sqrPSI)
######################################################
# Design Your Own Study


