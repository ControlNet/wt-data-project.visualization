library(dplyr)
library(ggplot2)
library(reshape2)
source("visualization/utils.R")

static.heatmap <- function(date.sample = data$date %>% unique %>% .[1],
                           date.compare = data$date %>% unique %>% .[3],
                           class.sample = "Ground_vehicles",
                           mode = "rb",
                           fill = "rb_win_rate",
                           fill.limits = c(0, 100),
                           fill.log = FALSE,
                           colors = c(white, black, red, yellow, green, black, black),
                           colors.pos = c(0, 0.05, 0.4, 0.5, 0.6, 0.95, 1.0)) {
  # read the data generated by function cache_br_flat_df in stat_utils/concator.py
  data <- read.csv(cache.1.file.path(mode))
  # filter the data
  data.sample <- eval(parse(text = paste0("data %>%
    filter(cls == class.sample) %>%
    mutate(", mode, "_lower_br = ", mode, "_lower_br %>% as.factor)")))
  # select two date for compare
  data.now <- data.sample %>% filter(date == date.sample)

  # calculate trend
  if (!is.null(date.compare)) {
    data.before <- data.sample %>% filter(date == date.compare)
    # calculate trend
    data.trend <- eval(parse(text = paste0("data.now %>%
      select(nation, paste0(mode, \"_lower_br\"), fill) %>%
      merge(data.before %>% select(nation, paste0(mode, \"_lower_br\"), fill),
            by = c(\"nation\", paste0(mode, \"_lower_br\")), all.x = TRUE) %>%
      mutate(trend.up = .[, 3] > .[, 4]) %>%
      mutate(trend.down = .[, 3] < .[, 4]) %>%
      mutate(x = match(nation, nation_order),
             y = match(", mode, "_lower_br, data.now$", mode, "_lower_br %>% unique))")))

    data.trend.up <- data.trend %>% filter(trend.up) %>% select(x, y)
    data.trend.down <- data.trend %>%
      filter(trend.down) %>%
      select(x, y)
  }

  if (fill.log)
    fill <- paste0("log10(", fill, ")")

  # plot
  p <- data.now %>% ggplot +
    geom_tile(aes_string(x = "nation", y = paste0(mode, "_lower_br"), fill = fill), color = "black") +
    scale_fill_gradientn(colors = colors, values = colors.pos, limits = fill.limits) +
    scale_y_discrete(labels = data.now[paste0(mode, "_br")] %>%
      unique %>%
      unlist %>%
      as.character) +
    scale_x_discrete(limits = nation_order) +
    ggtitle(paste("Heatmap of", fill, "for", class.sample, date.sample, sep = " ")) +
    labs(x = "Nation", y = "Battle Rating",
         caption = "Repo: ControlNet/wt-data-project.visualization, Source: Thunderskill")

  if (!is.null(date.compare)) {
    p +
      annotate("point", x = data.trend.up$x, y = data.trend.up$y, shape = 24, fill = green, size = 1.5) +
      annotate("point", x = data.trend.down$x, y = data.trend.down$y, shape = 25, fill = red, size = 1.5)
  } else p
}

static.heatmap.default.ground_vehicles.win_rate <- function() static.heatmap()

static.heatmap.default.ground_vehicles.battles <- function()
  static.heatmap(fill = "rb_battles_sum", fill.limits = c(2.5, 5.5), fill.log = TRUE,
                 class.sample = "Ground_vehicles", colors.pos = c(0, 0.01, 0.4, 0.5, 0.6, 0.99, 1.0))

static.heatmap.default.aviation.win_rate <- function()
  static.heatmap(class.sample = "Aviation", colors.pos = c(0, 0.01, 0.5, 0.6, 0.7, 0.99, 1.0))

static.heatmap.default.aviation.battles <- function()
  static.heatmap(fill = "rb_battles_sum", fill.limits = c(2.5, 5.5), fill.log = TRUE,
                 class.sample = "Aviation", colors.pos = c(0, 0.01, 0.4, 0.5, 0.6, 0.99, 1.0))

static.scatter <- function(date.sample, class.sample = "Ground_vehicles",
                           x = "rb_ground_frags_per_death", y = "rb_win_rate", size = "rb_battles",
                           x.limits = NULL, y.limits = NULL, colors = NULL, threshold = 0) {
  # read the ts data with specified date
  data <- paste0(joined.dir.path, "/", date.sample, ".csv") %>% read.csv
  # filter the class
  data.sample <- data %>% filter(cls == class.sample)
  # filter the vehicle with few battles
  data.sample <- data.sample[data.sample[size] > threshold,]

  # plot
  p <- data.sample %>% ggplot +
    geom_point(aes_string(x = x, y = y, color = "nation", size = size)) +
    scale_x_log10() +
    ggtitle(paste("The scatter of vehicles in", date.sample, sep = " ")) +
    labs(caption = "Repo: ControlNet/wt-data-project.visualization, Source: Thunderskill")
  if (!is.null(x.limits)) p <- p + xlim(x.limits)
  if (!is.null(y.limits)) p <- p + ylim(y.limits)
  if (!is.null(colors)) p <- p + scale_color_manual(values = colors)
  p
}

static.bars <- function(nation.sample,
                        date.sample = data$date %>% unique %>% .[1],
                        class.sample = c("Aviation", "Ground_vehicles"),
                        y = "rb_win_rate", y.limits = NULL, mode = "rb") {
  # read data
  data <- read.csv(cache.1.file.path(mode))
  data <- data %>%
    mutate(rb_lower_br = rb_lower_br %>% as.factor) %>%
    filter(date == date.sample) %>%
    filter(nation == nation.sample) %>%
    filter(cls %in% class.sample)

  # plot
  p <- data %>% ggplot +
    geom_bar(aes_string(x = "rb_lower_br", y = y, fill = "cls"), stat = "identity", position = position_dodge()) +
    coord_flip(ylim = y.limits) +
    scale_x_discrete(labels = data$rb_br) +
    ggtitle(paste("Bar Chart for", paste(class.sample, collapse = " and "),
                  "of", nation.sample, date.sample, sep = " ")) +
    labs(caption = "Repo: ControlNet/wt-data-project.visualization, Source: Thunderskill", x = "Battle Rating")
  p
}

static.bars.modes.battles <- function(date.sample = NULL,
                                      class.sample = c("Aviation", "Ground_vehicles"),
                                      y.limits = NULL) {
  # read joined data
  if (is.null(date.sample)) {
    date.sample <- cache.1.file.path(mode) %>%
      read.csv %>%
      .$date %>%
      unique %>%
      .[1]
  }

  data <- paste0(joined.dir.path, "/", date.sample, ".csv") %>% read.csv
  data <- data %>%
    filter(cls %in% class.sample)

  # remove NA values
  for (col in c("ab_battles", "rb_battles", "sb_battles")) {
    data[is.na(data[col]),][col] <- 0
  }

  data.group <- data %>%
    select(nation, ab_battles, rb_battles, sb_battles) %>%
    group_by(nation) %>%
    summarise(ab = sum(ab_battles),
              rb = sum(rb_battles),
              sb = sum(sb_battles)) %>%
    mutate(nation = nation %>% factor(
      levels = nation_order)
    )

  data.group %>%
    melt(id.vars = "nation") %>%
    ggplot +
    geom_bar(aes(fill = nation, y = value, x = variable), position = "stack", stat = "identity") +
    labs(title = paste("Stacked Bar Chart for Battles of", paste(class.sample, collapse = " and "), sep = " "),
         caption = "Repo: ControlNet/wt-data-project.visualization, Source: Thunderskill",
         x = "Mode",
         y = "Battles",
         fill = "Nation"
    ) +
    scale_fill_manual(values = c(red, blue, green, gray, purple, indigo, yellow, orange, brown)) +
    scale_x_discrete(labels = c("AB", "RB", "SB"))

}

static.pie.battles <- function(date.sample,
                               class.sample = c("Aviation", "Ground_vehicles"),
                               mode = "rb",
                               colors = NULL) {
  # read joined data
  data <- paste0(joined.dir.path, "/", date.sample, ".csv") %>% read.csv
  data <- data %>%
    filter(cls %in% class.sample)

  battle.colname <- paste0(mode, "_battles")
  battle.sum.colname <- paste0(battle.colname, "_sum")
  # remove NA values
  data[is.na(data[battle.colname]),][battle.colname] <- 0
  # group and calculate the battles sum for each nation
  data.nation <- eval(parse(text = paste0("data %>%
    group_by(nation) %>%
    summarise(!!battle.sum.colname := sum(", battle.colname, "))")))

  # plot
  p <- data.nation %>% ggplot +
    geom_bar(aes_string(x = "\"\"", y = battle.sum.colname, fill = "nation"), stat = "identity") +
    coord_polar("y", start = 0) +
    labs(title = paste("Pie Chart for", toupper(mode), "Battles of", paste(class.sample, collapse = " and "),
                       "in", date.sample, sep = " "),
         caption = "Repo: ControlNet/wt-data-project.visualization, Source: Thunderskill",
         x = NULL,
         y = "Battles",
         fill = "Nation"
    ) +
    theme(axis.text.y = element_blank(), axis.line.y = element_blank(), axis.ticks.y = element_blank())

  if (!is.null(colors)) p <- p + scale_fill_manual(values = colors)
  p
}

static.pie.default.battles <- function(mode = "rb") {
  # read the nearest date
  data <- read.csv(cache.1.file.path(mode))
  date.sample <- data$date %>% unique %>% .[1]
  # plot pie chart
  static.pie.battles(date.sample, mode = mode,
                     colors = c(blue, orange, indigo, black, green, purple, yellow, brown, red))
}