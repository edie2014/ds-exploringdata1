# Load in the common code to load the dataset
source("loadData.R")

# Plot all submetering variables on a single line chart.
#
# Saves the plot the the file "plot1.png" by default.
#
# To display the plot instead, call as makePlot1(useScreen=TRUE)
# SPecify boxLegend=FALSE to prevent enclosing the legend in a box

makePlot3 <- function(useScreen = FALSE, boxLegend = TRUE) {
  
  if (!useScreen) {
    # Open the PNG graphics device if display not requested
    png("plot3.png")
  }
  
  # Load the data
  dt <- getCleanData()
  
  # Plot the actual data, supplying the main title and x-axis label
  p1 <- plot(dt$sample, dt$Sub_metering_1, 
       main="", 
       ylab="Energy sub metering", 
       xaxt = "n",
       xlab="",
       type="n"
       )
  
  # Add the axes to the plot, setting them apart from the data
  axis(1, 
       at=c(min(dt$sample),median(dt$sample),max(dt$sample)),
       labels=c("Thu", "Fri", "Sat"), 
       tick=TRUE, outer=FALSE)

  # Add each of the sub-meters to the graph with a different color
  lines(dt$sample,dt$Sub_metering_1,col="black")
  lines(dt$sample,dt$Sub_metering_2,col="red")
  lines(dt$sample,dt$Sub_metering_3,col="blue")
  
  # Add the legend, optionally suppressing the enclosing border
  legend("topright", "", 
         c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=c("black","red","blue"),
         lty="solid", 
         bty= if(boxLegend) "o" else "n")
  
  if (!useScreen){
    # Close the PNG device if it's open
    dev.off()
  }
  
  # The function has no value
  NULL
}