library(rpart)
library(rpart.plot)
fit <- rpart(Price ~ Mileage + Type + Country, cu.summary)
prp(fit)
sampled.df <- cu.summary[sample(x = nrow(cu.summary), size = 117, replace = FALSE), ]
sampled.df
