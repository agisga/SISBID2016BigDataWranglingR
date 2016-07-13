# Exercises: https://github.com/SISBID/Module1/blob/gh-pages/labs/dplyr-lab.Rmd

library(dplyr)
library(readxl)

# (2) Open the sheet and look at the information listed. Go to the sheet Final Phase Sequence Data
dat <- read_excel("1000genomes.xlsx", 4, skip = 1)
class(dat)
names(dat)
glimpse(dat)

# (3) Read the Final Phase Sequence Data sheet. Only read the data for the low coverage samples. 
lc <- dat[ , 1:7]
lc <- lc %>% select(samp=Sample, pop=Population, center=Center, platform=Platform,
                    total_seq_aligned=`Total Sequence`,
                    aligned_non_dup=`Aligned Non Duplicated Coverage`, passed_qc = `Passed QC`)
head(lc)

# (4) Calculate total sequence by platform
lc %>% group_by(platform) %>% summarize(total_seq = sum(total_seq_aligned))

# (5) Do the same thing by sequencing center
lc %>% group_by(center) %>% summarize(total_seq = sum(total_seq_aligned))

# (6) Find the subset of samples that passed QC
table(lc$passed_qc)
lc %>% filter(passed_qc == 1)

# (7) Find the subset that passed QC and came from the BCM center
table(lc$center)
bcm_vals <- grep("BCM", unique(lc$center), value=TRUE, ignore.case=TRUE)
lc.bcm <- lc %>% filter(passed_qc == 1) %>% filter(center %in% bcm_vals)
lc.bcm$center

# (8) Calculate the average aligned coverage for each population on 
# the subset of samples that passed QC that came from the BCM. 
lc %>% filter(passed_qc == 1) %>% filter(center %in% bcm_vals) %>% 
  group_by(pop) %>% summarize(meancov=mean(aligned_non_dup), nsamp=n())
