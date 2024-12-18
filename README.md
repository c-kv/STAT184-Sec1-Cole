# STAT 184 Activity 12
This repository contains the work I completed for Activity 9 for STAT 184. This activity involved building data visualizations using the `ggplot2` library in R. In this activity, I worked with three datasets:
1. `ggplot2::diamonds` A [datatset](https://ggplot2.tidyverse.org/reference/diamonds.html) containing the prices and other attributes for almost 54,000 diamonds.
2. `palmerpenguins::penguins` A [dataset](https://allisonhorst.github.io/palmerpenguins/) containing species, island, and other attributes for 344 penguins.
3. `dcData::BabyNames` A [dataset](https://github.com/mdbeckman/dcData) containing frequencies of baby names, and other attributes for U.S. baby names in a given year with at least 5 occurences.
## Implementation
This section provides an overview of the code used to create data visualizations in R using `ggplot2` and `tidyverse`.
### Installations
The following R packages must be installed:
- `ggplot2`: for creating data visualizations and the diamonds dataset.
- `tidyverse`: for data wrangling.
- `palmerpenguins`: for the penguins dataset.
- `dcData`: for the baby names dataset.
These packages can be installed using the following code:
```R
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("palmerpenguins")
install.packages("dcData")
```
### Diamond Price Analysis
This section will focus on the visualizations created from the `diamonds` dataset.

A scatterplot is created using `ggplot()` with the `aes()` parameter and `geom_point()` option. A scatterplot is used to visualize the relationship between diamond length `x` and price `price`. Points are colored blue, and titles and axis labels are added using `labs()`.
```R
diamonds %>%
  ggplot(aes(x = x, y = price)) +
  geom_point(color = "blue", size = 2.0) +
  labs(title = "Length vs Price", 
       x = "Length (mm)", 
       y = "Price ($USD)")
```
This scatterplot incorporates the color `color` and cut `cut` attributes into the previous scatterplot to show their influence on diamond price `price`. Custom themes, labeling, and size scales are applied using `expression(bold())`, `scale_size_manual()`, and `theme_linedraw()`.
```R
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
```
### Penguin Analysis
This section will focus on the visualizations created from the `penguins` dataset.

The `penguins` dataset is used to create side-by-side scatterplots using `ggplot()` with the `aes()` parameter and `geom_point()` and `facet_wrap()` options. These side-by-side scatterplots are used to analyze the relationship between flipper length `flipper_length_mm` and body mass `body_mass_g` grouped by species `species` and sex `sex`.
```R
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
```
This plot shows the same information as the previous plot, but improves it by filtering out `NA` values using `filter(!is.na())` and increasing overall readability with `expression(bold())`, `theme_bw()`, and `theme()`.
```R
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
```
### Baby Name Popularity Analysis
This section will focus on the visualizations created from the `babynames` dataset.

First, the dataset is wrangled using `filter()` to only focus on the male names "Cole", "Luke", and "Matthew".
```R
babynames <- babynames %>%
  filter(name %in% c("Cole", "Luke", "Matthew")) %>%
  filter(sex == "M")
```
The `babynames` dataset is used to create a line graph using `ggplot()` with the `aes()` parameter and `geom_line()` option. This line graph is used to visualize the popularity `count` of the names `name` represented by the color of the line over time `year`. This first plot will show raw data.
```R
babynames %>%
  ggplot(aes(x = year, y = count, color = name, group = name)) +
  geom_line() + 
  labs(title = "Popularity of the Names 'Cole', 'Luke', and 'Matthew' Over Time",
       x = "Year",
       y = "Number of Male Babies given Name",
       color = "Name")
```
This second plot improves upon the previous plot by limiting the axis values to show only significant time periods with `scale_x_continuous()` with the `limits` and `breaks` parameters. This plot also applyies some extra formatting options using `expression(bold())` and `theme_linedraw()`.
```R
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
```
## Results
This section summarizes the visulizations generated by the code and highlights key trends observed in the datasets.

### Diamonds Dataset

**Figure 1: Length vs Price**

![alt text](images/Rplot.png)

This scatterplot shows the relationship between diamond length (mm) and price (USD). We can see that as the length of the diamond increases, the price of the diamond increases exponentially.

**Figure 2: Influence of Length, Color, and Cut Quality on Price**

![alt text](images/Rplot01.png)

This scatterplot shows how diamond length (mm), color, and cut quality impact the diamond's price (USD). We can see that as length of the diamond increase, the price of the diamond increases exponentially. Generally, better cut quality correlates with higher price. We can also see that the higher the color on the color scale, the more expensive the diamond is.

### Penguins Dataset

**Figure 3: Flipper Length vs Body Mass by Species and Sex**

![alt text](images/Rplot02.png)

These scatterplots show how flipper length (mm), species, and sex impact the penguin's body mass (g). We can see that as flipper length increases, so does body mass. Female penguins tend to have smaller body mass compared to their male counterparts. Penguins of the Gentoo species tend to have a higher body mass than Adelie penguins or Chinstrap penguins, both of which have similar body mass on average.

**Figure 4: Enhanced Flipper Length vs Body Mass by Species and Sex**

![alt text](images/Rplot03.png)

This scatterplot is an improved version of the previous figure, showing how flipper length (mm), species, and sex impact a penguin's body mass (g). This plot enchances readability with improved formatting options.

### Baby Names Dataset

**Figure 5: Popularity of 'Cole', 'Luke', 'Matthew' Over Time**

![alt text](images/Rplot04.png)

This line graph gauges the popularity of the baby names 'Cole', 'Luke', and 'Matthew' by plotting the frequency of these names over time. We can see a sharp increase in the name "Matthew" starting around 1950 before peaking around 1980. "Luke" started gaining traction around 1980 and has continually risen since then. "Cole" started with a steady increase around 1990 before peaking in the early 2000s and declining slightly since.

**Figure 6: Enhanced Popularity Trends**

![alt text](images/Rplot05.png)

This line graph is an improved version of the previous figure by gauging the popularity of the baby names 'Cole', 'Luke', and 'Matthew' by plotting the frequency of these names over time. This plot enhances the readability by limiting the x-axis to only show significant time periods and improving on formatting choices.

### Reflection

Overall, this activity taught me how to use the `ggplot2` R package to create effective data visualizations. Also, this activity has taught me how to improve on previous data visualizations to either enhance the content being presented or enhance aesthetics.

## Contact
Please send any questions, comments, or inquiries to cjk6379@psu.edu.
