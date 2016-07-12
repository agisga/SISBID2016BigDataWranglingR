install.packages("rvest")
library(rvest)

recount_url = "http://bowtie-bio.sourceforge.net/recount/"
htmlfile = read_html(recount_url)
nds = html_nodes(htmlfile, xpath='//*[@id="recounttab"]/table')
dat = html_table(nds)
dat = as.data.frame(dat)
head(dat)

#-------------------------------------------------------
# Web scraping lab (https://github.com/SISBID/Module1/blob/gh-pages/labs/web-api-lab.Rmd)
#-------------------------------------------------------

# (6)
lab.url = "https://raw.githubusercontent.com/SISBID/Module1/gh-pages/labs/bioc-software.html"
htmlfile = read_html(lab.url)
nds = html_nodes(htmlfile, xpath='//*[@id="biocViews_package_table"]')
dat = html_table(nds)

# (7)
class(dat)
dat = as.data.frame(dat)
dim(dat)
head(dat)

install.packages(c("wordcloud","tm", "RColorBrewer"))
library(wordcloud)
library(RColorBrewer)
text = paste(dat[,3], collapse=" ")
pal <- brewer.pal(6,"Dark2")
pal <- pal[-(1)]
wordcloud(text, max.words=50, colors=pal)
