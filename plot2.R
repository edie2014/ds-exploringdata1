# Load in the common code to load the dataset
source("loadData.R")

# Plot a line graph of Global Active Power.
#
# Saves the plot the the file "plot1.png" by default.
#
# To display the plot instead, call as makePlot1(useScreen=TRUE).
# To suppress the main title of the plot, specify plotTitle=FALSE

makePlot2 <- function(useScreen = FALSE, plotTitle = TRUE) {
  
  if (!useScreen) {
    # Open the PNG graphics device if display not requested
    png("plot2.png")
  }
  
  # Load the data
  dt <- getCleanData()
  
  # Plot the actual data, supplying the main title (if requested)
  mainTitle <- if(plotTitle) "Global Active Power" else ""
  
  p1 <- plot(dt$sample, dt$Global_active_power, 
       main= mainTitle, 
       ylab="Global Active Power (kilowatts)", 
       type = "l",
       xaxt = "n",
       xlab=""
       )
  
  # Add the axes to the plot, setting them apart from the data
  axis(1, 
       at=c(min(dt$sample),median(dt$sample),max(dt$sample)),
       labels=c("Thu", "Fri", "Sat"), 
       tick=TRUE, outer=FALSE)
  axis(2, at=axTicks(2),labels=TRUE, tick=TRUE, outer=FALSE)
  
  if (!useScreen){
    # Close the PNG device if it's open
    dev.off()
  }
  
  # The function has no value
  NULL
}