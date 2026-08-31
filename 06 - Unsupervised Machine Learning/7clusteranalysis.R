
# install.packages("cluster")
# install.packages("factoextra")
library(cluster)
library(factoextra)

set.seed(42)
customer_df <- data.frame(
  CustomerID = 1:60,
  Age = c(round(rnorm(20, mean = 25, sd = 4)),   # younger, lower-income cluster
          round(rnorm(20, mean = 45, sd = 5)),   # mid-age, high-income cluster
          round(rnorm(20, mean = 60, sd = 6))),  # older, moderate-spending cluster
  AnnualIncome = c(round(rnorm(20, mean = 35000, sd = 5000)),
                   round(rnorm(20, mean = 90000, sd = 10000)),
                   round(rnorm(20, mean = 55000, sd = 8000))),
  SpendingScore = c(round(rnorm(20, mean = 75, sd = 8)),
                     round(rnorm(20, mean = 70, sd = 10)),
                     round(rnorm(20, mean = 35, sd = 8)))
)

# --- Step 1: standardize the variables ---
# Age, Income, and SpendingScore are on very different scales; without
# scaling, Income (in the tens of thousands) would dominate the distance
# calculation and Age/SpendingScore would barely matter
features <- customer_df[, c("Age", "AnnualIncome", "SpendingScore")]
features_scaled <- as.data.frame(scale(features))

# --- Step 2: decide how many clusters to use ---
# neither hierarchical.r nor kmeans.r in this folder addresses this -
# both simply assume k = 3. These two diagnostic plots are the standard
# way to choose k instead of guessing:

# elbow method: look for where adding another cluster stops reducing
# within-cluster variation by much (the "elbow" in the bend of the curve)
fviz_nbclust(features_scaled, kmeans, method = "wss") +
  labs(title = "Elbow Method for Choosing k")

# silhouette method: higher average silhouette width = better-separated
# clusters; the peak suggests the best k
fviz_nbclust(features_scaled, kmeans, method = "silhouette") +
  labs(title = "Silhouette Method for Choosing k")

# --- Step 3: run k-means with the chosen k ---
set.seed(42)
k3 <- kmeans(features_scaled, centers = 3, nstart = 25)
customer_df$Segment <- factor(k3$cluster)

# --- chart: cluster plot with convex hulls around each segment -
# fviz_cluster() is a purpose-built, nicer alternative to a plain
# plot(x, y, col = cluster) scatter plot for this specific task ---
fviz_cluster(k3, data = features_scaled,
             geom = "point", ellipse.type = "convex",
             main = "Customer Segments (k-means, k = 3)")

# --- Step 4: profile each segment in BUSINESS terms ---
# a cluster ID alone ("Segment 2") means nothing to a business
# stakeholder - the average characteristics of each segment do
segment_profile <- aggregate(cbind(Age, AnnualIncome, SpendingScore) ~ Segment,
                              data = customer_df, FUN = mean)
print(segment_profile)

# --- chart: segment profiles side by side, one panel per variable, so
# it's easy to see what distinguishes each segment at a glance ---
par(mfrow = c(1, 3))
barplot(segment_profile$Age, names.arg = segment_profile$Segment,
        col = "steelblue", main = "Avg. Age by Segment", xlab = "Segment")
barplot(segment_profile$AnnualIncome, names.arg = segment_profile$Segment,
        col = "forestgreen", main = "Avg. Income by Segment", xlab = "Segment")
barplot(segment_profile$SpendingScore, names.arg = segment_profile$Segment,
        col = "darkorange", main = "Avg. Spending Score by Segment", xlab = "Segment")
par(mfrow = c(1, 1))  # reset layout

# with profiles like these, a marketing team could label the segments
# something like: "Young high spenders," "Affluent moderate spenders,"
# and "Older value-conscious customers" - and target each differently
