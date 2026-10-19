#PSYC 259 Homework 3 - Data Transformation
#For full credit, provide answers for at least 7/11

#List names of students collaborating with: 
Aylin

### SETUP: RUN THIS BEFORE STARTING ----------

#Load packages
library(tidyverse)
ds <- read_csv("data_raw/rolling_stone_500.csv")

### Question 1 ---------- 

#Use a function to check the class of all of the variables in 'ds' 
#Convert "Year" to a numeric, saving it back to 'ds'
#Use a function to check that your conversion succeeded

#ANSWER

glimpse(ds)

ds$Year <- as.numeric(ds$Year)

glimpse(ds)


### Question 2 ---------- 

# Using a dplyr function,
# change ds so that all of the variables are lowercase

#ANSWER

ds <- rename_with(ds, tolower)
glimpse(ds)

### Question 3 ----------

# Use mutate to create a new variable in ds that has the decade of the year as a number
# For example, 1971 would become 1970, 2001 would become 2000
# Hint: read the documentation for ?floor and make sure year is numeric (from Question 1)

#ANSWER

??floor
ds$decade <- (floor(ds$year / 10) * 10)
glimpse(ds)

### Question 4 ----------

# Sort the dataset by rank so that 1 is at the top

#ANSWER

ds <- arrange(ds, rank)
glimpse(ds)

### Question 5 ----------

# Use filter and select to create a new tibble called 'top10'
# That just has the artists and songs for the top 10 songs

#ANSWER

top10 <- filter(ds, rank < 11)
glimpse(top10)

top10 <- (select(top10, song, artist))
glimpse(top10)

### Question 6 ----------

# Use summarize to find the earliest, most recent, and average release year
# and save the results to a new tibble called "ds_sum"
# Hint, the function drop_na() might help. Read ?drop_na

#ANSWER

?drop_na
ds_no_na <- drop_na(ds, year)
glimpse(ds_no_na)

ds_sum <- summarize(ds_no_na, earliest = min(year), most_recent = max(year), average = mean(year))
ds_sum

### Question 7 ----------

# Use filter on the original dataset 'ds' to find all of the artists/song titles from 
# the min/max/mean years that you identified in 'ds_sum'
# Use one filter command only, and sort the responses by year
# Bonus: find a way to do it without hard coding the years (i.e. pull them from ds_sum)
# (this might take some searching to find functions that will help)

#ANSWER

ds_by_year <- filter(ds, year %in% c(1879, 1980, 2020))
arrange(ds_by_year, year)

### Question 8 ---------- 

# There's an error here. The oldest song "Brass in Pocket"
# is from 1979! Use mutate and ifelse to fix the error in 'ds'
# then recalculate decade, and then
# recalculate the responses from Questions 6-7 to
# find the correct oldest, averag-ist, and most recent songs

#ANSWER

?ifelse

ds <- ds %>% mutate(year = ifelse(year == 1879, 1979, year))
view(ds)

ds$decade <- (floor(ds$year / 10) * 10)
glimpse(ds)

ds_no_na <- drop_na(ds, year)
ds_sum <- summarize(ds_no_na, earliest = min(year), most_recent = max(year), average = mean(year))
ds_sum

ds_by_year <- filter(ds_no_na, year %in% c(1937, 1981, 2020))
arrange(ds_by_year, year)

### Question 9 ---------

# Use group_by and summarize to find the average rank and 
# number of songs on the list by decade. To make things easier
# filter out the NA values from decade before summarizing
# You don't need to save the results anywhere
# Use the pipe %>% to string the commands together

#ANSWER

ds_no_decade_na <- filter_out(ds, is.na(decade))
ds_no_decade_na %>% group_by(decade) %>% summarize(average_rank = mean(rank))

### Question 10 --------

# Look up the dplyr "count" function
# Use it to count up the number of songs by decade
# Then use slice_max() to pull the row with the most songs
# Use the pipe %>% to string the commands together
# Check against your answers from Question 9 to make sure it matches

#ANSWER

?count
?slice_max
songs_by_decade <- ds_no_decade_na %>% group_by(decade) %>% count(decade)
glimpse(songs_by_decade)
slice_max(songs_by_decade, n, n = 1)

### Question 11 ------
# Use RStudio's styler to style all the code in your homework
