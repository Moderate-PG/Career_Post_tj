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
           risk.table = TRUE)
# It would be interesting to see how many never returned after their TJ.

tj_plotXteam <- survfit(Surv(time, censor) ~ Team, data = tj_final_game)
ggsurvplot(tj_plotXteam, pval = TRUE)

# I couldn't get the faceting to work at all so trying something from the developer. The faceting is a known issue with survminer.
g <- ggsurvplot(tj_plotXteam, pval = FALSE)$plot + theme_bw() + facet_grid("Team", space = "free_y")
g
# I don't think I can get facet to show plots in an appropriate size so I will have to do them individually.
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "ARI", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "ATL", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "BAL", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "BOS", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CHC", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CHW", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CIN", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "CLE", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "COL", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "DET", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "HOU", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "KC", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "LAA", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "LAD", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "MIA", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "MIL", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "MIN", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "NYM", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "NYY", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "OAK", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "PHI", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "PIT", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "SD", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "SEA", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "SF", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "STL", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "TB", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "TEX", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "TOR", ]))
ggsurvplot(survfit(Surv(time, censor) ~ 1, data = tj_final_game[tj_final_game$Team == "WAS", ]))

# As I expected, there is way too much going on here to really make anything of it so will need to look into this another way.

## THERE IS NOT MINOR LEAGUE DATA AVAILABLE SO I CAN'T INCERASE THE SAMPLE SIZE OF THIS AT ALL AT THE MOMENT
# So long term I could use this as a reason to build a web crawler to build up a minor league database.
# In the meantime I think I should generate a graph faceted by team and maybe I could talk about how maybe some teams had a lot of 
# players not return at all or something. I will have to see what it looks like when separated by team.