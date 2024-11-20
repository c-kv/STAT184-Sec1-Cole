library(ggplot2)
library(tidyverse)

diamonds <- ggplot2::diamonds

diamonds %>%
  ggplot(aes(x = x, y = price)) +
  geom_point(color = "blue", size = 2.0) +
  labs(title = "Length vs Price", 
       x = "Length (mm)", 
       y = "Price ($USD)")

diamonds %>%
  ggplot(aes(x = x, y = price, color = color, size = cut)) +
    geom_point(alpha = 0.5) +
    scale_size_manual(values = c(Fair = 1.0, Good = 1.4, 'Very Good' = 1.8, Premium = 2.2, Ideal = 2.6)) + 
    labs(title = expression(bold("Influence of Length, Color, and Cut Quality on Diamond Price")), 
         x = expression(bold("Length (mm)")), 
         y = expression(bold("Price ($USD)")), 
         color = expression(bold("Color")), 
         size = expression(bold("Cut Quality"))) + 
    theme_linedraw()

penguins <- palmerpenguins::penguins

penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = sex, facet)) +
  geom_point(alpha = 0.8, size = 1.0) +
  facet_wrap(~ species) + 
  labs(
    title = "Relationship Between Flipper Length and Body Mass in Different Penguin Species by Sex",
    x = "Flipper Length (mm)",
    y = "Body Mass (g)",
    color = "Sex"
  ) + 
  theme_linedraw()

penguins %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = sex, facet)) +
    geom_point(size = 3.0) +
    scale_color_manual(
      values = c("male" = "blue", "female" = "pink"),
      labels = c("female" = "Female", "male" = "Male")) +
    facet_wrap(~ species) + 
    labs(
      title = expression(bold("Relationship Between Flipper Length and Body Mass in Different Penguin Species by Sex")),
      x = expression(bold("Flipper Length (mm)")),
      y = expression(bold("Body Mass (g)")),
      color = expression(bold("Sex"))
    ) + 
    theme_bw() +
    theme(
      strip.text = element_text(face = "bold"),
      strip.background = element_rect(fill = "white", color = 'black' )
    )


babynames <- dcData::BabyNames
babynames <- babynames %>%
  filter(name %in% c("Cole", "Luke", "Matthew")) %>%
  filter(sex == "M")

babynames %>%
  ggplot(aes(x = year, y = count, color = name, group = name)) +
  geom_line() + 
  labs(title = "Popularity of the Names 'Cole', 'Luke', and 'Matthew' Over Time",
       x = "Year",
       y = "Number of Male Babies given Name",
       color = "Name")

babynames %>%
  ggplot(aes(x = year, y = count, color = name, group = name)) +
    geom_line(size = 1.5) + 
    scale_x_continuous(
      limits = c(1945, NA),
      breaks = seq(1945, 2013, by = 10)
    ) +
    labs(title = expression(bold("Popularity of the Names 'Cole', 'Luke', and 'Matthew' Over Time")),
         x = expression(bold("Year")),
         y = expression(bold("Number of Male Babies Given Name")),
         color = expression(bold("Name"))) +
    theme_linedraw()

