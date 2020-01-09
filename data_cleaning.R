# UPDATE THE MERGING
# I need to improve the merging of these different files. The SFBB-Player ID Map has the MLB ID (MLBAMID in TJ list) as well as the 
# BBREF ID which is just IDPlayer (the first column) in the SFBB Player ID Map. I should update the merging, but still need 
# a better way of dealing with players who have multiple surgeries. 
# Is innerjoin() still appropriate for dealing with multiple surgeries, it won't remove them as duplicates or something by accident?
# I need to check on this. Although technically they won't be the same as the surgery dates will be different. 


















# Data cleaning and merging of datasets for tommy john career survival analysis

# Dataset of List of pitchers having received tommy john
setwd("~/Data Science Portfolio/TJ_survival")
tj_list <- read_csv("tj_list_mlb.csv")
tj_list$`TJ Surgery Date` <- mdy(tj_list$`TJ Surgery Date`)
tj_list <- tj_list %>%
  select(Player:Position, Age, mlbamid, fgid) %>%
  filter(Position == "P", Level == "MLB") %>%
  arrange(mlbamid)

tj_list <- tj_list %>%
  arrange(`TJ Surgery Date`, mlbamid)

tj_list$Team <- as.factor(tj_list$Team)
tj_list$Player[duplicated(tj_list$Player) == TRUE]
#tj_list$mlbamid[duplicated(tj_list$mlbamid) == TRUE]
multiple_tj <- tj_list$Player[duplicated(tj_list$Player) == TRUE]

# The 'Team' variable assumes that a player started with and stayed with a team throughout rehab.
# At this point, I am only assessing by the team at time of the surgery although changing teams is certainly going to influence thing


# Load in the pitching appearance data
setwd("~/Data Science Portfolio/TJ_survival/Appearance data/baseballdatabank-2019.2/baseballdatabank-2019.2/core/")

people <- read_csv("People.csv") 
people <- people %>%
  select(playerID, nameFirst, nameLast, nameGiven, finalGame)

pitchers <-  read_csv("Pitching.csv")
pitchers <- pitchers %>%
  select(playerID) %>%
  arrange(playerID) %>%
  unique.data.frame()
################
#####
# There would be a better way of doing this but try to identify if any of the players with multiple TJ's 
# overlap with the players with the same name.
#for (k in 1:length(multiple_tj)) {
#  for (l in 1:length(pitchers_duplicated)) {
#    if (multiple_tj[k] == pitchers_duplicated[l]) {
#      print(multiple_tj[k])
#    }
#    else {
#      print("No Match")
#    }
#  }
#}
# Join the pitchers and people tables. This didn't work though so need to remove all the duplicates first

pitcher_list <- inner_join(people, pitchers, "playerID")

pitcher_list$Player <- paste(pitcher_list$nameFirst,  pitcher_list$nameLast)
pitcher_list <- pitcher_list %>% filter(finalGame >= 1970-01-01)

pitcher_list$Player[duplicated(pitcher_list$Player) == TRUE]
pitchers_duplicated <- pitcher_list$Player[duplicated(pitcher_list$Player) == TRUE]
pitchers_duplicated <- as.data.frame(pitchers_duplicated)
colnames(pitchers_duplicated) <- "Player"

pitchers_duplicated_df <- pitcher_list[duplicated(pitcher_list$Player) == TRUE,]

pitcher_list <- pitcher_list %>%
  anti_join(pitchers_duplicated_df, by = "Player")


tj_final_game <- inner_join(tj_list, pitcher_list, "Player") 
# There are 25 fewer rows here than in tj_list which I don't know why they're missing.
tj_final_game <- tj_final_game %>%
  select(Player:Team, Age:playerID, finalGame)

colnames(tj_final_game) <- c("Player", "TJ_Surgery_Date", "Team", "Age", "mlbamid", "fgid", "playerID", "finalGame")
tj_final_game
# No matches between pitchers with multiple TJs and pitchers with the same name

# The most recent of the final games are 2018 so I think I should remove all players with a TJ Surgery Date in 2019.
tj_final_game <- tj_final_game %>%
  filter(TJ_Surgery_Date < "2015-01-01")
# CENSORING
# How to do the censoring is more complicated. I think classifying final games in 2018 as censored. Can reassess this
# at a later date.
# Final game is the "time of death" unless they had a second TJ which should be the "time of death".
tj_final_game$Player[duplicated(tj_final_game$Player) == TRUE]
tj_final_game <- tj_final_game %>% arrange(Player)

tj_final_game$censor <- rep(NA, 322)

# This marks final games in 2018 as censored
for (i in 1:322) { # Hard coded lenght of the df which is not ideal.
  if (tj_final_game$finalGame[i] >= "2018-01-01") {
    #print(tj_final_game$Player[i])
    #sum <- sum + 1
    #print(sum)
    tj_final_game$censor[i] <- 0
  }
  else {
    tj_final_game$censor[i] <- 1
  }
}

# This marks 2nd TJ as a "death"
for (i in 1:321) {
  if (tj_final_game$Player[i] == tj_final_game$Player[i + 1]) {
    #print(tj_final_game$Player[i])
    tj_final_game$censor[i + 1] <- 1
  }
}

# Calculating the amount of time between TJ surgery and the final game.
# If the player never returned to the majors following surgery, assuming the surgery was before 2018, they are considered 
# retired at time of surgery to avoid any negative values.

tj_final_game$time <- tj_final_game$finalGame - tj_final_game$TJ_Surgery_Date
for (i in 1:322) {
  if (tj_final_game$time[i] < 0) {
    tj_final_game$time[i] <- 0
  }
}
# Move onto data analysis now and I can come back to sort the cleaning out later. The basic format I need is in place.
setwd("~/Data Science Portfolio/TJ_survival")
write_csv(tj_final_game, "tj_final_game.csv")
tj_final_game <- read_csv("tj_final_game.csv")
