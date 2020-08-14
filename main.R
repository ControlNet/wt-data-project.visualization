source("visualization/utils.R")
source("visualization/static_plot.R")
source("visualization/time_animation.R")
source("visualization/time_trend.R")

#
#animation.trend.heatmap() %>% render
#anim_save("out.gif")
#
#(animation.trend.heatmap(fill = "log10(rb_battles_sum)",
#                         colors = c(white, red, yellow, green, black), fill.limits = c(2.5, 5.5)) +
#  ggtitle(paste("Heatmap of Battles for", "Ground_vehicles", "{frame_time}", sep = " "))
#) %>% render
#anim_save("out.gif")
#
#(animation.trend.heatmap(fill = "log10(rb_battles_sum)", class.sample = "Aviation",
#                         colors = c(white, red, yellow, green, black), fill.limits = c(2.5, 5.5)) +
#  ggtitle(paste("Heatmap of Battles for", "Aviation", "{frame_time}", sep = " ") +
#  labs())
#) %>% render
#anim_save("out.gif")
#
#animation.trend.heatmap(class.sample = "Aviation",
#                        colors.pos = c(0, 0.05, 0.5, 0.6, 0.7, 0.95, 1.0)) %>% render
#anim_save("out.gif")
#
#static.heatmap(class.sample = "Ground_vehicles", colors.pos = c(0, 0.01, 0.4, 0.5, 0.6, 0.99, 1.0))
#static.heatmap(fill = "rb_battles_sum", fill.limits = c(2.5, 5.5), fill.log = TRUE,
#               class.sample = "Ground_vehicles", colors.pos = c(0, 0.01, 0.4, 0.5, 0.6, 0.99, 1.0))
#static.heatmap(class.sample = "Aviation", colors.pos = c(0, 0.01, 0.5, 0.6, 0.7, 0.99, 1.0))
#static.heatmap(fill = "log10(rb_battles_sum)", fill.limits = c(2.5, 5.5),
#               class.sample = "Aviation", colors.pos = c(0, 0.01, 0.4, 0.5, 0.6, 0.99, 1.0))
#
#trend.nations(class.sample = "Aviation", y = "rb_win_rate", rb_br.sample = "6.3 ~ 7.3")
#
#trend.nations.battles(class.sample = "Aviation", rb_br.sample = "6.3 ~ 7.3")
#
#animation.trend.scatter(x.log = FALSE, x.limits = c(0, 5), y.limits = c(20, 80)) %>% render
#
#trend.vehicles(c("germ_pzkpfw_IV_ausf_G", "germ_pzkpfw_IV_ausf_F2"))
#
#static.scatter("2020-05-21")
#
#static.bars("USA")
#
#animation.trend.bars("USA", y.limits = c(30, 100)) %>% render
