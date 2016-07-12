# Installing googlesheets:

#install.packages("googlesheets")
library(googlesheets)
?gs_read

# Reading a google sheet:

sheets_url <- "https://docs.google.com/spreadsheets/d/103vUoftv2dLNZ_FcAz08b5ptIkWN4W2RaFn7VF39FJ8"
gsurl1 = gs_url(sheets_url)
gsurl1
dat = gs_read(gsurl1)
class(dat)
head(dat)

#---------------------------------------------------------------------------------
# lab (https://github.com/SISBID/Module1/blob/gh-pages/labs/google-sheets-lab.Rmd)
#---------------------------------------------------------------------------------

# (3)
?"cell-specification"

# (4)
dat.first2 <- gs_read(gsurl1, range = cell_cols(1:2))
head(dat.first2)

# (5)
nrow(dat.first2)

# (6)
names(dat)
x <- dat$`Years of R experience`
head(x)
as.numeric(x)
