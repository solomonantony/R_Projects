patient_names <- c("John Doe", "Jane Doe", 'Joe Crabs', 'Gina Squares')

temperatures <- c(98.1, 101, 99.5, 101.1)

vaccine_status <- c(TRUE, TRUE, FALSE, TRUE)
patients[2]
temperatures[1:3]

temperatures > 100

patient_names[temperatures > 100]

gender <- factor(c("Male", "Female", "Male", "Male"))
gender

patient_names[1]
patient1 <- list(full_name = patients[1], temperature = temperatures[1], gender=gender[1], vacccine = vaccine_status[1])
patient1
patient1[2]

patients_df = data.frame(patients, temperatures, vaccine_status, gender)
patients_df

patients_df$patients
patients_df[1:2] #first and second columns
patients_df[2,]
str(patients_df)

m = matrix(c(1,2,3,4), nrow=2)
m
n = matrix(c(5,6,7,8,9,10), ncol=3)
n

m[1,]
n[,2]

ls()


