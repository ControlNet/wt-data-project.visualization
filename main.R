source("visualization/utils.R")
source("visualization/static_plot.R")
source("visualization/time_animation.R")
source("visualization/time_trend.R")

static.heatmap.default.ground_vehicles.win_rate()
ggsave("visualization/imgs/static_heatmap_default_demo.png", width = 7, height = 8, dpi = 75)

static.pie.default.battles()
ggsave("visualization/imgs/static_pie_default_battles_demo.png", width = 7, height = 8, dpi = 75)

trend.nations.battles(class.sample = "Ground_vehicles", y = "rb_battles_sum")
ggsave("visualization/imgs/trend_nations_battles_demo.png", width = 7, height = 8, dpi = 75)

static.scatter(date.sample = read.csv(cache.all.file.path) %>% .$date %>% unique %>% .[1],
               class.sample = "Ground_vehicles",
               x = "rb_ground_frags_per_death", y = "rb_win_rate", size = "rb_battles",
               x.limits = NULL, y.limits = NULL, colors = NULL)
ggsave("visualization/imgs/static_scatter_demo.png", width = 7, height = 8, dpi = 75)

static.bars(nation.sample = "USA",
            date.sample = read.csv(cache.all.file.path) %>% .$date %>% unique %>% .[1],
            class.sample = c("Aviation", "Ground_vehicles"),
            y = "rb_win_rate", y.limits = NULL)
ggsave("visualization/imgs/static_bars_demo.png", width = 7, height = 8, dpi = 75)

animation.trend.heatmap(class.sample = "Ground_vehicles", fill = "rb_win_rate",
                        fill.limits = c(0, 100),
                        colors = c(white, black, red, yellow, green, black, black),
                        colors.pos = c(0, 0.05, 0.4, 0.5, 0.6, 0.95, 1.0)) %>% animation.render
anim_save(filename = "visualization/imgs/animation_trend_heatmap_demo.gif")

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
