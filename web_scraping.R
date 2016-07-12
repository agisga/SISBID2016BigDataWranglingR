install.packages("rvest")
library(rvest)

recount_url = "http://bowtie-bio.sourceforge.net/recount/"
htmlfile = read_html(recount_url)
nds = html_nodes(htmlfile, xpath='//*[@id="recounttab"]/table')
dat = html_table(nds)
dat = as.data.frame(dat)
head(dat)


