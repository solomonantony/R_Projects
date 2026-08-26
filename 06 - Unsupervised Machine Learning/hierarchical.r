# uncomment following lines and execute if packages are not installed yet
# install.packages("cluster")   
# install.packages("factoextra")

# load required libraries
library(cluster)
library(factoextra)

# read in data file from working directory
df <- read.csv("nestegg_r.csv")
# View(df)

# standardize each variable (mean =0, standard deviation = 1)
dfsc <- as.data.frame(scale(df))
# View(df)

# compute the distance between each pair of observations
# using dist function (which has various distance methods)
# here we use Euclidean distance
euclid_dist <- dist(dfsc, method="euclidean")

# execute agglomerative hierarchical clustering
# via hclust function (which supports various linkage methods)
# here we use group average linkage
cl_euclid_avg <- hclust(euclid_dist, method = "average")

# plot the associated dendrogram
plot(cl_euclid_avg)

# use cutree function to obtain cluster assignment
# corresponding to k = 3 clusters
cl_euclid_avg_3 <- cutree(cl_euclid_avg, k=3)

# visualize the cluster contents on the dendrogram
rect.hclust(cl_euclid_avg, k=3, border = 2:4)

# appending each observation's cluster assignment to original data frame
df_cl3 <- cbind(df, clusterID = cl_euclid_avg_3)

# scatter plot
plot(df_cl3$Age,df_cl3$Income, col=factor(df_cl3$clusterID), xlab="Age", ylab="Income")

# cluster 1 averages
mean(df_cl3$Age[df_cl3$clusterID==1])
mean(df_cl3$Income[df_cl3$clusterID==1])

# cluster 2 averages
mean(df_cl3$Age[df_cl3$clusterID==2])
mean(df_cl3$Income[df_cl3$clusterID==2])

# cluster 3 averages
mean(df_cl3$Age[df_cl3$clusterID==3])
mean(df_cl3$Income[df_cl3$clusterID==3])


