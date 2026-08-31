# getwd() shows the folder R is currently reading/writing files from
getwd()

# setwd() changes that folder


# if/else: run different code depending on a condition
sales <- 42000
if (sales > 40000) {
  print("Above target")
} else {
  print("Below target")
}

# for loop: repeat an action across a sequence of values
region_sales <- c(12000, 18500, 9000, 21000)
for (s in region_sales) {
  if (s > 15000) {
    print(paste(s, "exceeds the 15,000 threshold"))
  }
}
