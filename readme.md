#MPG Regression
####Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?

Vehicle Length: Has a moderate positive correlation to MPG (R = 0.609)
Vehicle Weight: Has no correlation to MPG (R = 0.091)
Spoiler Angle: Has no correlation to MPG (R = -0.021)
Ground Clearance: Has a weak positive correlation to MPG (R = 0.0.329)

####Is the slope of the linear model considered to be zero? Why or why not?

I only used the variables with a weak to strong correlation to generate the linear model, Vehicle Length and Ground Clearance. The R-squared value is 0.674 which means the slope is positive. Including every variable would overfit the model, this is why I choose to model with only two variables.

If the R-squared value was zero, then the slope would be zero. There would also be no correlation between the variables.

If the R-squared value was negative, then the slope would be negative.

####Code Used:
summary(lm(mpg ~ vehicle.length + ground.clearance,mecha))

####Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?

We get an R-squared value of 0.674, this means that 67% of our predictions will be accurate. I would not consider this model to be good at predictions. However, it is better than a coin flip, so it may have some use.

Note that the intercept is statistically significant, this indicates we are missing variables that would make our model more accurate.

####Linear Model Summary:
Residuals:
    Min      1Q  Median      3Q     Max 
-17.493  -7.705   1.344   6.642  18.500 

Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)      -91.5573    13.9649  -6.556 3.86e-08
vehicle.length     6.0811     0.6732   9.033 7.68e-12 
ground.clearance   3.5669     0.5401   6.604 3.26e-08 

Residual standard error: 9.078 on 47 degrees of freedom
Multiple R-squared:  0.674,	Adjusted R-squared:  0.6601 
F-statistic: 48.59 on 2 and 47 DF,  p-value: 3.637e-12

#Suspension Coil Summary

####The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per inch. Does the current manufacturing data meet this design specification? Why or why not?

Overall it does, the variance of the dataset is 62.293PSI. But, the variance of lot 3 is 170.286PSI. Lot 3 is out of specification. Current mfg. data does not meet spec because lot 3 is out of spec, because the magnitude it is out of spec by, and because this is a safety concern.

code with results (commented)

#### Show table summary of all data
summary(coil) # Mean: 1499 Median: 1500
summary(coilLot1) # Mean: 1500 Median: 1500
summary(coilLot2) # Mean: 1500 Median: 1500
summary(coilLot3) # Mean: 1496 Median: 1498

#### Show standard deviation for PSI
sd(coil$PSI) # 7.892PSI
sd(coilLot1$PSI) # 0.990
sd(coilLot2$PSI) # 2.733
sd(coilLot3$PSI) # 13.049

#### Show variance for PSI
var(coil$PSI) # 62.293PSI
var(coilLot1$PSI) # 0.980
var(coilLot2$PSI) # 7.469
var(coilLot3$PSI) # 170.286

#Suspension Coil T-Test
####In the MechaCarWriteUp.txt text file, provide a small writeup of your interpretation and findings for the t-test results.

1)  Hypotheses
- H0:  The sample population is statistically similar to the population
- H1:  The sample population is not statistically similar to the population

2  Assumption: The sample data (Suspension_Coil.csv) was selected randomly from its population data.

3  Verify the sample size is reasonably large. We have 150 datapoints, which is enough.
Assumption: the sample distribution is similar to the population.

4  To verify the input data is numerical and continuous, I plotted the data and confirmed it looked like a normal distribution. The data looked left skewed.

5  Reduce Skew: I used this transform to reduce the skew (x-1369)^2

6  To verify the input data is normally distributed I ran a Shapiro-Wilk test on the data. The result was p-value = 2.2e-16, which means the data is normally distributed.

7  Assumption: The variance of the data is very similar to the population.

####Code:
t.test((x),mu=(population_mean*transform)
t.test((coil$sqrPSI),mu=(1500-1369)^2)

####Results:
The p-value is 0.1113, this means we accept the sample population as statistically similar to the population.

#Design Your Own Study
####Think critically about what metrics you would think would be of interest to a consumer.

I watched a car advertisement with the intent of gleaning information of what car buyers are looking for. My assumption is that car company marketers know what consumers want. Here's my list of what metrics I would collect data on:

Metric: Data Type, Statistical Test
Cost: continuous, Simple Linear Regression
Payment Options: nominal, ANOVA
Body Style: nominal, ANOVA
Color: nominal, ANOVA
Number of cup holders: ordinal, ANOVA
USB Charger #: ordinal, ANOVA
Sound System Quality: ordinal, ANOVA
Resale Value: continuous, Simple Linear Regression
Safety Ranking: ordinal, ANOVA
Horse Power: continuous, Simple Linear Regression
Transmission Type: nominal, ANOVA
Power Source: nominal, ANOVA
Mathew McConaughey in commercial?: dichotomous, One-Sample t-Test

The dependent variable would be Desirability, ranked 1-10 by a survey taker.

####ANOVA & Linear Regression Hypotheses
H0: The metric does not influence desirability
H1: The metric does influence desirability

####One-Sample t-Test Hypothesis
H0: The sample population is representative of the population
H1: The sample population is not representative of the population