# WT-DATA-PROJECT.VISUALIZATION
This repo is the visualization part of wt-data-project.

## Data
The data is in this [repo](https://github.com/ControlNet/wt-data-project.data).

To use this visualization repo, you need create a directory like this. The `data` directory contains everything in
the `wt-data-project.data` repo, and the `visualization` directory contains everything in this repo.

```
wt-data-project
├─data
│  ├─joined
│  ├─ts
│  └─wk
└─visualization
```

## Requirements
This repo is written by R 3.6.3. 
Please [download](https://cran.r-project.org/bin/windows/base/old/3.6.3/) R interpreter to use.

Please use code below to install 3rd-party packages.
```r
install.packages("<package name>")
```
 * dplyr
 * ggplot2
 * data.table
 * gganimate
 * gifski
 * ggsci

## Example

There are some default functions for easy use.

**Display the win rates/battles of ground vehicles/aviation for each BR range and nation.**
```r
static.heatmap.default.ground_vehicles.win_rate()
static.heatmap.default.ground_vehicles.battles()
static.heatmap.default.aviation.win_rate()
static.heatmap.default.aviation.battles()
```
![static_heatmap_default_demo](https://github.com/ControlNet/wt-data-project.visualization/blob/master/imgs/static_heatmap_default_demo.png)

**Display a pie chart of the battle counts for each nation**
```r
static.pie.default.battles()
```
![static_pie_default_battles_demo](https://github.com/ControlNet/wt-data-project.visualization/blob/master/imgs/static_pie_default_battles_demo.png)

Except the default functions, there are more functions you can use for visualizations with specified arguments.

For example, you can visualize the trend of battles counts with the code below.
```r
trend.nations.battles(class.sample = "Ground_vehicles", y = "rb_battles_sum", rb_br.sample = "9.7 ~ 10.7")
```
![trend_nations_battles_demo](https://github.com/ControlNet/wt-data-project.visualization/blob/master/imgs/trend_nations_battles_demo.png)

Also, you can plot each vehicle as a scatter.
```r
static.scatter(date.sample = "2020-08-13", class.sample = "Ground_vehicles",
               x = "rb_ground_frags_per_death", y = "rb_win_rate", size = "rb_battles",
               x.limits = NULL, y.limits = NULL, colors = NULL)
```
![static_scatter_demo](https://github.com/ControlNet/wt-data-project.visualization/blob/master/imgs/static_scatter_demo.png)

With the code below, it is a bar chart for a nation in one specific date.
```r
static.bars(nation.sample = "USA",
            date.sample = "2020-08-13",
            class.sample = c("Aviation", "Ground_vehicles"),
            y = "rb_win_rate", y.limits = NULL)
```
![static_bars_demo](https://github.com/ControlNet/wt-data-project.visualization/blob/master/imgs/static_bars_demo.png)

Also, you can make gif animation with these codes below.
```r
animation.trend.heatmap(class.sample = "Ground_vehicles", fill = "rb_win_rate",
                        fill.limits = c(0, 100),
                        colors = c(white, black, red, yellow, green, black, black),
                        colors.pos = c(0, 0.05, 0.4, 0.5, 0.6, 0.95, 1.0)) %>% render

# if you need save as a file
anim_save(filename = "out.gif")
```
![animation_trend_heatmap_demo](https://github.com/ControlNet/wt-data-project.visualization/blob/master/imgs/animation_trend_heatmap_demo.gif)

