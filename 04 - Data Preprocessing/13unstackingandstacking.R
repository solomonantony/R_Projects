#Chapter 3 unstacking and stacking

 

library(dplyr)
library(tidyr)


 
stackedtablehs3pa_df = read.csv("stackedtablehs3pa_r.csv")

str(stackedtablehs3pa_df)

unstackedtablehs3pa_df =spread(stackedtablehs3pa_df,Year,Three.Point.Attempts)

newstackedtablehs3pa_df = unstackedtablehs3pa_df %>% gather(Year, ThreePointAttempts, -Team)

write.csv(unstackedtablehs3pa_df, "unstacked.csv")