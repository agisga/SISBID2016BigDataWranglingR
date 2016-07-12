#--- String trimming
name  = c("Andrew", " Andrew", "Andrew ", "Andrew\t")
library(stringr)
table(name)
name <- str_trim(name)
table(name)

#--- String splitting
# base R:
x <- c("I really", "like writing", "R code programs")
y <- strsplit(x, split = " ") # returns a list
# stringr:
y2 <- str_split(x, " ") # returns a list
substr(name, 2, 4)
str_split("asdf asdf asdf qwer asdf", " ")
str_split("asdf.asdf.asdf.asdf", ".") # `.` treated as regular expression
str_split("asdf.asdf.asdf.asdf", fixed(".")) # `.` treated as character 

#--- Extract
library(dplyr)
y
sapply(y, dplyr::first) # on the fly
sapply(y, nth, 2) # on the fly
sapply(y, last) # on the fly
ss = str_extract(Sal$Name, "Rawling")
head(ss)
ss[ !is.na(ss)]
# with regular exporessions:
head(Sal$AgencyID)
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"))

#--- Grep
Sal = read.csv("Baltimore_City_Employee_Salaries_FY2014.csv",
               as.is = TRUE)
head(Sal)
any(is.na(Sal$Name))
all(complete.cases(Sal)) #returns TRUE if EVERY value of a row is NOT NA
# base R:
grep("Rawlings",Sal$Name)
grep("Rawlings",Sal$Name,value=TRUE)
head(grepl("Rawlings",Sal$Name))
which(grepl("Rawlings", Sal$Name))
Sal[grep("Rawlings",Sal$Name),]
# stringr and dplyr:
head(str_detect(Sal$Name, "Rawlings"))
which(str_detect(Sal$Name, "Rawlings"))
str_subset(Sal$Name, "Rawlings")
Sal %>% filter(str_detect(Name, "Rawlings"))
# with regular expressions in base R:
head(grep("^Payne.*", x = Sal$Name, value = TRUE))
head(grep("Leonard.?S", x = Sal$Name, value = TRUE))
head(grep("Spence.*C.*", x = Sal$Name, value = TRUE))
# with regular expressions in stringr:
head(str_subset(Sal$Name, "^Payne.*"))
head(str_subset(Sal$Name, "Leonard.?S"))
head(str_subset(Sal$Name, "Spence.*C.*"))

#--- Replacing and subbing
# in base R:
Sal$AnnualSalary <- as.numeric(gsub(pattern = "$", replacement="", 
                               Sal$AnnualSalary, fixed=TRUE))
Sal <- Sal[order(Sal$AnnualSalary, decreasing=TRUE), ] 
Sal[1:5, c("Name", "AnnualSalary", "JobTitle")]
# in stringr and dplyr:
dplyr_sal = Sal
dplyr_sal = dplyr_sal %>% mutate( 
  AnnualSalary = AnnualSalary %>%
    str_replace(
      fixed("$"), 
      "") %>%
    as.numeric) %>%
  arrange(desc(AnnualSalary))
check_Sal = Sal
rownames(check_Sal) = NULL
all.equal(check_Sal, dplyr_sal)
