setwd("~/Data Science Portfolio/TJ_survival")
tj_final_game <- read_csv("tj_final_game.csv")

# ANALYSIS
# Simple descriptive stats
ggplot(aes(x = reorder(Team, Team, function(x) -length(x)), fill = Team), data = tj_final_game) +
  geom_bar() +
  theme(legend.position = "none") +
  ylab("Number of Tommy John Surgeries") +
  xlab("MLB Team")


# Survival Curves
# These first few are just to jog my memory on how to actually do this stuff

#summary(survfit(Surv(time, censor) ~ 1, data = tj_final_game))
#plot(survfit(Surv(time, censor) ~ 1, conf.type = "log-log", data = tj_final_game))

tj_plot <- survfit(Surv(time, censor) ~ 1, data = tj_final_game)
ggsurvplot(tj_plot, data = tj_final_game,
           conf.int = TRUE,
           pval = TRUE,
           risk.table = TRUE,
           surv.median.line = "hv")
# It would be interesting to see how many never returned after their TJ.

tj_plotXteam <- survfit(Surv(time, censor) ~ Team, data = tj_final_game)
ggsurvplot(tj_plotXteam, pval = TRUE)

# I couldn't get the faceting to work at all so trying something from the developer. The faceting is a known issue with survminer.
g <- ggsurvplot(tj_plotXteam, pval = FALSE)$plot + theme_bw() + facet_grid("Team", space = "free_y")
g
# I don't think I can get facet to show plots in an appropriate size so I will have to do them individually.
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "ARI", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "ATL", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "BAL", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "BOS", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CHC", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CHW", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CIN", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CLE", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "COL", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "DET", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "HOU", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "KC", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "LAA", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "LAD", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "MIA", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "MIL", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "MIN", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "NYM", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "NYY", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "OAK", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "PHI", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "PIT", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "SD", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "SEA", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "SF", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "STL", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "TB", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "TEX", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "TOR", ]),
           risk.table = TRUE, surv.median.line = "hv")

ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "WAS", ]),
           risk.table = TRUE, surv.median.line = "hv")

# As I expected, there is way too much going on here to really make anything of it so will need to look into this another way.

## THERE IS NOT MINOR LEAGUE DATA AVAILABLE SO I CAN'T INCERASE THE SAMPLE SIZE OF THIS AT ALL AT THE MOMENT
# So long term I could use this as a reason to build a web crawler to build up a minor league database.
# In the meantime I think I should generate a graph faceted by team and maybe I could talk about how maybe some teams had a lot of 
# players not return at all or something. I will have to see what it looks like when separated by team.