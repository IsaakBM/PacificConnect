
sol3a <- lapply(readRDS("Prioritisation/Solutions/03b_SolutionsIUCNMicoLong.rds"), function(x) x %>% dplyr::select(cellsID, solution_1))
gg_list <- vector("list", length = length(sol3a))  
for(i in seq_along(sol3a)) {
  sol <- sol3a[[i]]
  st_crs(sol) <- "+proj=robin +lon_0=180 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
  trg <- seq(10, 90, 10)
  # Color Palette, World borders and Legend
  pal <- c("#deebf7", "#31a354")
  type <- c("NO", "YES")
  # Plotting
  gg_list[[i]] <- ggplot() +
    geom_sf(data = sol, aes(group = as.factor(solution_1), fill = as.factor(solution_1)), color = NA) +
    geom_sf(data = mpas, color = "#fed976", fill = "#fed976") +
    geom_sf(data = world_robinson, size = 0.05, fill = "grey20") +
    coord_sf(xlim = c(st_bbox(sol3a[[1]])$xmin, st_bbox(sol3a[[1]])$xmax),
             ylim = c(st_bbox(sol3a[[1]])$ymin, st_bbox(sol3a[[1]])$ymax),
             expand = TRUE) +
    theme_bw() +
    scale_fill_manual(values = pal,
                      name = "",
                      labels = type) +
    theme(legend.title = element_text(angle = -90, size = rel(2.5)),
          plot.title = element_text(face = "plain", size = 22, hjust = 0.5),
          axis.text.x = element_text(size = rel(2), angle = 0),
          axis.text.y = element_text(size = rel(2), angle = 0),
          axis.title = element_blank()) +
    ggtitle(paste0(trg[i], "%"))
}

p1 <- patchwork::wrap_plots(gg_list, ncol = 3, byrow = TRUE) +
  plot_layout(guides = "collect")
  
ggsave("Figures/03b_SolutionsIUCNMicoLong.pdf", plot = p1, width = 22, height = 15, dpi = 300)

