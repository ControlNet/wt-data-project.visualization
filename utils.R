library(ggsci)

cache.all.file.path <- function(mode) {
  paste0("data/", mode, "_ranks_all.csv")
}
cache.1.file.path <- function(mode) {
  paste0("data/", mode, "_ranks_1.csv")
}
cache.0.file.path <- function(mode) {
  paste0("data/", mode, "_ranks_0.csv")
}
joined.dir.path <- "data/joined"
ts.dir.path <- "data/ts"
wk.dir.path <- "data/wk"

# material colors
get_material_color <- function(color, n = 6) pal_material(color)(10)[n]
blue <- get_material_color("blue")
purple <- get_material_color("purple")
red <- get_material_color("red")
indigo <- get_material_color("indigo")
green <- get_material_color("green")
yellow <- get_material_color("yellow")
gray <- get_material_color("grey")
orange <- get_material_color("orange")
brown <- get_material_color("brown")
white <- "white"
black <- "black"

# Nation order
nation_order <- c("USA", "Germany", "USSR", "Britain", "Japan",
                  "France", "Italy", "China", "Sweden")
