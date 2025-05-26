# Telegram Channel Performance Analytics

## Project Overview

This project presents an **end-to-end data analysis pipeline** developed for a Telegram channel with over 20,000 members. The goal was to transform raw digital performance metrics (posts, clicks, earnings, time data) into actionable insights, ultimately driving **significant revenue growth and optimizing content strategy**. Leveraging a single Python script for data extraction and KPI calculation, MySQL for deep-dive trend analysis, and Excel for dynamic dashboarding, this analysis uncovered critical patterns in audience behavior and content performance.

---

## Tools & Technologies Used

* **Python:** For data extraction (HTML parsing), cleaning, and calculating key performance indicators (KPIs).
    * Libraries: `BeautifulSoup`, `datetime`, `os`, `matplotlib`, `csv`
* **MySQL:** For structured data storage and advanced querying to identify monthly earning patterns.
* **Microsoft Excel:** For data aggregation, creating dynamic dashboards, pivot tables, pivot charts, and detailed analysis of performance correlations.

---

## Problem Statement & Goal

The core objective was to move beyond simple performance tracking to understand the **drivers of engagement and revenue** on a Telegram channel. Key questions addressed included:

* What is the true profitability per post and per click?
* Are there specific times of day that yield better engagement and earnings?
* Do monthly salary cycles impact audience spending behavior?
* What content strategies consistently drive growth, and what leads to underperformance?

---

## Data Sources

The analysis utilized data from the Telegram channel itself, primarily consisting of:

* **HTML message logs:** Raw data containing post dates, times, and content.
* **Weekly performance metrics:** A compiled dataset of weekly clicks, earnings, and posts made.

---

## Methodology

The analysis followed a structured multi-stage approach:

### 1. Data Processing & Analysis (Python - `telegram_analysis.py`)

* **HTML Extraction & Preprocessing:** The script reads raw HTML message files (`messages.html`, `messages2.html`), parses them using `BeautifulSoup` to extract `Date`, `Time`, and categorize `Time_Category` (Morning, Afternoon, After Evening). This processed data is then saved into `daily_post_data.csv`.
* **Weekly Performance Analysis:** The same script then ingests a weekly aggregated dataset (`telegram_data.csv`) to calculate critical KPIs such as:
    * Earnings per Post
    * Earnings per 1000 Clicks (Efficiency)
* **Performance Extremes & Underperformance:** It identifies the best and worst performing weeks in terms of earnings, and flags specific underperforming weeks based on defined criteria.
* **Automated Insights & Visualization:** The script generates actionable tips directly from the data patterns and produces a bar chart visualizing weekly earnings trends.

### 2. Monthly Earning Pattern Analysis (MySQL)

* **Data Import:** The aggregated weekly performance data (from Excel's `WeeklyData` table) was imported into a MySQL database named `telegramAnalysis`.
* **Hypothesis Testing (SQL Query):** A complex SQL query (`monthly_earning_comparison.sql`) was executed to compare the earnings of the first week of each month against the maximum earnings from the rest of the weeks in that month. This aimed to validate the hypothesis that salary cycles influence spending at the beginning of the month.
* **Insight Generation:** The SQL query successfully identified that for **3 out of 7 months (December, April, May)**, the first week's earnings were indeed higher than any other week in those respective months.

### 3. Dashboarding & Deeper Dive (Excel)

* **Weekly Data Consolidation:** A main Excel table (`WeeklyData` sheet) consolidated weekly performance metrics, including `Week Start`, `Week End`, `Clicks`, `Earnings`, `Posts Made`, and `Days Covered` (to account for partial weeks at month ends).
* **Dynamic Pivot Tables & Charts:** Created four key pivot tables and accompanying charts for comprehensive visualization:
    * 🔺 **Top 5 Weekly Earnings:** Showcasing highest-performing weeks.
    * 🔻 **Bottom 5 Weekly Earnings:** Highlighting lowest-performing weeks.
    * 📊 **Weekly Posts vs Clicks:** Visualizing engagement peaks and content volume.
    * 📈 **Monthly Earnings & Growth Percentage:** Tracking overall revenue trends from November 2024 to May 2025.
* **Daily Data Integration:** A `daily_real` sheet was created using the `daily_post_data.csv` (from Python) and enhanced with `Week label` and `TOP COMPARISON` columns.
* **Time-Based Performance Analysis:** Utilized an Excel formula (`=IF(COUNTIF('Top5'!I:I, D2) > 0, "Yes", "No")`) to compare daily data with top-performing weeks. Filtering this data revealed that **"After Evening" posts significantly outperformed** others in top-earning weeks.

---

## Key Insights & Impact

This project delivered actionable insights that directly influenced strategy and drove performance:

* **Data-Driven Revenue Growth:** Achieved an impressive **+161% overall monthly earnings growth** (Nov 2024 - May 2025). The analysis robustly confirmed a strong correlation: higher posting frequency directly linked to increased clicks and substantial revenue growth.
* **Audience Spending Behavior:** Identified a recurring pattern where the **first week of the month generated the highest revenue** in 3 out of 7 analyzed months (December, April, May), suggesting a correlation with salary cycles and audience spending habits.
* **Optimal Time-Based Strategy:** Discovered that **"After Evening" hours (5 PM - 4 AM) were the most effective posting window**, with posts in this category significantly outperforming "Morning" and "Afternoon" posts in top-earning weeks (e.g., 90 "After Evening" posts vs. 67 "Morning" and 32 "Afternoon" posts in peak periods), suggesting optimal user activity patterns.
* **Content Conversion Optimization:** Detected instances of high clicks but lower earnings, indicating areas for offer or content refinement to improve conversion efficiency.
* **Resilience Through Consistency:** Demonstrated that maintaining a consistent posting frequency helped mitigate dips in performance, even during otherwise low-earning weeks.

---

## Recommendations

To sustain and further accelerate earnings growth:

* **Prioritize "After Evening" Posting:** Strategically increase content deployment during the 5 PM to 4 AM window, as this has shown the strongest correlation with top earnings.
* **Maintain Consistent Frequency:** Continue with a reliable posting schedule overall to ensure steady engagement and revenue.
* **Continuous Optimization:** Regularly track weekly performance, test different content types, and monitor click-through rates to refine content strategy and conversion.

---

## How to Run This Project Locally

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YOUR_GITHUB_USERNAME/Telegram_Analytics_Project.git](https://github.com/YOUR_GITHUB_USERNAME/Telegram_Analytics_Project.git)
    cd Telegram_Analytics_Project
    ```
2.  **Python Setup:**
    * Ensure Python 3 is installed.
    * Install required libraries: `pip install beautifulsoup4 matplotlib` (Note: `pandas` and `openpyxl` are not required for the code you provided.)
    * Ensure your HTML raw data files (`messages.html`, `messages2.html`) and the `telegram_data.csv` (used as input for weekly analysis) are in the same directory as `telegram_analysis.py`.
    * Run the main Python script: `python telegram_analysis.py`
        * This script will first generate `daily_post_data.csv`.
        * Then it will proceed with the weekly analysis and print insights/plots.
3.  **MySQL Setup:**
    * Set up a MySQL server.
    * Create a database named `telegramAnalysis`.
    * Import your `WeeklyData` (e.g., from an Excel export) into a table named `WeeklyData` within this database.
    * Run the provided SQL query (`monthly_earning_comparison.sql`) in your MySQL client.
4.  **Excel Dashboard:**
    * Open `Telegram_Performance_Dashboard.xlsx` (or whatever you name your Excel file). Ensure the data links are updated if you move the file.

---

## Files in This Repository

* `telegram_analysis.py`: The main Python script for data extraction, preprocessing, and weekly analysis.
* `messages.html`, `messages2.html`: (Optional, if you wish to include raw data for full reproduction) Original HTML data files.
* `daily_post_data.csv`: Intermediate CSV generated by `telegram_analysis.py` (contains date, time, time category).
* `telegram_data.csv`: Input CSV for the weekly analysis part of `telegram_analysis.py` (contains weekly aggregates of clicks, earnings, posts).
* `monthly_earning_comparison.sql`: SQL query for monthly earning pattern analysis.
* `Telegram_Performance_Dashboard.xlsx`: The main Excel dashboard file.
* `README.md`: This file.

---

### **Guidance on Photos/Screenshots for your `README.md`:**

You should ideally embed images directly into your `README.md` file to break up text and instantly convey information. You can upload these images to your GitHub repository (perhaps in an `/images` subfolder) and then link to them using Markdown: `![Alt text for image](images/your_image_name.png)`.

Here are the key screenshots you should capture and include:

1.  **Overall Excel Dashboard Screenshot:**
    * **What:** A single, clear, high-resolution screenshot of your main Excel dashboard. This should give a recruiter an immediate overview of your visualization skills.
    * **Where to put:** Near the beginning of the `README.md`, perhaps right after "Project Overview" or at the start of the "Dashboarding & Deeper Dive" section.

2.  **Key Excel Chart / Time-Based Insight:**
    * **What:** A screenshot of one of your most impactful charts from Excel. This could be:
        * The **"Monthly Earnings & Growth Percentage"** chart showing the +161% growth.
        * A chart specifically visualizing the **"After Evening" posts vs. other time categories** from your `daily_real` sheet's pivot table (showing that the "After Evening" posts were significantly higher in top-earning weeks). This is a strong visual representation of a key insight.
    * **Where to put:** In the "Dashboarding & Deeper Dive" section, or within "Key Insights & Impact."

3.  **Python Weekly Earnings Plot:**
    * **What:** The **bar chart showing "Weekly Earnings"** that your `telegram_analysis.py` script generates. This visually confirms your Python's analysis capabilities.
    * **Where to put:** In the "Data Processing & Analysis (Python)" section.
    * *(Optional but good):* A screenshot of the *console output* from your `telegram_analysis.py` showing the "📊 Telegram Weekly Performance Insights" (Best Week, Worst Week, Highest Earnings per Post, etc.). This demonstrates your ability to summarize data programmatically.

4.  **MySQL Query Output:**
    * **What:** A screenshot of the **final output table from your MySQL query** (`monthly_earning_comparison.sql`). This clearly shows the "✅ Yes" for the 3 months where the first week's earnings were higher, validating your hypothesis.
    * **Where to put:** In the "Monthly Earning Pattern Analysis (MySQL)" section.
