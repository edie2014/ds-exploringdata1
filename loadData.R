# Ensure the  needed libraries are loaded and available.
require(dplyr)
require(lubridate)

# getCleanData()
#
# Load the household-power dataset, subsetted to specific dates (February 1 and 2, 2007),
# and cleaned up.
#
# Returns a dplyr tbl_df object.

getCleanData<-function() {
  FIRST_SAMPLE_DATE = dmy("01/02/2007")
  LAST_SAMPLE_DATE = dmy("02/02/2007")
  # First, load just the inital line to get some information (like column classes etc)
  h<-read.table('household_power_consumption.txt', 
                header=TRUE, sep=';',  
                nrow=1, 
                stringsAsFactors = FALSE)

  # extract the classes for each column from this, so that the real read goes faster.
  tb_classes <- sapply(h,class)

  # Get the date for the first sample
  firstDate <- dmy(h$Date[1])
  
  # Calculate number of days and rows we are going to read to get to the desired data.
  # Thankfully, the dates we're interested in are at the start of the file. There may be
  # missing samples, so we can't simply skip leading rows as calculating how many rows to
  # skip is error-prone.
  #
  # Read 3 days worth of samples from the first date, to guarantee we don't miss any.
  # Converting the time difference from days to minutes gets the number of rows to read.
  readDays <- (FIRST_SAMPLE_DATE+ddays(3)) - firstDate
  readRows <- as.numeric(readDays,units="mins")
  
  # Now actually read the file, 
  #   - use the column classes from our original read
  #   - convert the date column to lubridate dates so we can filter on them
  #   - subset the data just to the dates we want
  #   - add a new column 'sample' which is just the row number and can be used
  #     as the x co-ordinate in plots.
  sdf<-
    tbl_df(read.table('household_power_consumption.txt', 
                      header=TRUE, sep=';',  
                      nrow=readRows, 
                      colClasses=tb_classes, 
                      stringsAsFactors = FALSE, 
                      na.strings="?")) %>%
    mutate(Date=dmy(Date)) %>%
    filter(Date %in% c(FIRST_SAMPLE_DATE,LAST_SAMPLE_DATE)) %>%
    mutate(sample=row_number())
}