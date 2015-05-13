install.packages(c('psych','corrplot','ggplot2','reshape','car','lme4'))


#########################
### Dealing with Data ###
#########################

ffdat <- tempfile()
cat(file=ffdat, "1234.56", "987.654", "12345.6", sep="\n")
read.fwf(ffdat, width=c(1,2,4))

### Example only
# mydat <- read.table("C:/myfile.dat", header=TRUE) 
# mydata[sample(1:200,5),sample(1:100,5)]


######################################
### Data Manipulation & Management ###
######################################

### Vectors ###
x <- rnorm(10)

x2 <- x > 10
x2
sum(x2); x2*2

as.character(x2)

as.factor(x2)

x <- rep(c(1:3,5))
x2 <- factor(x, levels=1:3, labels=c("a","b","c"), ordered=T)

### Lists ###

xlist = list(1:3,4:6)
xlist
names(xlist) = c("A","B")
xlist[["A"]]
xlist$A
xlist$A[2]
# lapply(x,sum) Not shown
sapply(x, sum)

### Matrices and Arrays ###

x = matrix(rnorm(100, mean=1:10), ncol=10, byrow=T)  # the mean argument is added to to more easily discern the columns
x
x[c(1,5:8),-c(1,3,5)]

x = array(rnorm(100), dim=c(2,25,2))
x
apply(iris3,c(2,3),mean, trim=.2)

data.frame(x)

###################################
### Initial Examination of Data ###
###################################

hs1 <- read.table("http://www.ats.ucla.edu/stat/data/hs1.csv",header=T, sep=",")
head(hs1)
str(hs1)
summary(hs1)

#the describe function is much better however
library(psych)
describe(hs1)

describe.by(hs1[,7:11], group=hs1$gender)
describe.by(hs1[,7:11], group=hs1$gender, mat=T) #different view
describe.by(hs1$science, group=list(hs1$gender,hs1$prgtype))

# change from numeric to factor
hs1[,c(1,3:6)] <- lapply(hs1[,c(1,3:6)], as.factor)

#change the labels
levels(hs1$gender) = c("male","female")
levels(hs1$race) = c("Hispanic","Asian","Black","White","Other")
levels(hs1$ses) = c("Low","Med","High")
levels(hs1$schtyp) = c("Public","Private")
levels(hs1$prgtype) = c("Academic","General","Vocational")

#Alternate demo to give a sense of how one can use R
vars <- c("gender","race","ses","schtyp","prgtype")
labs <- list(gender=c("male","female"),
             race=c("Hispanic","Asian","Black","White","Other"),
             ses=c("Low","Med","High"),
             schtyp=c("Public","Private"),
             prgtype=c("Academic","General","Vocational"))
for (i in 1:5){
  hs1[,vars[i]] = factor(hs1[,vars[i]],labels=labs[[i]])
}
# use sapply alternative
hs1[,vars] = sapply(vars, function(i) factor(hs1[,i],labels=labs[[i]]), simplify=F)

str(hs1)
summary(hs1)

cor(hs1[,7:11], use="complete")
cormat <- cor(hs1[,7:11], use="complete")
round(cormat,2)

library(corrplot)
corrplot(cormat)

############################
### Graphical Techniques ###
############################

par(mfrow=c(3,2)) #set panels for the graph
for (i in 7:11){
  hist(hs1[,i], main=colnames(hs1)[i],
       xlab="",col="lemonchiffon")
}
par(mfrow=c(1,1)) #reset


library(ggplot2); library(reshape2)
graphdat = melt(hs1[,7:11])
head(graphdat)
ggplot(aes(x=value), data=graphdat) +
  geom_histogram() +
  facet_wrap(~variable, scales="free")


library(car)
scatterplot(hs1$math, hs1$science)
scatterplotMatrix(hs1[,7:11], pch=19,
                  cex=.5,col=c("green","red","grey80"))
coplot(math ~ read | as.factor(race)*as.factor(gender),
       data=hs1)

library(ggplot2); library(reshape2)
#visualize the data itself
ggstructure(hs1[,7:11], scale = "var")
ggfluctuation(xtabs(~ race + gender, hs1))
ggmissing(hs1)

#melt the data
hs2 <- melt(hs1, id.vars=c("id", "gender","race","ses","schtyp","prgtype"),
            measure.vars=c("read","write","science","math","socst"),
            variable.name="Test")
head(hs2)

# create base
g <- ggplot(data=hs2, aes(x=Test,y=value, color=race))

# mean race values
g + stat_summary(fun.y = "mean", geom="point")

#facet by gender
g + stat_summary(fun.y = "mean", geom="point", size=4) +
  facet_grid(.~gender)

#add another facet
g + stat_summary(fun.y = "mean", geom="point",data=hs2, size=4) +
  facet_grid(gender~ses)

#####################
##### Analysis ######
#####################


### t.test ###

t.test(read~gender,hs1)

apply(hs1[,7:11], 2, mean, na.rm=T)
colMeans(hs1[,7:11], na.rm=T)

myt <- function(y) {
  t.test(y~gender, data=hs1)
}
apply(hs1[,7:11],2, myt)

### OLS Regression Example ###

library(foreign)
regdata <- read.dta("http://www.ats.ucla.edu/stat/stata/webbooks/reg/elemapi2.dta")

mod1 <- lm(api00 ~ meals + ell + emer, data=regdata)
mod1
summary(mod1)

mod1$coef
coef(mod1)
mod1$fitted.values
fitted(mod1)

library(nlme)
modlist2 <- lmList(api00 ~ growth + yr_rnd + avg_ed + full +
  ell + emer|mealcat, data=regdata, na.action=na.omit)
plot(coef(modlist2),nrow=2)

par(mfrow = c(2,2))
plot(mod1, ask=F)
par(mfrow = c(1,1))

influencePlot(mod1)


mod1a <- lm(api00 ~ meals + ell , data=regdata)
# (.) is interpreted as ’what is already there’
add1(mod1a, ~ . + emer, , test="Chisq")


#x and y = T save the model and response data frames respectively
mod1 <- lm(api00 ~ meals + ell + emer, data=regdata, x=T, y=T)
basepred <- predict(mod1)
head(cbind(basepred, fitted(mod1))) #same

#obtain 25th and 75th percentile values of the predictor variables
lowervals <- apply(mod1$x, 2, quantile, .25)
lowervals2 <- data.frame(t(lowervals)) #t transposes
uppervals <- apply(mod1$x, 2, quantile, .75)
uppervals2 <- data.frame(t(uppervals))

#-1 removes the intercept column
predlow <- predict(mod1, newdata=lowervals2[-1])
predhigh <- predict(mod1, newdata=uppervals2[-1])
c(predlow, predhigh)  

glmdata <- read.dta("http://www.stata-press.com/data/r12/fish.dta")
pois_out <- glm(count~child + camper + persons, data=glmdata, family=poisson)
summary(pois_out)
exp(pois_out$coef) #exponentiated coefficients


library(lme4)
data(sleepstudy)
lmList(Reaction ~ 1|Subject, sleepstudy) #subject means
xyplot(Reaction ~ Days|Subject, sleepstudy, lty=1) #Reaction time over days for each subject
lme_mod_1 <- lmer(Reaction ~ 1 + (1|Subject), sleepstudy) #random effect for subject (random intercepts)
lme_mod_1
summary(lme_mod_1) #note how just printing the lmer model object provides the ’summary’ functionality
lme_mod_2 <- lmer(Reaction ~ Days + (1+Days|Subject), sleepstudy) # ’growth model’
lme_mod_2

#rest not run
