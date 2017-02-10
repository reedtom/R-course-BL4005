#########################################################################################################
###################----------------- BL4005 R COURSE ---------------------------#########################
#########################################################################################################

# Created by: Tom Reed.
# Last updated: Feb 9 2017
# Credits: This Course leans heavily on the book "Getting Started with R: An Introduction for Biologists;
# an excellent book by Andrew P. Beckerman and Owen L. Petchey (Oxford University Press, 2012)
# See here: http://www.r4all.org/the-book/

# ***NOTE*** ANYTHING AFTER THE # SYMBOL IS ANNOTATED COMMENTS - R WILL RECOGNISE 
# THIS AS COMMENTS (I.E. IGNORE IT), RATHER THAN AS CODE TO RUN.  IT'S VERY IMPORTANT TO ADD LOTS OF 
# COMMENTS LIKE THIS TO ALL YOUR R SCRIPTS, SO THAT YOU KEEP TRACK OF WHAT YOU'RE DOING, AND SO THAT 
# OTHERS CAN UNDERSTAND YOUR CODE


# -----------------------------------------------------------
# This file contains all the R code from the pdf document R_Course_BL4005.pdf. 
# This is a .R file, so R Studio will recognise it as being an R script file. 
# This file be saved within the folder called BL4005_RCourse, which i made available 
# on Blackboard to everyone. 
# Simply save the whole folder somewhere on your harddrive. I recommend simply saving it into My Documents 
# on your C Drive. 
# Each block of code below is a snippet that you can use for your own purposes, you'll just have to change the
# names of the data frame and the columns obviously for it to work with your own data! 
# The best way to learn R is to simply play around with the code, so you can figure out for yourself
# what it's doing.
# HAVE FUN!!!!
# -----------------------------------------------------------


### REMEMBER: TO SEND A LINE OF CODE TO THE R CONSOLE BELOW, SIMPLY PLACE THE MOUSE CURSOR ANYWHERE IN
### THE LINE, AND CLICK "CONTROL+ENTER" (at the same time!!!)
### YOU CAN ALSO RUN MULTIPLE LINES OF CODE AT THE SAME TIME BY SIMPLY SELECTING A WHOLE CHUNK, AND THEN 
### CLICKING "CONTROL+ENTER"

###########################################################################################
# 1. THIS BLOCK OF CODE ALLOWS YOU TO READ IN DATA FROM AN EXCEL FILE AND HAVE A LOOK AT IT
###########################################################################################

# First, let's clear R's brain:
rm(list=ls())

# getwd (get working directory) tells you where R is currently looking
getwd()

### I highly recommend you create a folder on your hard drive, given it a name (e.g. "BL4005_Rcourse") 
## and then save this script file and your data file(s) in that one folder. 
## Then, simply close RStudio, navigage to this folder, right-click on this script file, and then select 
# "Open with", and then select "RStudio". Once you have re-opened the script file like this, RStudio will 
# automatically set your current working directory (i.e. folder) to the one in which the script file is 
# saved, i.e. the folder you've just created on your hard drive!!

# If you want to change your working directory for any resason, you can use the setwd 
# (set working directory) function, which tells R where to look. For example, you might have a folder on 
# your C drive in My Documents called "BL4005_Rcourse". So then you would simply run this next line of code, 
# taking away the # symbol in front of it of course:

# setwd("C:/MyDocuments/BL4005_Rcourse")

# Just to be sure, let's check one more time which folder we are working in:
getwd()

# We want this to be the folder in which we've saved our data file.  To check what files are in this folder
# we are now in, you can use this:
list.files()

# In this sample script, we are going to read in the sample data contained in the file "compensation.csv".   

# So let's go ahead and read in the data and assign it a name. () use "comp.data" here, but you can call it
#  Sue if you like, anything will do!!! ("I tell ya, life ain't easy for a boy named "Sue")
comp.data<- read.csv("compensation.csv") 

# Check the data a few different ways - to confirm it is what you expected!
names(comp.data) # returns the names of the columns

head(comp.data)  # returns the first 6 rows

dim(comp.data)   # returns the number of rows and columns (dimensions of the dataset)

str(comp.data)   #  a powerful compilation of the above

summary(comp.data) # a powerful way to summarise the data in each column of your data frame
###########################################################################################




###########################################################################################
# 2. THIS BLOCK OF CODE WILL ALLOW YOU TO CREATE HISTOGRAMS AND MAKE THEM LOOK NICE
###########################################################################################

# If your whole scripts starts here, you obviously will have to first copy and paste and then run 
# Code Chunk 1" above, which will read in the data and check it etc.

# Let's select just the column "Root" and give it a name (here i use "root")
root<- comp.data$Root # note the use of the dollar sign in the above to tell R that the variale "Root"
# lives within the data frame we have called "comp.data"

# This creates a simple histogram:
hist(root)

# Or equivalently, you could do this:
hist(comp.data$Root)

# Or equivalently, you could do this (like i say, there's never just one way to skin a cat in R...):
with(comp.data, hist(Root))


# Let's say you wanted to make 2 histograms, the above one, and then another one where you only plot 
# values of Root greater than 7:

# First let's tell R to get ready to plot two graphs, one beside the other.
par(mfrow=c(1,2))

# Now make the histogram of the full Root data:
hist(comp.data$Root, xlim=c(4,11), 
     ylim=c(0,10), xlab="Root diameter (mm)",
     main="Full data")

# Now make the histogram of the subsettted Root data, which we first store in a new object called "x":
x<- subset(comp.data, Root > 7)
hist(x$Root, xlim=c(4,11), 
     ylim=c(0,10), xlab="Root diameter (mm)",
     main="Subsetted data", breaks=4)

# Want green histograms with larger axis labels and smaller font size for the axis values?? No problem:

hist(comp.data$Root, xlim=c(4,11), 
     ylim=c(0,10), xlab="Root diameter (mm)",
     main="Full data", col="green", 
     cex.lab=1.2, cex.axis=0.8)

# Now make the histogram of the subsettted Root data, which we first store in a new object called "x":
x<- subset(comp.data, Root > 7)
hist(x$Root, xlim=c(4,11), 
     ylim=c(0,10), xlab="Root diameter (mm)",
     main="Subsetted data", breaks=4, col="green", 
     cex.lab=1.2, cex.axis=0.8)

###########################################################################################




###########################################################################################
# 3. THIS BLOCK OF CODE IS FOR MAKING SUMMARIES OF YOUR DATA IN DIFFERENT WAYS
###########################################################################################

# If your whole scripts starts here, you obviously will have to first copy and paste and then run 
# Code Chunk 1" above, which will read in the data and check it etc.

# A really simple way to see how many measurements you have per level of some factor is to use table():
table(comp.data$Grazing)


# I always use this really handy function called with(), which is a less clunky way of telling R to take 
# the data frame "comp.data" and then do something with it:
  
with(comp.data,
     table(Grazing))

# The aggregate function is also super handy:
aggregate(comp.data$Fruit, list(comp.data$Grazing), mean)

# Or better yet, use this:
with(comp.data,  aggregate(Fruit, list(Grazing), mean))

# Let's say you had a second categorical variable. Let's just make one up like this:
comp.data$madeup<- sample(rep(c("A", "B"),20))
# A SIDE CHALLENGE: see if you can figure out how the above line of code just worked. The goal of this line
# of code was to generate a random string of "A"s and "B"s, of length = 40 (same number of rows in "comp.data")

# Have a look at this new made up variable by simply entering it's name into R and clicking return
# (or just run the next line of code):
comp.data$madeup

# Or just have a look at the first 6 rows (lines) of the data frame:
head(comp.data)


# We can now use the aggregate function to get a summmary of mean values of Fruit, for every combination of
# Grazing treatment and our new made-up categorical variable:
with(comp.data,  
     aggregate(Fruit, list(Grazing, madeup), mean))

# Or we can use table to look at the sample size for each of these combinations:
with(comp.data, 
     table(list(Grazing, madeup)))



# tapply() is another super handy function thar returns the same values as aggregate(), 
# using a very similar structure, but instead of returing a data frame, it return a matrix. 
# That can be really useful say if you wanted to then make a bar plot

tapply(comp.data$Fruit, list(comp.data$Grazing), mean)

# Or equivalently, 
with(comp.data, 
     tapply(Fruit, Grazing, mean))

# Or if you want the combinations of Grazing and madeup:
with(comp.data, 
     tapply(Fruit, list(Grazing,madeup), mean))
###########################################################################################




###########################################################################################
# 4. THIS BLOCK OF CODE IS FOR MAKING BAR PLOTS
###########################################################################################

# If your whole scripts starts here, you obviously will have to first copy and paste and then run 
# Code Chunk 1" above, which will read in the data and check it etc.


# Here is how to make a simple box-plot:
with(comp.data,
     boxplot(Fruit ~ Grazing))

# But say we wanted a bar plot, not a box-plot.  First we have to caculate a few things:

# Calculate mean of each group using tapply, which returns a matrix. As good practice, we'll tell R 
# to ignore any missing values (na.rm=T) if they exist. Here there are no missing values, but there 
# might be in other data sets!!
mean.fruit <- with(comp.data, tapply(Fruit, list(Grazing), mean, na.rm=T))

# Calculate standard deviation of each group:
sd.fruit <- with(comp.data, tapply(Fruit, list(Grazing), sd, na.rm=T))

# Calculate sample size (n) of each group:
n.fruit <- with(comp.data, tapply(Fruit, list(Grazing), length))

# Now calculate the standard errors:
se.fruit <- sd.fruit/ sqrt(n.fruit)

# Have a look at each of the above new objects, by simply typing their name into the R console in turn, and 
# hitting return each time (or just select the name from the above, and hit "CONTROL+ENTER")


# Making the bar plot couldn't be easier:

# First we'll set the graphics window to be a single-panel format:
par(mfrow=c(1,1))

# Then the function to make the actual barplot:
barplot(mean.fruit)

# However, there are no error bars in this bar plot, and in general it could do with some nicer formatting. 
# Take a deep breath...

# First, we need to create a new object called "mids" (note: you can call it whatever you like!), that 
# stores the x-axis midpoints of the bars - the location of the bars on the x-axis.

mids<- barplot(mean.fruit, 
          xlab="Treatment",
          ylab="Fruit Production",
          ylim=c(0,100),
          cex.names=1.1, 
          cex.lab=1.2,
          cex.axis=1.1)

# Now, we can use the Arrows function to put error bars on the plot.  Have a look at the arrrows 
# function in R help to see what argumeents this take, and have a look at example(arrows) to 
# understand more about how this function works

arrows(x0=mids, y0=mean.fruit - se.fruit, x1=mids, y1=mean.fruit + se.fruit, 
code = 3,angle = 90, length=0.1)

# We can even add text on the bars themselves to indicate the sample sizes, like this:
text(x=mids, y=5, labels=paste("n=", n.fruit))

# Same as above, but with each bar a different colour, the error bars thicker, and the sample sizes text 
# in white and a bit bigger:

# Let's also make the figure margins a bit narrower (play around with this to understand it!!)
par(mfrow=c(1,1), mar=c(5,9,4,7))

mids<- barplot(mean.fruit, 
               xlab="Treatment",
               ylab="Fruit Production",
               ylim=c(0,100),
               cex.names=1.1, 
               cex.lab=1.2,
               cex.axis=1.1,
               col=c("red", "blue"))


arrows(x0=mids, y0=mean.fruit - se.fruit, x1=mids, y1=mean.fruit + se.fruit, 
       code = 3,angle = 90, length=0.1,  lwd=2)

text(x=mids, y=5, labels=paste("n=", n.fruit), col="white", cex=1.2)


###########################################################################################




###########################################################################################
# 5. THIS BLOCK OF CODE IS FOR SAVING A FIGURE AS A PDF (ALWAYS HIGH RESOLUTION!!!)
###########################################################################################

# If your whole scripts starts here, you obviously will have to first copy and paste and then run 
# Code Chunk 1" above, which will read in the data and check it etc.

# Open the PDF device - specify a file name and a paper size
pdf(file="Barplot.pdf", paper="a4") # You can change the name of the output to whatever you like, here 
                                    # i've simply called the file "Barplot.pdf"

# Make a barplot, as above:
par(mfrow=c(1,1), mar=c(5,9,4,7))

mids<- barplot(mean.fruit, 
               xlab="Treatment",
               ylab="Fruit Production",
               ylim=c(0,100),
               cex.names=1.1, 
               cex.lab=1.2,
               cex.axis=1.1,
               col=c("red", "blue"))


arrows(x0=mids, y0=mean.fruit - se.fruit, x1=mids, y1=mean.fruit + se.fruit, 
       code = 3,angle = 90, length=0.1,  lwd=2)

text(x=mids, y=5, labels=paste("n=", n.fruit), col="white", cex=1.2)

# Now simply close the connection to your hard drive like this:
dev.off()

# That's it! The PDF will now have magically appeared in your working folder.  What folder is this, 
# you ask?  The one you are currently working in! Where am i currently working you ask? Don't ask me, 
# ask R!!!:
getwd()

# In fact, if you now use the next line of code, you can see the file has been added to this folder:
list.files()

###########################################################################################




###########################################################################################
# 6. THIS BLOCK OF CODE IS FOR MAKING A SIMPLE SCATTER-PLOT
###########################################################################################

# If your whole scripts starts here, you obviously will have to first copy and paste and then run 
# Code Chunk 1" above, which will read in the data and check it etc.

# First let's set the graphing space. For a laugh, let's make it a 2 x 2 panel plot, and add scatter-plots
# as we go along:

par(mfrow=c(2,2), mar=c(5,5,2,2))

# Making a scatter plot is a doddle:
plot(Fruit ~ Root, data=comp.data)

#That actually looks pretty good already, but we can make it nicer:
  
# Adding different axis labels, increasing axes fonts, getting rid of the square box, and changing the 
# plotting symbol:
  
plot(Fruit ~ Root, data=comp.data,
     xlab="Root Biomass",
     ylab="Fruit Production",
     cex.lab=1.2,
     cex.axis=1.1,
     cex= 1.2,
     bty="l", 
     pch=2)



#  If you look closely at these scatter-plots, you will notice two groups of data. 
# These actually correspond to the two levels of the variable "Grazing": Grazed versus Ungrazed. 

# Let's colour in these differently:

culr <- c("green", "blue")

plot(Fruit ~ Root, data=comp.data,
xlab="Root Biomass",
ylab="Fruit Production",
cex.lab=1.2,
cex.axis=1.1,
cex= 1.2, 
pch=21,
bty="l",
bg=culr[Grazing])



# Adding a legend:

legend("topleft", legend = c("Grazed", "Ungrazed"),
      pch=21, pt.bg = c("Green", "Blue"), pt.cex=2)


# Same graph again, but with different symbols for each group, and with legend in different place:

plot(Fruit ~ Root, data=comp.data,
     xlab="Root Biomass",
     ylab="Fruit Production",
     cex.lab=1.2,
     cex.axis=1.1,
     cex= 1.2, 
     pch=ifelse(Grazing=="Grazed", 21, 22),
     bty="l",
     bg=culr[Grazing])

culr <- c("green", "blue")

legend("bottomright", legend = c("Grazed", "Ungrazed"),
       pch=c(21,22), pt.bg = c("Green", "Blue"), pt.cex=2)

###########################################################################################




##############################################################################################
# 7. THIS BLOCK OF CODE IS FOR RUNNING GENERAL LINEAR MODELS AND ADDING FITTED LINES TO A PLOT
##############################################################################################

# If your whole scripts starts here, you obviously will have to first copy and paste and then run 
# Code Chunk 1" above, which will read in the data and check it etc.


## You will recall that there are actually different patterns going on here for Grazed versus Ungrazed 
# treatments:
  
par(mfrow=c(1,1))

culr<- ifelse(comp.data$Grazing == "Grazed", "green", "blue")

plot(Fruit ~ Root, data=comp.data,
     xlab="Root Biomass",
     ylab="Fruit Production",
     cex.lab=1.2,
     cex.axis=1.1,
     cex= 1.2, 
     pch=21,
     bty="l",
     bg=culr)

legend("topleft", legend = c("Grazed", "Ungrazed"),
       pch=21, pt.bg = c("Green", "Blue"), pt.cex=1.5)

# In this case, we might want to test for the effets of BOTH "Root" and "Grazing" in the same model. 
# This is called a general linear model (GLM), and one can include multiple explanatory variables, 
# which can be continuous or categorical. 

# This also couldn't be simpler in R:

# We simply include both Root and Grazing as separate terms on the right-hand side of the ~ 
# in the lm() function, seperated by a + sign:
myfirstGLM<- lm(Fruit ~ Root + Grazing, data=comp.data)

# We just stored the results in a new object called myfirstGLM, now let's see a summary of the 
# actual results:
summary(myfirstGLM)

# Or you can see the output as an ANOVA table:
anova(myfirstGLM)

# To test for an interaction between Root and Grazing, we simply specify the model like this, using the * symbol between the terms, which stands for "please kindly test for an interaction there R, like a good lad"
myfirstGLM2<- lm(Fruit ~ Root * Grazing, data=comp.data)

# We just stored the results in a new object called myfirstGLM2, now let's see a summary of the actual 
# results:
summary(myfirstGLM2)

# Or you can see the output as an ANOVA table:
anova(myfirstGLM2)


# So it seems that there is no interaction here, that is, the effect of Root Biomass on Fruit Production 
# is the same in both Grazing treatments. 

# We can show that graphically by plotting seperate lines through the data points for each treatment level:


xv<- seq(min(comp.data$Root), max(comp.data$Root), length.out=2)
GR<- coef(myfirstGLM)[1] + coef(myfirstGLM)[2]*xv 
UGR<- coef(myfirstGLM)[1] + coef(myfirstGLM)[2]*xv + coef(myfirstGLM)[3]

lines(xv, GR, col="green", lwd=2)
lines(xv, UGR, col="blue", lwd=2)

############################################################################################################

