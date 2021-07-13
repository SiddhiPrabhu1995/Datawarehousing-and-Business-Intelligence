
# IMDb Box Office Analysis for Business Intelligence & Data warehousing

## Summary:

In IMDB Box Office Analysis project (dataset of movies and TV series) we had performed ETL on raw data. 

### DATAWAREHOUSING
Data Warehouse consists of large sets of data from different sources which is used for reporting and analysis. Data Warehouses are connected with data sources and ETL systems on one end and reporting tools or dashboard interfaces on the other. This allows for presenting data from various systems via a single interface.

TOOLS USED:-

- :white_check_mark: DATABASE : MS SQL SERVER
- :white_check_mark: ETL TOOLS : TALEND AND ALTERYX
- :white_check_mark: BUSINESS INTELLIGENCE TOOLS : TABLEAU AND POWERBI
- :white_check_mark: DATA MODELING TOOLS : ER STUDIO AND TOAD DATA MODELER

## ER DIAGRAM:

![WhatsApp Image 2020-09-20 at 12 36 01 AM](https://user-images.githubusercontent.com/57429405/125008872-69530580-e031-11eb-810a-9aa20281f9de.jpeg)

## STEP 1:- DATA PROFILING:

Analyzed the raw data by data profiling by developing SQL queries in order to analyze the data inconsistencies and relevant attributes to be included in data modeling.

## STEP 2:- DATA MODELING:

![1_6F0YlqpQlxE5If25svYsdA](https://user-images.githubusercontent.com/57429405/125009121-e8e0d480-e031-11eb-93a3-e35ab359c3c6.png)

In data modeling, we designed logical dimensional data model in ER Studio which was Multi-fact star schema generated DDL scripts to design enterprise data warehouse. Dimensional model included dimensions, facts, SCD-Type 2- to track historical changes, role playing dimension like date. 

## STEP 3:- DATA INTEGRATION:

Performed Data integration, gathered the raw data from different sources performed ETL on it and loaded in staging which then mapped the data to respective dimensions and facts:

-	Loading staging tables
-	Loading dimensional model tables

## STEP 4:- DATA EXTRACTION, TRANSFORMATION & LOADING(ETL):

![WhatsApp Image 2020-09-20 at 12 40 15 AM](https://user-images.githubusercontent.com/57429405/125008828-550f0880-e031-11eb-8231-df92ab4f9332.jpeg)

Data extraction- The ETL tool retrieves data from the data sources including ERP, CRM, analytics, and spreadsheets.

Data transformation- Once extracted, the ETL tool starts data processing. All extracted data is analyzed, have duplicates removed, and then is standardized, sorted, filtered, and verified using datapipelines designed in Alteryx and Talend.

Data loading- At this phase, transformed data is uploaded into the warehouse.

# Sample Altreyx Jobs created in the project:

![FactWorkOrder](https://user-images.githubusercontent.com/57429405/125508426-9b0038da-236b-4175-aae7-c60010b42a86.png)

![DimEmployee](https://user-images.githubusercontent.com/57429405/125508595-87989b0c-e7e8-4f76-b7ce-c1e5834112a5.png)


# Sample Talend Jobs created in the project:

![](Images/Talend_Screenshots/DimEmployee_Talend.png)

![](Images/Talend_Screenshots/DimVendor_Talend.png)

## step 5:- Implement the end-user interface: Reporting tools and dashboards

<img width="788" alt="Capture" src="https://user-images.githubusercontent.com/57429405/125010044-c354ca80-e033-11eb-9064-66c96d4f56d4.PNG">

Since there was large amount of data, we developed views so that only relevant data is loaded in BI tools like Tableau and PowerBI.

## step 6:- AUTOMATING THE WORKFLOW DEVELOPED IN TALEND

We automated the workflows using master job which had workflows in sequence like staging tables, dimensions and then facts.
Took 40 mins to run and complete the entire master job.

<img width="627" alt="masterjob" src="https://user-images.githubusercontent.com/57429405/125010288-3a8a5e80-e034-11eb-8914-963a9092f42f.PNG">
