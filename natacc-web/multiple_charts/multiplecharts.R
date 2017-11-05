# Clear
rm(list=ls())
setwd("/Users/admin/Sites/natacc-all/multiple_charts")

# Libraries
library(readxl)

# Download Data
#download.file(url = "http://www.abs.gov.au/ausstats/meisubs.NSF/log?openagent&5206001_key_aggregates.xls&5206.0&Time%20Series%20Spreadsheet&24FF946FB10A10CDCA258192001DAC4B&0&Jun%202017&06.09.2017&Latest",mode = "wb",destfile = "5206.xls")

# Read Data
abs <- read_excel("5206.xls", sheet = "Data1", skip = 9)
colnames(abs)[1] <- "date"

# Legend
legend <- read_excel("5206.xls", sheet = "Data1")
legend <- legend[1:9,]
colnames(legend)[1] <- "Series"

# Subset for export
abs_export <- subset(abs, select=c("date","A2304398V"))
abs_export2 <- subset(abs, select=c("date","A2302705W"))

# Rename columns with readable text
colnames(abs_export)[2] <- "close"
colnames(abs_export2)[2] <- "close"

# Fix date format for export
abs_export$newdate <- strptime(as.character(abs_export$date), "%Y-%m-%d")
abs_export$date <- format(abs_export$newdate, "%d-%b-%y")
abs_export <- abs_export[,-3]

abs_export2$newdate <- strptime(as.character(abs_export2$date), "%Y-%m-%d")
abs_export2$date <- format(abs_export2$newdate, "%d-%b-%y")
abs_export2 <- abs_export2[,-3]

# Kill nas
abs_export <- abs_export[complete.cases(abs_export),]
abs_export2 <- abs_export2[complete.cases(abs_export2),]


# Export
write.csv(abs_export, file="abs_export.csv", row.names=FALSE, quote = FALSE)
write.csv(abs_export2, file="abs_export2.csv", row.names=FALSE, quote = FALSE)
#write.table(abs_export, file='abs_export.tsv', quote=FALSE, sep='\t', row.names = FALSE)
