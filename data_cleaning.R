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

