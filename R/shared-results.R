# Shared results used by both Chapters/Chapter2.qmd and slides.qmd.
# Keeping the data and plotting code in one place guarantees the thesis
# and the defense deck always show the same figure and table.

example_data <- function() {
  set.seed(2026)
  data.frame(
    group = rep(c("Control", "Intervention"), each = 30),
    outcome = c(rnorm(30, mean = 10, sd = 2), rnorm(30, mean = 12.5, sd = 2))
  )
}

example_plot <- function() {
  d <- example_data()
  boxplot(
    outcome ~ group,
    data = d,
    col = c("#F7E6E7", "#DA2025"),
    border = "#A41D21",
    xlab = "",
    ylab = "Primary outcome",
    las = 1
  )
}

example_table <- function() {
  d <- example_data()
  agg <- aggregate(outcome ~ group, data = d, FUN = function(x) {
    c(n = length(x), mean = mean(x), sd = sd(x))
  })
  out <- do.call(data.frame, agg)
  names(out) <- c("Group", "N", "Mean", "SD")
  out$N <- round(out$N)
  out$Mean <- round(out$Mean, 2)
  out$SD <- round(out$SD, 2)
  out
}
