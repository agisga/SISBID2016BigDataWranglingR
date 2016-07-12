# dplyr stuff from the lecture

library(dplyr)

set.seed(2016) # reproducbility
df = data.frame(x = c(1, 2, 4, 10, 10),
                x2 = rpois(5, 10),
                y = rnorm(5),
                z = rpois(5, 6)
                )

rename(df, X = x2)
select(df, x, x2)
select(df, starts_with("x"))
filter(df, x > 5 | x == 2)
filter(df, x > 2, y < 0)
filter(df, x > 2 & y < 0)
select(filter(df, x > 2 & y < 0), y, z)
df %>% filter(x > 2 & y < 0) %>% select(y, z)
mutate(df, newcol = 5:1)
df <- mutate(df, newcol = x + 2)
select(df, -one_of("newcol", "y"))
arrange(df, x)
arrange(df, x, y)
arrange(df, desc(x))
transmute(df, newcol2 = x*3, x, y)
