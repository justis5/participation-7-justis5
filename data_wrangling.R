source("sports_api_access.R")
library(httr)

library(jsonlite)
install.packages("devtools")
devtools::install_github("MySportsFeeds/mysportsfeeds-r")
library(mysportsfeedsR)
authenticate_v1_x(username = username, password = password)
library(dplyr)
library(ggplot2)
library(stringr)

gamelogs <- msf_get_results(version = '1.2',
                            league='nba',
                            season='2017-2018-regular',
                            feed = "player_gamelogs",
                            params = list(player='james-harden'))
player_df <- gamelogs$api_json$playergamelogs$gamelogs
team_name = names(
  sort(
    summary(
      as.factor(player_df$game.homeTeam.Name)
    )
  , decreasing = T)[1]
  
)
home <- player_df %>% 
  filter(game.homeTeam.Name == team_name) %>% 
  mutate(court = "Home") %>% 
  mutate(opponent = paste(game.awayTeam.City, game.awayTeam.Name))
away <- player_df %>% 
  filter(game.homeTeam.Name != team_name) %>% 
  mutate(court  = "Away") %>% 
  mutate(opponent = paste(game.homeTeam.City, game.homeTeam.Name))
player_df <- rbind(home, away)


game_data <- player_df[c(214, 215, 1:4, 14:15)]
index <- seq(24, 213, 3)
index <- c(1, index)
stats <- player_df[index]
stats[] <- lapply(stats, function(x) as.numeric(as.character(x)))
colnames(stats) <- gsub("stats.", "", colnames(stats))
colnames(stats) <- gsub(".text", "", colnames(stats))
stats$game.id <- as.character(stats$game.id)
joined_data <- left_join(game_data, stats)
write.csv(joined_data, "data/james_harden.csv", row.names = FALSE)
