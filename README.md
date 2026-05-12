# Retail Intelligence & Strategic Growth Playbook

## The Objective:
This project is built to analyse current business revenue , various demographics and dictate future business actions. 
By running a forensic teardown of over 3,900 retail transactions to extract hidden behavioral signals, isolate operational bottlenecks, and architect a data-driven growth strategy. Moving beyond standard descriptive statistics, this repository translates raw PostgreSQL queries into a Chief Operating playbook. The core objective is to identify exact points of revenue leakage and propose aggressive, structural changes to maximize Customer Lifetime Value (CLV).

## The Tech Stack: 
* **Data Processing & Feature Engineering (Python):** Utilized Pandas and NumPy to clean the raw transactional dataset.
* **Data Aggregation & Cohort Analysis:** PostgreSQL (Complex Joins, Window Functions, CTEs, Aggregations)
* **Visualization & BI:** Power BI (Interactive DAX modeling, Geospatial Heatmaps, Dynamic Filtering)
* **Analytical Framework:** Feature Extraction, Cohort Analysis, Supply Chain Optimization

## Data Pipeline & Feature Engineering (Python)
Before running SQL aggregations, Utilisation was done to clean the dataset and engineer new features that would expose underlying customer behaviors.

* **RFM Matrix Engineering:** Calculated Recency, Frequency, and Monetary values for every unique customer ID to segment the user base into distinct behavioral cohorts like "Quarterly High-Value" and "Weekly Deal Hunters".
* **Loyalty Signal Calculation:** Engineered a custom `future_loyalty_signal` metric by weighting repeat visit intervals, average cart value, and historical review scores to predict long term retention.
* **Categorical Binning & Standardization:** Processed raw age data into distinct marketing brackets (e.g., 18-25, 50+) and parsed raw product reviews into structured satisfaction tiers (Elite, Average, Risk) for downstream SQL querying.
* **LTV (Lifetime Value) Modeling:** Computed the projected monetary value of customer segments based on their acquisition channel and subscription status to measure true profitability versus initial acquisition cost.

## The Discoveries:
The data revealed massive flaws in standard retail assumptions.

* **The Demographic Reality Check:** Chasing younger demographics proved to be a waste of marketing capital. The 50+ male demographic generates the highest lifetime value, buys at the highest frequency, and responds most profitably to discount campaigns. 
* **The Gifting Anomaly:** The top revenue drivers for male accounts are dresses and high-ticket jewelry. Men are not buying for themselves, they are using the platform heavily for gifting.
* **The Quality Churn Trap:** Women's shirts drive massive volume but holding the absolute lowest satisfaction score. 
* **The Store Pickup Crisis:** Illinois emerged as the most loyal market but suffers from operational satisfaction due to failing in store pickup logistics.
* **The Subscription Reality:** The current subscription model successfully builds emotional loyalty, but the Lifetime Value (LTV) of subscribers versus non-subscribers is nearly identical, meaning the perks are eating into profit margins.
* **Micro-Climatic Seasonality:** Customers ignore the traditional retail calendar. Sunglasses rank as a top-two revenue driver in the winter while heavy sweaters remain the top seller throughout spring.
  
## The Execution Plan: 
Data is useless without a decision. 

* **Redesign the Acquisition Funnel:** Use high volume, low margin clothing to acquire customers, then actively retarget them into the high loyalty footwear category.
* **Dynamic Payment Friction Removal:** Redesign the checkout logic based on demographic payment affinities. Default to a Venmo integration for the 26–35 cohort and traditional Credit Card inputs for the 50+ cohort.
* **Launch an Executive Gift Concierge:** Trigger targeted UI takeovers for male accounts 30 days prior to major holidays to capitalize on the male gifting trend with high margin premium wrapping upsells.
* **Solve the Store Pickup Crisis:** Mandate an SMS photo confirmation from staff when a pickup order is ready. This eliminates customer wait anxiety and enforces operational accountability in failing Midwest stores.
* **Restructure Subscription Economics:** Pivot the subscription model away from a flat "Free Shipping" perk into a "Quarterly Store Credit" system. This forces larger basket sizes and perfectly aligns with the highly profitable quarterly shopper cadence.

## Repository Structure
Dataset.csv: The original, raw transactional dataset.
Data_cleaning.ipynb: Jupyter Notebook containing the Python/Pandas code for data cleaning, handling nulls, and feature engineering.
shopping_cleaned.csv: The processed and structured dataset outputted from the Jupyter Notebook.
Retail_analytic.sql: The SQL scripts used to extract cohort metrics, seasonal trends, and demographic aggregations.
PowerBi/: Directory containing the interactive Power BI dashboard file (Retail analysis.pbix).
Presentation.pptx: Slide deck containing the executive summary, visual insights, and the final strategic action plan.
