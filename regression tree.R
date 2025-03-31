```{r the CART approach}
#setting seed for reproducibility
set.seed(1)

#applying the regression tree method to the data using a complexity parameter of 0.01
tree1 = rpart(formula = log_antibody~.,
              data = dat1,
              control = rpart.control(cp=0.01))

rpart.plot(tree1)

#applying cost complexity pruning to obtain a tree with the right size
printcp(tree1)
cpTable = tree1$cptable
plotcp(tree1)

#picking the cp that yields the minimum cross-validation error
minErr = which.min(cpTable[,4])
tree3 = rpart::prune(tree1, cp = cpTable[minErr,1])
rpart.plot(tree3)
plot(as.party(tree3))

#predictions on the test data set
head(predict(tree3, newdata=dat2))

#computing the RMSE on the test set
RMSE(predict(tree3, newdata=dat2),dat2$log_antibody)
```
The RMSE for the regression tree model is 0.5873775.