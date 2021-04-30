##  question 1

baseline <- c(140, 138, 150, 148, 135)
week2 <- c(132, 135, 151, 146, 130)

t.test(baseline, week2, paired = TRUE)

# Paired t-test
# 
# data:  baseline and week2
# t = 2.2616, df = 4, p-value = 0.08652
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#         -0.7739122  7.5739122
# sample estimates:
#         mean of the differences 
# 3.4 

#answer chosen - 0.087 - correct

# Question 2
# A sample of 9 men yielded a sample average brain volume of 1,100cc and a 
# standard deviation of 30cc. 
# What is the complete set of values of mu_0 that a test of  H_0: mu = mu_0 
# would fail to reject the null hypothesis in a two sided 5% Students t-test?

# higher and lower values of the distribution, between 0.025 and 0.975 

n <- 9
mu <- 1100
sd <- 30

mu + c(-1, 1) * qt(.975, n-1) * sd / sqrt(n)
#[1] 1076.94 1123.06

#answer chosen - 1077 to 1123 - correct

# Question 3
# Researchers conducted a blind taste test of Coke versus Pepsi. 
# Each of four people was asked which of two blinded drinks given 
# in random order that they preferred. 
# The data was such that 3 of the 4 people chose Coke. 
# Assuming that this sample is representative, report a P-value for 
# a test of the hypothesis that Coke is preferred to Pepsi using a 
# one sided exact test.

binom.test(3, 4, p = 0.5, alternative = "greater")

# Exact binomial test
# 
# data:  3 and 4
# number of successes = 3, number of trials = 4, p-value = 0.625
# alternative hypothesis: true probability of success is not equal to 0.5
# 95 percent confidence interval:
#         0.1941204 0.9936905
# sample estimates:
#         probability of success 
# 0.75 

# 1 option chosen - 0.62 - wrong
# binom.test(3, 4, p = 0.5, alternative = "greater")
# Exact binomial test
# 
# data:  3 and 4
# number of successes = 3, number of trials = 4, p-value = 0.3125
# alternative hypothesis: true probability of success is greater than 0.5
# 95 percent confidence interval:
#         0.2486046 1.0000000
# sample estimates:
#         probability of success 
# 0.75 

# 2 option chosen - 0.31

# Question 4
# Infection rates at a hospital above 1 infection per 100 person days at risk 
# are believed to be too high and are used as a benchmark. A hospital that had
# previously been above the benchmark recently had 10 infections over the last 
# 1,787 person days at risk. About what is the one sided P-value for the 
# relevant test of whether the hospital is *below* the standard?

ppois(10, .01 * 1787)
# [1] 0.03237153

# options chosen - 0.03 - correct

# Question 5
# Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill 
# and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline 
# and again after having received the treatment or placebo for four weeks. The 
# average difference from follow-up to the baseline (followup - baseline) 
# was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. 
# The corresponding standard deviations of the differences was 1.5 kg/m2 for
# the treatment group and 1.8 kg/m2 for the placebo group. Does the change in 
# BMI appear to differ between the treated and placebo groups?  
# Assuming normality of the underlying data and a common population variance, 
# give a pvalue for a two sided t test.

#t.test(-3, 1, paired = TRUE)

#still no idea, 

#1 option chosen - less than 0.01 but larger than 0.05 - wrong
#2 option chosen - less than 0.05 but larger then 0.01

# Question 6
# Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 
# 1,123 cc. Would you reject in a two sided 5% hypothesis test of 
# H_0 : mu > 1,078

# option chosen: no you wouldn't reject - correct 
# because the mean is contained in the confidence interval

# Question 7
# Researchers would like to conduct a study of  100 100 healthy adults to 
# detect a four year mean brain volume loss of   .01~mm^3 .01 mm^3. Assume 
# that the standard  deviation of four year volume loss in this population is 
# .04~mm^3 .04 mm^3. About what would be the power of the study for a 5% 
# one sided test versus a null hypothesis of no volume loss?

power.t.test(n = 100, sd = 0.04, delta = 0.01,
             type = "one.sample", alt = "one.sided")$power
#[1] 0.7989855

#option chosen - 0.80 - right answer wrong method

# should have been
pnorm(1.645 * 0.004, mean = 0.01, sd = 0.004, lower.tail = FALSE)


# Question 8
# Researchers would like to conduct a study of  n n healthy adults to detect 
# a four year mean brain volume loss of   .01~mm^3 .01 mm^3. Assume that the 
# standard deviation of four year volume loss in this population is  .04~mm^3
# .04 mm^3. About what would be the value of  n n needed for 90% power of 
# type one error rate of  5\% 5% one sided test versus a null hypothesis of 
# no volume loss?
        
power.t.test(sd = 0.04, delta = 0.01, power = 0.9, 
             type = "one.sample", alt = "one.sided")$n
#[1] 138.3856

# option chosen = 140 - correct

# Question 9
# As you increase the type one error rate,  alpha α, what happens to power?

# answer chosen: larger - correct




