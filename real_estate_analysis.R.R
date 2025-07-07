# Load required libraries
library(dplyr)       # for data manipulation
library(tidyr)       # for data tidying
library(stringr)     # for string manipulation
library(ggplot2)     # for data visualization
library(scales)      # for formatting scales on plots

# Load the dataset
real_estate <- read.csv("Real_Estate_Sales_2001-2022_GL.csv", stringsAsFactors = FALSE)

# Preview structure and summary
str(real_estate)                      # structure of the dataset
summary(real_estate)                 # basic statistics for each column

# Convert 'Date.Recorded' column to Date format
real_estate$Date.Recorded <- as.Date(real_estate$Date.Recorded, format = "%m/%d/%Y")

# Extract year from 'Date.Recorded'
real_estate$Year <- as.numeric(format(real_estate$Date.Recorded, "%Y"))

# Check for missing values
colSums(is.na(real_estate))

# Explore important numeric columns
summary(real_estate$Assessed.Value)
summary(real_estate$Sale.Amount)
summary(real_estate$Sales.Ratio)

# Initial cleaning: remove records with 0 or NA in key columns
real_estate_clean <- real_estate %>%
  filter(Sale.Amount > 0, Assessed.Value > 0, !is.na(Sale.Amount), !is.na(Assessed.Value))

# Extract latitude and longitude from 'Location' column
real_estate_clean <- real_estate_clean %>%
  mutate(
    Location = str_replace_all(Location, "POINT \\(|\\)", ""),
    Longitude = as.numeric(str_extract(Location, "[-]?\\d+\\.\\d+")),
    Latitude = as.numeric(str_extract(Location, "(?<= )[-]?\\d+\\.\\d+"))
  )

# Further clean data to exclude invalid sales ratios and missing dates/years
real_estate_clean2 <- real_estate_clean %>%
  filter(
    !is.na(Date.Recorded),
    !is.na(Year),
    Sales.Ratio > 0,
    Sales.Ratio < 10
  )

# Compare row counts before and after cleaning
cat("Original rows:", nrow(real_estate), "\n")
cat("After cleaning:", nrow(real_estate_clean2), "\n")

# Distribution of Sale Amount (log scale)
ggplot(real_estate_clean2, aes(x = Sale.Amount)) +
  geom_histogram(bins = 50, fill = "blue", alpha = 0.7) +
  scale_x_log10() +
  labs(title = "Distribution of Sale Amount (log scale)", x = "Sale Amount (log scale)", y = "Count")

# Distribution of Assessed Value (log scale)
ggplot(real_estate_clean2, aes(x = Assessed.Value)) +
  geom_histogram(bins = 50, fill = "green", alpha = 0.7) +
  scale_x_log10() +
  labs(title = "Distribution of Assessed Value (log scale)", x = "Assessed Value (log scale)", y = "Count")

# Scatter plot: Assessed Value vs Sale Amount (log-log scale)
sample_data <- real_estate_clean2 %>% sample_n(10000)

ggplot(sample_data, aes(x = Assessed.Value, y = Sale.Amount)) +
  geom_point(alpha = 0.3, color = "purple") +
  scale_x_log10() + scale_y_log10() +
  labs(title = "Assessed Value vs Sale Amount (log-log scale)", x = "Assessed Value", y = "Sale Amount")

# Number of sales per year
sales_per_year <- real_estate_clean2 %>%
  group_by(Year) %>%
  summarise(Total_Sales = n())

ggplot(sales_per_year, aes(x = Year, y = Total_Sales)) +
  geom_line(color = "red") +
  labs(title = "Number of Sales per Year", x = "Year", y = "Total Sales")

# Number of sales by Property Type
sales_by_type <- real_estate_clean2 %>%
  group_by(Property.Type) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count))

ggplot(sales_by_type, aes(x = Property.Type, y = Count)) +
  geom_bar(stat = "identity", fill = "orange") +
  scale_y_continuous(labels = comma) +
  labs(title = "Number of Sales by Property Type", x = "Property Type", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Average Sale Amount and Assessed Value over time by Property Type
avg_prices_year_type <- real_estate_clean2 %>%
  group_by(Year, Property.Type) %>%
  summarise(
    Avg_Sale_Amount = mean(Sale.Amount, na.rm = TRUE),
    Avg_Assessed_Value = mean(Assessed.Value, na.rm = TRUE),
    Count = n(),
    .groups = "drop"
  ) %>%
  filter(!is.na(Property.Type))

# Plot average sale amount over time
ggplot(avg_prices_year_type, aes(x = Year, y = Avg_Sale_Amount, color = Property.Type)) +
  geom_line(size = 1) +
  scale_y_log10(labels = dollar_format(prefix = "$")) +
  labs(title = "Average Sale Amount Over Time by Property Type",
       x = "Year", y = "Average Sale Amount (log scale)", color = "Property Type") +
  theme_minimal()

# Plot average assessed value over time
ggplot(avg_prices_year_type, aes(x = Year, y = Avg_Assessed_Value, color = Property.Type)) +
  geom_line(size = 1) +
  scale_y_log10(labels = dollar_format(prefix = "$")) +
  labs(title = "Average Assessed Value Over Time by Property Type",
       x = "Year", y = "Average Assessed Value (log scale)", color = "Property Type") +
  theme_minimal()

# Average Sale Amount by Residential Type
type_trend_res <- real_estate_clean2 %>%
  filter(Residential.Type != "") %>%
  group_by(Year, Residential.Type) %>%
  summarise(
    Avg_Sale_Amount = mean(Sale.Amount, na.rm = TRUE),
    Count = n(),
    .groups = "drop"
  )

ggplot(type_trend_res, aes(x = Year, y = Avg_Sale_Amount, color = Residential.Type)) +
  geom_line(size = 1) +
  scale_y_log10(labels = dollar_format(prefix = "$")) +
  labs(title = "Average Sale Amount Over Time by Residential Type",
       x = "Year", y = "Average Sale Amount (log scale)", color = "Residential Type") +
  theme_minimal()

# Sales count by Residential Type
type_count_res <- real_estate_clean2 %>%
  group_by(Year, Residential.Type) %>%
  summarise(Count = n(), .groups = "drop") %>%
  filter(!is.na(Residential.Type))

ggplot(type_count_res, aes(x = Year, y = Count, color = Residential.Type)) +
  geom_line(size = 1) +
  scale_y_continuous(labels = comma) +
  labs(title = "Number of Sales Over Time by Residential Type",
       x = "Year", y = "Count of Sales", color = "Residential Type") +
  theme_minimal()

# Sales ratio trends over time
sales_ratio_trends <- real_estate_clean2 %>%
  group_by(Year, Property.Type) %>%
  summarise(
    Avg_Sales_Ratio = mean(Sales.Ratio, na.rm = TRUE),
    Count = n(),
    .groups = "drop"
  ) %>%
  filter(!is.na(Property.Type))

ggplot(sales_ratio_trends, aes(x = Year, y = Avg_Sales_Ratio, color = Property.Type)) +
  geom_line() +
  labs(title = "Average Sales Ratio Over Time by Property Type",
       x = "Year", y = "Average Sales Ratio", color = "Property Type") +
  theme_minimal()

# Town-level summary stats
avg_sales_by_town <- real_estate_clean2 %>%
  group_by(Town) %>%
  summarise(
    Avg_Sale_Amount = mean(Sale.Amount, na.rm = TRUE),
    Total_Sales = n(),
    .groups = "drop"
  ) %>%
  filter(Total_Sales > 100) %>%
  arrange(desc(Avg_Sale_Amount))

# Plot top towns by average sale amount
top_towns <- head(avg_sales_by_town, 10)

ggplot(top_towns, aes(x = reorder(Town, Avg_Sale_Amount), y = Avg_Sale_Amount)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(title = "Top 10 Towns by Average Sale Amount", x = "Town", y = "Average Sale Amount")

# Town-specific sales trend (example: Ansonia)
town_name <- "Ansonia"

avg_sales_town <- real_estate_clean2 %>%
  filter(Town == town_name) %>%
  group_by(Year) %>%
  summarise(Avg_Sale_Amount = mean(Sale.Amount, na.rm = TRUE), .groups = "drop")

ggplot(avg_sales_town, aes(x = Year, y = Avg_Sale_Amount)) +
  geom_line(color = "darkgreen") +
  geom_point() +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(title = paste("Average Sale Amount Over Time in", town_name),
       x = "Year", y = "Average Sale Amount") +
  theme_minimal()
