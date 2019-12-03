# Data cleaning and merging of datasets for tommy john career survival analysis

# Dataset of List of pitchers having received tommy john
setwd("C:/Users/pgill/Documents/Data Science Portfolio/TJ_survival")
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


# Load in the pitching appearance data
setwd("C:/Users/pgill/Documents/Data Science Portfolio/TJ_survival/Appearance data/baseballdatabank-2019.2/baseballdatabank-2019.2/core/")

people <- read_csv("People.csv") 
people <- people %>%
  select(playerID, nameFirst, nameLast, nameGiven, finalGame)

pitchers <-  read_csv("Pitching.csv")
pitchers <- pitchers %>%
  select(playerID) %>%
  arrange(playerID) %>%
  unique.data.frame()

# Join the pitchers and people tables
pitcher_list <- inner_join(people, pitchers, "playerID")

pitcher_list$Player <- paste(pitcher_list$nameFirst,  pitcher_list$nameLast)

tj_final_game <- inner_join(tj_list, pitcher_list, "Player") 
# There are 7 fewer rows here than in tj_list which I don't know why they're missing. That needs to be looked into.
tj_final_game <- tj_final_game %>%
  select(Player:Team, Age:playerID, finalGame)
