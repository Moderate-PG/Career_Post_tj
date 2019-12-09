# ANALYSIS
# Simple descriptive stats
ggplot(aes(x = reorder(Team, Team, function(x) -length(x)), fill = Team), data = tj_final_game) +
  geom_bar() +
  theme(legend.position = "none") +
  ylab("Number of Tommy John Surgeries") +
  xlab("MLB Team")


# Survival Curves
# These first few are just to jog my memory on how to actually do this stuff
summary(survfit(Surv(time, censor) ~ 1, data = tj_final_game))

plot(survfit(Surv(time, censor) ~ 1, conf.type = "log-log", data = tj_final_game))
