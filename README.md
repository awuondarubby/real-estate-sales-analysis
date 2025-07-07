# Real Estate Sales Analysis (2001–2022)

This repository contains a comprehensive end-to-end analysis of real estate sales data from 2001 to 2022. The analysis is performed using R and includes data cleaning, exploratory data analysis, visualizations, and insights into market trends across Connecticut.

---

## Project Structure

real-estate-sales-analysis/
├── real_estate_analysis.R # Complete R script for data cleaning, analysis, and plotting
├── images/ # Folder containing all saved plot images (PNG format)
├── .gitignore # Git ignore file to exclude large data files and system files
├── README.md # Project documentation
└── Real_Estate_Sales_2001-2022_GL.csv # Dataset (excluded from GitHub due to file size)

---

## Summary of Key Findings

### 1. Core Distributions

- **Sale Amount Distribution**: Log-normal with 95% of sales between $50,000 and $1.5 million; a long tail for luxury properties.
- **Assessed Value Distribution**: Closely follows sale amounts, with a median around $210,000.
- **Sale vs. Assessed Values**: Strong positive correlation (R² ≈ 0.88), with outliers highlighting valuation gaps.

### 2. Market Dynamics

- Sales volume peaked in 2006, dropped post-recession, and recovered steadily by 2021.
- Single Family homes account for 62% of sales; condos showed the fastest growth after 2015.
- A surge in demand for Single Family homes occurred post-2020.

### 3. Price Trends

- Commercial property prices are volatile; residential prices have grown at ~4.2% annually.
- Assessed values tend to lag behind market prices, especially in commercial real estate.
- Single Family homes typically sell at a 35% premium over condos.

### 4. Premium Markets

- Towns like Darien and Greenwich have average sale prices above $3.5 million.
- Sales ratios suggest under-assessment in high-value markets.
- Ansonia experienced steady price growth (+66% since 2000), with a pandemic-related spike.

### 5. Assessment Accuracy

- Commercial properties are often over-assessed; vacant land is under-assessed.
- Indicates a potential need for reassessment in certain categories and regions.

---

## Dataset Source

The dataset used in this analysis is publicly available from the State of Connecticut Open Data Portal:

[Real Estate Sales 2001–2022 - Data.ct.gov](https://data.ct.gov/Property-Data/Real-Estate-Sales-2001-2022-GL/5mzw-sjtu)

Due to GitHub's 100 MB file size limit, the dataset is excluded from this repository.  
To use this project:

1. Download the dataset from the link above.
2. Save it as `Real_Estate_Sales_2001-2022_GL.csv`.
3. Place the file in the root directory of this project.

---

## How to Use This Repository

1. Clone or download this repository to your local machine.
2. Install the required R packages: `dplyr`, `tidyr`, `stringr`, `ggplot2`, and `scales`.
3. Open `real_estate_analysis.R` in RStudio or your preferred IDE.
4. Run the script step by step to clean the data and generate insights.
5. All generated plots will be saved to the `images/` folder.

---

## Recommendations for Further Analysis

- Explore the impact of high-end transactions (over $10 million) on local market medians.
- Evaluate potential improvements to property assessment practices in Connecticut.
- Study urban development patterns using condo growth trends.
- Analyze affordability changes in premium real estate markets.

---

## Author

**Denny Rubby**  
[GitHub: awuondarubby](https://github.com/awuondarubby)

---

## License

This project is intended for educational and non-commercial use.

