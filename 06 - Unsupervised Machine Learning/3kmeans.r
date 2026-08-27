# uncomment following lines and execute if packages are not installed yet
 install.packages("cluster")    
 install.packages("factoextra")

# load required libraries
library(cluster)
library(factoextra)

# read in data file from working directory
df<- read.csv("nestegg_r.csv")
#View(df)

# standardize each variable (mean =0, standard deviation = 1)
dfsc <- as.data.frame(scale(df))
# View(dfsc)

# Use silhouette to assess various values of k
fviz_nbclust(dfsc, kmeans, method="silhouette")

# Use elbow method on within-cluster variance
fviz_nbclust(dfsc, kmeans, method="wss")

# set random number seed for reproducibility
set.seed(42)

# execute k-means clustering with k = 3 and 1000 random restarts
k3 <- kmeans(dfsc, centers = 3, nstart = 1000)

# display information on the 3-means clustering
k3

# analysis of clusters in original units
# appending each observation's cluster assignment to original data
df_k3 <- cbind(df, clusterID = k3$cluster)

# scatter plot
plot(df_k3$Age,df_k3$Income, col=factor(df_k3$clusterID), xlab="Age", ylab="Income")

# cluster 1 averages
mean(df_k3$Age[df_k3$clusterID==1])
mean(df_k3$Income[df_k3$clusterID==1])

# cluster 2 averages 
mean(df_k3$Age[df_k3$clusterID==2])
mean(df_k3$Income[df_k3$clusterID==2])

# cluster 3 averages
mean(df_k3$Age[df_k3$clusterID==3])
mean(df_k3$Income[df_k3$clusterID==3])



