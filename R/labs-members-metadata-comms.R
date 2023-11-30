# MSB Labs scrape to table
# Simon Dedman, simondedman@gmail.com
# 2023-11-19. Bard Ai test.
# Goal: make a table of people in the various labs, alumni status, slack/whatsapp group presence.

# https://bard.google.com/chat/223411e2e7fb0afc
# Scrape Mike Lab####
# Install and load the rvest package
install.packages("rvest")
library(rvest)

# Scrape the first web page
url1 <- "https://mikeheithaus.com/research/lab/"
html <- read_html(url1)

# Get the headings and subheadings
headings <- html %>%
  html_nodes(".site-main h2") %>%
  html_text()

# Create a data frame with the headings and subheadings
data <- data.frame(headings, stringsAsFactors = FALSE)

# Save the data frame to a Google Sheet
gsheet <- gs_new()
gs_assign(data, gsheet, "Lab Members")
# https://docs.google.com/spreadsheets/d/1ul1pEO4tiK0bGxs0BJf7QswqxkERcWKwoN381W53rvQ/edit#gid=1663073386






# Scrape Yannis Demian PEC Lab####
url2 <- "https://www.peclabfiu.com/team"
html <- read_html(url2)

# Get the people and their statuses
people <- html %>%
  html_nodes(".site-main .member h3") %>%
  html_text()

statuses <- html %>%
  html_nodes(".site-main .member .status") %>%
  html_text()

# Create a data frame with the people and their statuses
data <- data.frame(people, statuses, stringsAsFactors = FALSE)

# Add a new column called "Yannis Demian Lab" and make all values True
data$Yannis_Demian_Lab <- TRUE

# Add a new column called "Active" and make all values True unless status is alumni or alumnus
data$Active <- ifelse(grepl("alumni", statuses, ignore.case = TRUE), FALSE, TRUE)

# Save the data frame to a Google Sheet
gsheet <- gs_new() # needs googlesheets package, not 4
gs_assign(data, gsheet, "Team Members")
# https://docs.google.com/spreadsheets/d/1QWvSRAiXuTwr6Jgfg4mpF45y0mHcP5egWoIjDUHpmr8/edit#gid=980322418
#2023-11-19 13:22 CODE ABOVE NOT TESTED####




# Import sheets####
# Install and load the googlesheets4 package
install.packages("googlesheets4")
library(googlesheets4)
library(googlesheets4)
library(dplyr)

# Import the first spreadsheet
mike_lab <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1ul1pEO4tiK0bGxs0BJf7QswqxkERcWKwoN381W53rvQ/edit#gid=1663073386") |>
  dplyr::rename(People = "Name",
                Status = "Title",
                Mike = "Mike lab") |> 
  # Remove the "Dr. " prefix from the People column
  dplyr::mutate(People = gsub("^Dr. ", "", People))

# Import the second spreadsheet
yannis_lab <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1QWvSRAiXuTwr6Jgfg4mpF45y0mHcP5egWoIjDUHpmr8/edit#gid=980322418") |> 
  dplyr::rename(YannisDemian = "Yannis Demian Lab") |> 
  # Remove the "Dr. " prefix from the People column
  dplyr::mutate(People = gsub("^Dr. ", "", People))

library(purrr)
# Join Merge ####
labs_members <- mike_lab %>%
  dplyr::full_join(yannis_lab, by = "People") 

# Fix conflicting column name Active
labs_members$Active <- apply(labs_members[c("Active.x", "Active.y")], 1, any)

# Fix conflicting column name Status
labs_members$Status <- ifelse(!is.na(labs_members$Status.x), labs_members$Status.x,
                              ifelse(!is.na(labs_members$Status.y), labs_members$Status.y, NA)
)

library(magrittr)

# Remove .x .y columns
labs_members %<>%
  # labs_members %<>% select(all_of(!Status.x, !Status.y, !Active.x, !Active.y))
  select(!ends_with(c(".x", ".y"))) %>% # can't use |>  in magrittr pipe
  # Make all logical column NAs values, FALSEs
  dplyr::mutate(across(where(is.logical), ~ ifelse(is.na(.), FALSE, .))) %>%
  # Add Slack/Whatsapp columns
  dplyr::mutate(Slack_Mike = as.logical(vector(length = nrow(labs_members))),
                WhatsappFood = as.logical(vector(length = nrow(labs_members))),
                WhatsappJiu = as.logical(vector(length = nrow(labs_members))))

# create vectors of People in those social media groups
Slack_Mike = c("Aloyse Abreu", "Bradley Strickland", "Brendan Talwar", "Camila Cáceres",
               "Simon Dedman", "Courtney Knauer", "Davon Strickland", "Erin Johnson", "Hannah Mayers",
               "Ivan Drago", "James Kilfoil", "Jeremy Kiszka", "Jessica Carde", "Kristine Zikmanis",
               "Laura García Barcia", "Liberty Boyd", "Mark Bond", "Matt Shirley", "Mike Heithaus",
               "Frances Farabaugh", "Nicole Danaher-Garcia", "Paulo Braga",  "Rik Bonnema",
               "Vincent Quiquempois", "William Sample")

WhatsappFood = c("Simon Dedman", "Candace Fields", "Cindy Gonzalez", "Courtney Knauer",
                 "Devanshi Kasana", "Diego Cardeñosa", "Erin Spencer", "Gina Clementi",
                 "Kathryn Flowers", "Maurits van Zinnicq Bergmann", "Megan Kelley", "Sara Schoen",
                 "Sarah Luongo")

WhatsappJiu = c("Candace Fields", "Simon Dedman", "Erin Spencer", "Maurits van Zinnicq Bergmann",
                "Megan Kelley", "Sarah Luongo", "Yannis Papastamatiou", "Gabriela Ochoa", "Rainer Moy-Huwyler")
# index df rows where names match, populate for that labs column
labs_members$Slack_Mike[which(labs_members$People %in% Slack_Mike)] <- TRUE
labs_members$WhatsappFood[which(labs_members$People %in% WhatsappFood)] <- TRUE
labs_members$WhatsappJiu[which(labs_members$People %in% WhatsappJiu)] <- TRUE

# Check all names joined
length(which(labs_members$WhatsappFood)) == length(WhatsappFood)
WhatsappFood[which(!labs_members$People %in% WhatsappFood)]

# if any people in groups aren't in the master list
if (!all(Slack_Mike %in% labs_members$People)) {
  # add them to the masterlist
  # Manually label status & lab
  Slack_Mike <- data.frame(
    People = Slack_Mike[which(!Slack_Mike %in% labs_members$People)],
    Mike = as.logical(TRUE),
    YannisDemian = as.logical(FALSE),
    Active = as.logical(c(TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE,
                          TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE)),
    Status = as.character(c("Ph.D. Student", "Ph.D. Student", "Ph.D. Student", "Ph.D. Student",
                            "Ph.D. Student", "Ph.D. Student", "Postdoctoral Scientist", "Ph.D. Student",
                            "Ph.D. Student", "Postdoctoral Scientist", "Ph.D. Student", "Ph.D. Student",
                            "Ph.D. Student", "Ph.D. Student", "Ph.D. Student")),
    Slack_Mike = as.logical(TRUE),
    WhatsappFood = as.logical(FALSE),
    WhatsappJiu = as.logical(FALSE)
  )
  labs_members %<>% bind_rows(Slack_Mike)
}
# No absentees from Whatsapp groups

# Sort by Active then People
labs_members %<>% dplyr::arrange(desc(Active), People)

# Rearrange columns
labs_members %<>% dplyr::select(People, Status, Active, everything())

# Remove social columns before displau
labs_members %<>% dplyr::select(People:YannisDemian)

# Manually override active status for known but not webpage updated alumni

# Convert to Quarto
# I pasted this into Bard and asked it to convert but it gives all its results in markdown format within bard, not a single docutment.

# Publish to Github lab docs as quarto embedded table.

# Todo: add Al Harborne, Kiszka, other labs