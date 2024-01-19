# reddit_word_cloud.R
# This script fetches Reddit thread titles based on a keyword and generates a word cloud.

# Load necessary libraries
if (!require("RedditExtractoR")) install.packages("RedditExtractoR")
if (!require("tm")) install.packages("tm")
if (!require("wordcloud")) install.packages("wordcloud")
if (!require("ggplot2")) install.packages("ggplot2")
library(RedditExtractoR)
library(tm)
library(wordcloud)
library(ggplot2)

# Function to clean and preprocess text
clean_text <- function(text) {
  text %>%
    tolower() %>%
    removePunctuation() %>%
    removeNumbers() %>%
    stripWhitespace() %>%
    removeWords(stopwords("en"))
}

# Fetch thread URLs based on a keyword
fetch_threads <- function(keyword, period = "month", sort_by = "top") {
  thread_urls <- find_thread_urls(keywords = keyword, sort_by = sort_by, period = period)
  return(thread_urls)
}

# Generate a word cloud from text
generate_word_cloud <- function(text) {
  wordcloud(words = text, max.words = 100, random.order = FALSE, colors=brewer.pal(8, "Dark2"))
}

# Main execution function
main <- function() {
  keyword <- "YourKeyword"  # Replace with your keyword
  
  # Fetch thread URLs
  thread_urls <- fetch_threads(keyword)
  
  # Extract and clean thread titles
  thread_titles <- thread_urls$title
  clean_titles <- clean_text(thread_titles)
  
  # Generate and plot word cloud
  generate_word_cloud(clean_titles)
}

# Run the main function
main()
