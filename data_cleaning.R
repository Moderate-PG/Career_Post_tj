# Data cleaning and merging of datasets for tommy john career survival analysis

# Dataset of List of pitchers having received tommy john
tj_list <- read_csv("tj_list_mlb.csv")
tj_list$`TJ Surgery Date` <- mdy(tj_list$`TJ Surgery Date`)
tj_list <- tj_list %>%
  select(Player:Position, Age, mlbamid, fgid) %>%
  filter(Position == "P", Level == "MLB") %>%
  arrange(mlbamid)

tj_list <- tj_list %>%
  arrange(`TJ Surgery Date`, mlbamid)

tj_list$Team <- as.factor(tj_list$Team)

# The 'Team' variable assumes that a player started with and stayed with a team throughout rehab.
# At this point, I am only assessing by the team at time of the surgery although changing teams is certainly going to influence thing

# Import appearance data from pybaseball

# I can't just use playerid_lookup and return everything, last name is required. So I have 2 options as I can see it at
# the moment: 1) need to run a python loop (either in R Markdown or a python script) going through all the names from 
# the tj_list and extract the dates from the pybaseball data frame. The issue with this data is that it only has years
# and not month and day. 
# Option 2) is to maybe webscrape and get dates but not sure where to webscrape from. 