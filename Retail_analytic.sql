-- Query to get revenue by category
SELECT 
    "Category",
    COUNT("Customer ID") AS Total_Customers,
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Average_Loyalty_Score,
    SUM("Est_Historical_Spent") AS Total_Revenue_USD
FROM transactions
GROUP BY "Category"
ORDER BY Total_Revenue_USD DESC;

-- Query to find top discount dependent segments
SELECT 
    "Age Group",
    "Gender",
    COUNT("Customer ID") AS Total_Shoppers,
    ROUND(AVG("Previous Purchases")::numeric, 1) AS Avg_Purchases,
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Avg_Loyalty,
    SUM("Est_Historical_Spent") AS Total_Promo_Revenue_USD
FROM transactions
WHERE "Is_Discount_Dependent" = true
GROUP BY "Age Group", "Gender"
ORDER BY Total_Promo_Revenue_USD DESC
LIMIT 5;

--  Query to find logistic check 
SELECT 
    "Location",
    "Shipping Type",
    COUNT("Customer ID") AS Frustrated_Customers,
    ROUND(AVG("Review Rating")::numeric, 2) AS Avg_Satisfaction,
    ROUND(AVG("Purchase Amount (USD)")::numeric, 2) AS Revenue_At_Risk
FROM transactions
WHERE "Review Rating" < 3.5
GROUP BY "Location", "Shipping Type"
ORDER BY Frustrated_Customers DESC
LIMIT 10;

-- Query to check LTV for subscribers and non subscribers
SELECT 
    "Subscription Status",
    COUNT("Customer ID") AS Total_Shoppers,
    ROUND(AVG("Annual_Purchase_Frequency")::numeric, 1) AS Avg_Annual_Purchases,
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Avg_Loyalty,
    ROUND(AVG("Est_Historical_Spent")::numeric, 2) AS Avg_Lifetime_Value_USD,
    SUM("Est_Historical_Spent") AS Total_Cohort_Revenue
FROM transactions
GROUP BY "Subscription Status"
ORDER BY Total_Cohort_Revenue DESC;

-- Query to find revenue by season and category
SELECT 
    "Season",
    "Category",
    COUNT("Customer ID") AS Total_Orders,
    SUM("Est_Historical_Spent") AS Seasonal_Revenue_USD,
    ROUND(AVG("Purchase Amount (USD)")::numeric, 2) AS Avg_Cart_Value
FROM transactions
GROUP BY "Season", "Category"
ORDER BY "Season", Seasonal_Revenue_USD DESC;

-- Query to get purchase frequency performance
SELECT 
    "Frequency of Purchases",
    COUNT("Customer ID") AS Total_Customers,
    ROUND(AVG("Est_Historical_Spent")::numeric, 2) AS Avg_Customer_Value_USD,
    SUM("Est_Historical_Spent") AS Total_Revenue_USD
FROM transactions
GROUP BY "Frequency of Purchases"
ORDER BY Total_Revenue_USD DESC;

-- Query to get gender dependent data
SELECT 
    "Category",
    "Item Purchased",
    COUNT("Customer ID") AS Total_Female_Shoppers,
    SUM("Est_Historical_Spent") AS Total_Revenue_USD,
    ROUND(AVG("Review Rating")::numeric, 2) AS Avg_Satisfaction
FROM transactions
WHERE "Gender" = 'Female'
GROUP BY "Category", "Item Purchased"
ORDER BY Total_Revenue_USD DESC
LIMIT 5;
SELECT 
    "Category",
    "Item Purchased",
    COUNT("Customer ID") AS Total_Male_Shoppers,
    SUM("Est_Historical_Spent") AS Total_Revenue_USD,
    ROUND(AVG("Review Rating")::numeric, 2) AS Avg_Satisfaction
FROM transactions
WHERE "Gender" = 'Male'
GROUP BY "Category", "Item Purchased"
ORDER BY Total_Revenue_USD DESC
LIMIT 5;

-- Query to get Shopping Mode Revenue and Category breakdown
SELECT 
    CASE 
        WHEN "Shipping Type" = 'Store Pickup' THEN 'Offline (Store Pickup)'
        ELSE 'Online'
    END AS Shopping_Mode,
    COUNT("Customer ID") AS Total_Orders,
    SUM("Purchase Amount (USD)") AS Immediate_Revenue,
    ROUND(AVG("Previous Purchases")::numeric, 1) AS Avg_Repeat_Orders,
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Avg_Loyalty
FROM transactions
GROUP BY Shopping_Mode
ORDER BY Immediate_Revenue DESC;

SELECT 
    CASE 
        WHEN "Shipping Type" = 'Store Pickup' THEN 'Offline'
        ELSE 'Online'
    END AS Shopping_Mode,
    "Category",
    COUNT("Customer ID") AS Total_Sold,
    SUM("Purchase Amount (USD)") AS Revenue
FROM transactions
GROUP BY Shopping_Mode, "Category"
ORDER BY Shopping_Mode, Revenue DESC;

-- Query to find satisfaction ROI
SELECT 
    CASE 
        WHEN "Review Rating" >= 4.5 THEN 'High Rating (4.5-5.0)'
        WHEN "Review Rating" >= 3.0 THEN 'Medium Rating (3.0-4.4)'
        ELSE 'Low Rating (<3.0)'
    END AS Rating_Bracket,
    COUNT("Customer ID") AS Shopper_Count,
    ROUND(AVG("Previous Purchases")::numeric, 1) AS Avg_Return_Visits,
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Loyalty_Impact
FROM transactions
GROUP BY Rating_Bracket
ORDER BY Avg_Return_Visits DESC;

SELECT 
    CASE 
        WHEN "Review Rating" >= 4.5 THEN 'Elite (4.5-5.0)'
        WHEN "Review Rating" >= 3.5 THEN 'High (3.5-4.4)'
        WHEN "Review Rating" >= 2.5 THEN 'Average (2.5-3.4)'
        ELSE 'Poor (<2.5)'
    END AS Satisfaction_Bracket,
    COUNT("Customer ID") AS Shopper_Count,
    ROUND(AVG("Purchase Amount (USD)")::numeric, 2) AS Avg_Current_Ticket,
    ROUND(AVG("Est_Historical_Spent")::numeric, 2) AS Avg_Lifetime_Value,
    ROUND(AVG("Previous Purchases")::numeric, 1) AS Avg_Repeat_Frequency
FROM transactions
GROUP BY Satisfaction_Bracket
ORDER BY Avg_Lifetime_Value DESC;

-- Query to check age wise payment methods to check tech experiences
SELECT 
    "Age Group",
    "Payment Method",
    COUNT("Customer ID") AS Transaction_Count,
    SUM("Purchase Amount (USD)") AS Total_Revenue,
    ROUND(AVG("Purchase Amount (USD)")::numeric, 2) AS Avg_Transaction_Size
FROM transactions
GROUP BY "Age Group", "Payment Method"
ORDER BY "Age Group", Total_Revenue DESC;

-- Query to find top states by revenue and loyalty
SELECT 
    "Location",
    COUNT("Customer ID") AS Total_Customers,
    SUM("Purchase Amount (USD)") AS Total_Revenue,
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Avg_Loyalty_Score,
    ROUND(AVG("Previous Purchases")::numeric, 1) AS Avg_Repeat_Orders,
    SUM(CASE WHEN "Previous Purchases" > 30 THEN 1 ELSE 0 END) AS High_Retention_Fans
FROM transactions
GROUP BY "Location"
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Query to get Raw Review Rating vs. Future Loyalty Score
SELECT 
    "Review Rating",
    ROUND(AVG("Loyalty Score")::numeric, 2) AS Future_Loyalty_Signal,
    ROUND(AVG("Est_Historical_Spent")::numeric, 2) AS Total_Value_Contribution
FROM transactions
GROUP BY "Review Rating"
ORDER BY "Review Rating" DESC;

-- Query to find Top 3 Items per Season (Ranked)
WITH SeasonalRank AS (
    SELECT 
        "Season",
        "Category",
        "Item Purchased",
        COUNT("Customer ID") AS Units_Sold,
        SUM("Purchase Amount (USD)") AS Seasonal_Revenue,
        RANK() OVER (PARTITION BY "Season" ORDER BY SUM("Purchase Amount (USD)") DESC) as Sales_Rank
    FROM transactions
    GROUP BY "Season", "Category", "Item Purchased"
)
SELECT * FROM SeasonalRank WHERE Sales_Rank <= 3;

-- Query to find #1 Item per State per Season
WITH LocalSeasonality AS (
    SELECT 
        "Location",
        "Season",
        "Category",
        "Item Purchased",
        SUM("Purchase Amount (USD)") AS Total_Revenue,
        RANK() OVER (PARTITION BY "Location", "Season" ORDER BY SUM("Purchase Amount (USD)") DESC) as Rank
    FROM transactions
    GROUP BY "Location", "Season", "Category", "Item Purchased"
)
SELECT * FROM LocalSeasonality WHERE Rank = 1; 