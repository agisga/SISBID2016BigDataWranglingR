#----------------------------
# dplyr stuff from the day 1
#----------------------------

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

#----------------------------
# dplyr stuff from day 3
#----------------------------

library(gapminder)

str(gapminder)
gtbl = gapminder
class(gtbl)

glimpse(gtbl) # better head
filter(gtbl, lifeExp < 29) # filter by rows
filter(gtbl, country == "Rwanda")
select(gtbl,country,pop,continent) # subset by columns
arrange(gtbl,pop) # reorder by population ascending
arrange(gtbl,desc(pop)) # reorder by population descending
arrange(gtbl, year, lifeExp)
mutate(gtbl, newVar = (lifeExp / gdpPercap)) # generate tbl with newVar
mutate(gtbl, newVar = (lifeExp / gdpPercap), newVar2 = newVar^2)
gtbl = mutate(gtbl, newVar = (lifeExp / gdpPercap)) # reassign the output
select(gtbl,lifeExp,gdpPercap,newVar)
distinct(gtbl) # find distinct rows for repetitive data
summarize(gtbl, aveLife = mean(lifeExp)) # apply function to data frame

# sampling
sample_n(gtbl,3)
sample_frac(gtbl,0.5) # sample 50% of rows

#--- piping
gtbl %>% head
gtbl %>% head(3)
gtbl %>% glimpse
# base R:
set.seed(123)
gtbl1 = gtbl[gtbl$continent=="Asia" & gtbl$lifeExp < 65,]
gtbl2 = gtbl1[sample(1:dim(gtbl1)[1], size=10),]
gtbl2
# vs. dplyr with pipes:
set.seed(123)
gtbl2 = gtbl %>% filter(continent == "Asia") %>%
        filter(lifeExp < 65) %>% sample_n(10)

#--- group_by: devide data frame into multiple data frames
asdf = sample_n(gtbl, 10)
qwer = group_by(asdf, continent)
str(qwer)
attributes(qwer)
# what is the average life expectancy by continent?
gtbl %>% group_by(continent) %>% summarize(aveLife = mean(lifeExp))

#--- join
superheroes <- c("name, alignment, gender, publisher",
                 "Magneto, bad, male, Marvel",
                 "Storm, good, female, Marvel",
                 "Mystique, bad, female, Marvel",
                 "Batman, good, male, DC",
                 "Joker, bad, male, DC",
                 "Catwoman, bad, female, DC",
                 "Hellboy, good, male, Dark Horse Comics")
superheroes <- read.csv(text = superheroes, strip.white = TRUE, as.is=TRUE)

publishers <- c("publisher, yr_founded",
                "       DC, 1934",
                "   Marvel, 1939",
                "    Image, 1992")
publishers <- read.csv(text = publishers, strip.white = TRUE, as.is=TRUE)
inner_join(superheroes, publishers)
left_join(superheroes, publishers)
full_join(superheroes, publishers)
