# Real Estate Sales Analysis (2001–2022)

This repository contains a comprehensive end-to-end analysis of real estate sales data from 2001 to 2022. The analysis is performed using R and includes data cleaning, exploratory data analysis, visualization, and insights on market trends.

---

## Project Structure

real-estate-sales-analysis/
├── real_estate_analysis.R # Complete R script for data cleaning, analysis, and plotting
├── images/ # Folder containing all saved plot images (PNG format)
├── .gitignore # Git ignore file to exclude large data files from repository
├── README.md # This documentation file
└── Real_Estate_Sales_2001-2022_GL.csv # Large raw dataset file (kept locally, excluded from GitHub)

---

## Summary of Key Findings

### 1. Core Distributions

- **Sale Amount Distribution**: Log-normal with 95% sales between $50K and $1.5M; luxury tail above $5M.
- **Assessed Value Distribution**: Mirrors sale amounts with median assessed value around $210K.
- **Sale vs. Assessed Values**: Strong correlation (R² ~ 0.88); notable outliers indicating assessment discrepancies.

### 2. Market Dynamics

- Sales volumes have fluctuated, peaking in 2006, dropping in 2011, and recovering by 2021.
- Single Family homes dominate sales (62%), with condos showing fastest growth since 2015.
- Demand surged for Single Family homes post-2020, while Multi-family stayed stable.

### 3. Price Trends

- Commercial properties exhibit high volatility; residential properties show steady annual growth (~4.2%).
- Assessments lag behind market prices, especially for commercial properties.
- Single Family homes sell at about 35% premium over condos.

### 4. Premium Markets

- Top towns like Darien and Greenwich average sales above $3.5M.
- Sales ratios in these areas suggest assessments lag market prices.
- Steady price growth in Ansonia (+66% since 2000) with a COVID-related spike.

### 5. Assessment Accuracy

- Commercial properties tend to be over-assessed, while vacant land is under-assessed.
- Suggests need to recalibrate land valuation models and update assessment cycles.

---

## How to Use This Repository

1. **Data:** The large CSV file `Real_Estate_Sales_2001-2022_GL.csv` is kept locally due to size constraints and excluded from GitHub.
2. **Analysis Script:** `real_estate_analysis.R` contains the full analysis, including data cleaning, plotting, and saving visualizations.
3. **Images:** All generated plots are saved in the `images/` folder and can be reviewed for detailed insights.

---

## Next Steps and Recommendations

- Investigate very high sales above $10M for market impact.
- Advocate for reassessment reforms, particularly in commercial and luxury markets.
- Monitor urbanization trends with focus on condo growth.
- Consider affordability pressures in premium markets.


