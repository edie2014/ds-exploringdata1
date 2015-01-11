# Load in the common code to load the dataset
source("loadData.R")

# Plot a histogram of Global Active Power.
#
# Saves the plot the the file "plot1.png" by default.
#
# To display the plot instead, call as makePlot1(useScreen=TRUE). This can be
# used to draw the plot on a different plotting device.

makePlot1 <- function(useScreen = FALSE) {
  
  if (!useScreen) {
    # Open the PNG graphics device if display not requested
    png("plot1.png")
  }
  
  # Load the data
  dt <- getCleanData()
  
  # Plot the actual data, supplying the main title and x-axis label
  p1 <- hist(dt$Global_active_power, 
       main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", 
       col = "red")
  
  # Add the axes to the plot, setting them apart from the data
  axis(1, at=axTicks(1),labels=TRUE, tick=TRUE, outer=TRUE)
  axis(2, at=axTicks(2),labels=TRUE, tick=TRUE, outer=TRUE)
  
  if (!useScreen){
    # Close the PNG device if it's open
    dev.off()
  }
  
  # The function has no value
  NULL
}