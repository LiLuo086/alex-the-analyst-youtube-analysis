# 📈 **Cracking the Code of Growth: A Data Analytics Case Study of Alex The Analyst’s YouTube Channel**

This project is an end-to-end data analytics case study analyzing the performance and content strategy of [Alex The Analyst](https://www.youtube.com/c/AlexTheAnalyst)'s YouTube channel. The pipeline of this project includes data collection, storage, analysis, and visualization.

---

## 🎯 Project Objective

The goal is to explore and understand performance patterns across Alex The Analyst’s YouTube videos in order to identify what factors contribute to high engagement, and guide data-driven content decisions.

## Key Questions Driving the Analysis

- Which days and times are best for publishing videos?
- How does video length affect performance?
- What are the engagement patterns based on video tags?

This case study showcases data analyst competencies including SQL, Python, PostgreSQL, and Tableau.

---

## 🛠️ Tools & Technologies

| Tool         | Purpose                             |
|--------------|-------------------------------------|
| Python       | Data collection via YouTube API     |
| PostgreSQL   | Data storage and querying           |
| SQL          | Data wrangling and analysis         |
| Tableau      | Data visualization and dashboards   |
| Google API   | Source for YouTube channel data     |

---

## 📁 Project Structure

```bash
📂 alex-the-analyst-youtube-analysis
├── 📄 README.md
├── 📜 requirements.txt  
├── 🐍 data_collection.ipynb
├── 🗃️ database_schema.sql
├── 📂 sql_queries/
│ └── data_cleaning.sql
│ └── eda_queries.sql
│ └── feature_engineering.sql
├── 📂 visualizations/
│ └── alex_channel_dashboard.twbx
├── 📂 data/
│ └── videos.csv
└── 📂 reports/
└── insights_summary.pdf
```

---

## 🔄 Data Pipeline Overview

1. **Data Collection**:  
   - Used the YouTube Data API v3 to extract video-level data from Alex The Analyst’s channel.
   - Collected metadata like titles, publish dates, views, likes, comments, and more.

2. **Data Storage**:  
   - Stored structured data in a PostgreSQL database.
   - Created tables: `raw_videos`.

3. **Data Cleaning & Feature Engineering**:
   - Data cleaning:
      - Remove duplicates and nulls
      - trim whitespace in text columns
      - Fix data type, convert tags to text[] array
   - Feature engineering:
      - Convert `published_at` from UTC to time zone US/EST
      - Extract:
      - publish year
      - publish month
      - publish quarter
      - publish weekday
      - publish hour
      - publish time-of-day

4. **Data Analysis**:  
   - Wrote SQL queries for EDA:
     - Most viewed videos
     - Engagement rate trends
     - Performance by publish day/time
   - Performed calculations like video age, engagement rate, and publishing intervals.

5. **Data Visualization**:  
   - Built an interactive dashboard in Tableau to display:
     - Channel growth over time
     - Top-performing videos
     - Publishing frequency vs. performance
     - Engagement trends

---

## 📈 Key Insights

- Videos on portfolio projects and career tips consistently outperform technical tutorials.
- The optimal posting days for highest views are Tuesday and Thursday.
- Engagement rate increases when video length is between 8–12 minutes.
- Weekly posting frequency correlates with steady subscriber growth.

---

## 📊 Dashboard Preview

> 📍[Click here to view the Tableau Dashboard (if published)](https://public.tableau.com/)

![Dashboard Sample](visualizations/dashboard_screenshot.png)

---

## 🧠 Skills Demonstrated

- Data wrangling and transformation in SQL
- REST API integration using Python
- Relational database design
- Dashboard creation with business storytelling

---

## 📌 How to Run This Project Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/LiLuo086/alex-the-analyst-youtube-analysis.git
   cd alex-the-analyst-youtube-analysis
   ```

2. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Set your YouTube API Key in youtube_data_scraper.py.

4. Run the data collection script:

   ```bash
   python youtube_data_scraper.py
   ```

5. Import database_schema.sql into your PostgreSQL DB and insert the data.

6. Use sql_queries/eda_queries.sql to begin analysis.

7. Open the Tableau workbook in visualizations/ to explore the dashboard.

## 📚 Credits

Alex The Analyst for publicly available educational content and inspiration.

Google Developers for the YouTube Data API v3.

## 🔒 Disclaimer

This project is for educational and portfolio purposes only. No commercial use or distribution of data.
