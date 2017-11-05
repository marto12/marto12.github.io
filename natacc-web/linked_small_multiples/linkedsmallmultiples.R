# Clear
rm(list=ls())
setwd("/Users/admin/Sites/natacc-all/linked_small_multiples/data/")

# Libraries
library(readxl)
library(reshape2)

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
abs_export <- subset(abs, select=c("date","A2298668K", "A2304328L", "A2302701L"))

# Rename columns with readable text
for(i in 2:dim(abs_export)[2]) {
  colnames(abs_export)[i] <- colnames(legend)[i]
}

# Fix date format for export
abs_export[,1] <- gsub("-","",abs_export$date)
abs_export <- abs_export[complete.cases(abs_export),]


# Convert from wide to long
abs_export <- melt(abs_export, id.vars="date")
abs_export <- abs_export[order(abs_export$date),]
colnames(abs_export)[1] <- "year"
colnames(abs_export)[2] <- "category"
colnames(abs_export)[3] <- "n"



# Export
write.csv(abs_export, file="abs_export.csv", row.names=FALSE, quote = TRUE)
write.table(abs_export, file='abs_export.tsv', quote=TRUE, sep='\t', row.names = FALSE)
