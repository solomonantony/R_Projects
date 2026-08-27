# Amazon S3 is the standard cloud storage service at larger companies,
# often where raw data lands before it's loaded into a database or
# warehouse. AWS has a genuine free tier (5GB storage for 12 months),
# but does require an AWS account (with a credit card on file, even
# though you won't be charged within free-tier limits).
# Setup: create an AWS account, then generate an access key at
# IAM > Security credentials.

# install.packages("aws.s3")
library(aws.s3)

# credentials are set as environment variables rather than typed into
# the script directly - this keeps secret keys out of code you might
# share or commit to version control
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = "YOUR_ACCESS_KEY_HERE",
  "AWS_SECRET_ACCESS_KEY" = "YOUR_SECRET_KEY_HERE",
  "AWS_DEFAULT_REGION" = "us-east-1"
)

# get_bucket() lists the objects (files) inside an S3 bucket
bucket_contents <- get_bucket(bucket = "your-bucket-name")
print(bucket_contents)

# s3read_using() reads a file directly from S3 into R without manually
# downloading it first - here using read.csv as the reader function
sales_df <- s3read_using(
  FUN = read.csv,
  object = "sales_data.csv",
  bucket = "your-bucket-name"
)
str(sales_df)

# --- chart: same pattern as the other cloud-storage examples in this chapter ---
if ("Region" %in% names(sales_df) && "Revenue" %in% names(sales_df)) {
  region_totals <- aggregate(Revenue ~ Region, data = sales_df, sum)
  barplot(region_totals$Revenue, names.arg = region_totals$Region,
          col = "steelblue", main = "Revenue by Region (from S3 file)")
}

# s3write_using() sends a result back to S3, in reverse:
# s3write_using(region_totals, FUN = write.csv, object = "region_summary.csv",
#                bucket = "your-bucket-name")
