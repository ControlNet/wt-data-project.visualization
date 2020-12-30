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

static.scatter(date.sample = read.csv(cache.all.file.path("rb")) %>% .$date %>% unique %>% .[1],
               class.sample = "Ground_vehicles",
               x = "rb_ground_frags_per_death", y = "rb_win_rate", size = "rb_battles",
               x.limits = NULL, y.limits = NULL, colors = NULL)
ggsave("visualization/imgs/static_scatter_demo.png", width = 7, height = 8, dpi = 75)

static.bars(nation.sample = "USA",
            date.sample = read.csv(cache.all.file.path("rb")) %>% .$date %>% unique %>% .[1],
            class.sample = c("Aviation", "Ground_vehicles"),
            y = "rb_win_rate", y.limits = NULL)
ggsave("visualization/imgs/static_bars_demo.png", width = 7, height = 8, dpi = 75)

animation.trend.heatmap(class.sample = "Ground_vehicles", fill = "rb_win_rate",
                        fill.limits = c(0, 100),
                        colors = c(white, black, red, yellow, green, black, black),
                        colors.pos = c(0, 0.05, 0.4, 0.5, 0.6, 0.95, 1.0)) %>% animation.render
anim_save(filename = "visualization/imgs/animation_trend_heatmap_demo.gif")

