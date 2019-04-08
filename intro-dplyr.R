#Intro to dplyr
library(dplyr)

# load gapminder data as sample dataset
gapminder <- read.csv("data/gapminder_data.csv",
                      stringsAsFactors = F)

gapminder$continent <- as.factor(gapminder$continent)
gapminder$continent <- as.character(gapminder$continent)

#base r mean
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])

#This is a pipe %>%
# Functions we will learn todayf rom dplyr:
# 1. select()
# 2. filter()
# 3. group_by()
# 4. summarize()
# 5. mutate()

# what attributes in gapminder:
colnames(gapminder)
#select three attributes from gapminder
subset_1 <- gapminder %>%
  select(country, continent,lifeExp)

#select every attribute except 2
subset_2 <- gapminder %>%
  select(-lifeExp,-pop)
str(subset_2)

#select some attributes but rename a few of them for clarity
subset_3 <- gapminder %>%
  select(country, population = pop, lifeExp, gdp = gdpPercap)
str(subset_3)

# using filter()
africa <- gapminder %>%
  filter(continent == "Africa") %>%
  select(country,population = pop, lifeExp)
table(africa$country)

# select year, population, country, for Europe
europe <- gapminder %>%
  filter(continet == "Europe") %>%
  select(year,population = pop, country)
europe_table <- table(europe$country)
View(europe_table)

# working with group_by() & summarize ()
str(gapminder %>% group_by(continent))

# summarize mean gdp per continent
gdp_continent <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdp = mean(gdpPercap))

# Mean pop for all continents
pop_continent <- gapminder %>%
  group_by(continent) %>%
  summarize (mean_pop = mean(pop))
View(pop_continent)

# count () and n()
gapminder %>%
  filter (year == 2002) %>%
  count(continent, sort= TRUE)

gapminder %>%
  group_by(continent) %>%
  summarize (se = sd(lifeExp/sqrt(n())))

# mutate () is my friend
xy <- data.frame(x = rnorm(100),
                 y = rnorm(100))
head(xy)
xyz <- xy %>%
  mutate(z = x*y)
head(xyz)


# add a column that give full gdp per continent
gdp_per_cont <- gapminder %>%
  mutate(gdp_country= gdpPercap*pop) %>%
  group_by(continent) %>%
  summarize(gdp.continent = sum(gdp_country))
View(gdp_per_cont)
