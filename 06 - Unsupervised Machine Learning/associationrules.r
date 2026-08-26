# uncomment following lines and execute if packages are not installed yet
# install.packages("arules")    
# install.packages("arulesViz") 
# install.packages("plyr")

# load required libraries
library(arules)
library(arulesViz)
library(plyr)

# package 'tm' conflicts with 'arules' package, so detach 'tm' package if necessary
if(sessionInfo()['basePkgs']=="tm" | sessionInfo()['otherPkgs']=="tm"){
  detach(package:tm, unload=TRUE)
}

# read in data file from working directory
df <- read.csv("hyvee_stacked_r.csv")

# create an object of the transactions class
# split function divides data in the Product column into groups defined by Customer
# and as function puts the data into list of transactions type
trans <- as(split(df[,"Product"], df[,"Customer"]), "transactions")

# generate the association rules using the apriori algorithm with specified parameters
# minimum support = 0.4, minimum confidence = 0.5, minimum rule length = 2
basket_rules <- apriori(trans, parameter = list(sup = 0.4, conf = 0.5, minlen = 2))

# view the association rules sorted by lift
inspect(sort(basket_rules, by = "lift"))

# visualization of association rules
# size of node corresponds to support, color of node corresponds to lift
plot(basket_rules, method="graph")

