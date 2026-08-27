# read in data file from working directory
df<- read.csv("maillard_r.csv")

# create data frame consisting only of quantitative variables
dfnum <- df[,2:10]

# execute PCA on standardized data (mean = 0, standard deviation = 1)
maillard_pca <- prcomp(dfnum, center = TRUE, scale = TRUE)

# display variable weights of the principal components
maillard_pca

# display proportion of variance explained for the principal components
summary(maillard_pca)

#create new plot window to make scatter plot more visible
dev.new()

# scatter plot of first two principal components
plot(maillard_pca$x[,1],maillard_pca$x[,2], xlab="PC1", ylab="PC2")

# adding country names as labels
text(maillard_pca$x[,1],maillard_pca$x[,2], df$Country, pos=1)


