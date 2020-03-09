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

# MPG vs Vehicle Weight
plt <- ggplot(mecha,aes(x=mpg,y=vehicle.weight))
plt + geom_point() # looks unrelated
cor(mecha$mpg,mecha$vehicle.weight) # 0.091 none

# MPG vs Spoiler Angle
plt <- ggplot(mecha,aes(x=mpg,y=spoiler.angle))
plt + geom_point() # looks unrelated
cor(mecha$mpg,mecha$spoiler.angle) # -0.021 none

# MPG vs Ground Clearance
plt <- ggplot(mecha,aes(x=mpg,y=ground.clearance))
plt + geom_point() # looks very midly related
cor(mecha$mpg,mecha$ground.clearance) # 0.329 weak

# Plot linear model with all variables
model <- lm(mpg ~ vehicle.length,mecha) # create linear model
yvals <- model$coefficients['vehicle.length']*mecha$vehicle.length + model$coefficients['(Intercept)'] #determine y-axis values from linear model

plt <- ggplot(mecha,aes(x=vehicle.length,y=mpg)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") # plot scatter and linear model

# Multiple linear regression model with all variables
summary(lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance,data=mecha))
# When an intercept is statistically significant, it means there are other variables and factors that contribute to the variation in mpg that have not been included in our model. These variables may or may not be within our dataset and may still need to be collected or observed.
#r^2 0.703

# Multiple linear regression model with only correlated variables
summary(lm(mpg ~ vehicle.length + ground.clearance,mecha))
#r^2 0.674

####################################################
# Suspension Coil Summary

# Load csv file and rename headers to be legit
coil <- read.csv("Suspension_Coil.csv", check.names=TRUE)

# Sort by lot
coilLot1 <- subset(coil, Manufacturing_Lot=='Lot1')
coilLot2 <- subset(coil, Manufacturing_Lot=='Lot2')
coilLot3 <- subset(coil, Manufacturing_Lot=='Lot3')

# Show table summary of all data
summary(coil) # Mean: 1499 Median: 1500
summary(coilLot1) # Mean: 1500 Median: 1500
summary(coilLot2) # Mean: 1500 Median: 1500
summary(coilLot3) # Mean: 1496 Median: 1498

# Show standard deviation for PSI
sd(coil$PSI) # 7.892PSI
sd(coilLot1$PSI) # 0.990
sd(coilLot2$PSI) # 2.733
sd(coilLot3$PSI) # 13.049

# Show variance for PSI
var(coil$PSI) # 62.293PSI
var(coilLot1$PSI) # 0.980
var(coilLot2$PSI) # 7.469
var(coilLot3$PSI) # 170.286

#######################################################
# Suspension Coil T-Test

# Plot to verify if skewy
plt <- ggplot(coil,aes(x=PSI))
plt + geom_density() # minor left skewed

# Transform data to reduce skew
coil$sqrPSI <- (coil$PSI-1369)^2
plt <- ggplot(coil,aes(x=sqrPSI))
plt + geom_density() # left skewed

#install.packages("moments") then quantify skewness
library(moments)
skewness(coil$PSI) # -1.706
skewness(coil$sqrPSI) # 0.006

# Verify normal distribution
shapiro.test(coil$PSI) # p-value: 2.2e-16
shapiro.test(coil$sqrPSI) # p-value: 2.2e-16
t.test((coil$sqrPSI),mu=(1500-1369)^2) #p-value: 0.1113 u:16904 -> accept H0 & H1 as statistically similar
t.test((coil$PSI),mu=1500) #p-value: 0.060 u:1498.78

