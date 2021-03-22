# ETL_CoronavirusData

## BoxPlot Jellyfish
- Grace Li
- James Milne
- John Gore
- Natali Gracia

## Jellylike Mesoglea (Our Project Description)
Using ETL (Extract, Transfer and Load) processes described below we combined Coronavirus case rate/mortality data with and other demographic/economic factors so that a business analyst might be able to answer questions such as "What is the mix of coronavirus cases by race, income, or education level at the US state level?"

### Data Sources:
WorldoMeters
- https://www.worldometers.info/coronavirus/country/us/
World Population Review
- https://worldpopulationreview.com/states

The Worldometers site publishes cumulative data on coronavirus cases, recovery, tests and death rates down to the county level of granularity. For the purposes of this exercise, we scraped data at the US state level for a single day. The data comprises rows for all 50 states and territories e.g. Guam, Mariana Is., and also other categories including the US Military, Federal Prisons and the Navajo Nation. We note that this data aggregates data from the CDC, Census estimates, news reports and other sources to build its tables.

The World Population Review site comprising census data for each state, along with splits by race, education, earnings, sex, marital status, employment and other factors.
We chose to investigate education levels, race, and earnings as our metrics to join to the Covid data for the purposes of this exercise.  

## _Extract:_
We scraped data from these sites using the Pandas library of Python and then exported the raw data files into a series of CSV files which would be ingested in the following phases.

## _Transform:_
Data was transformed in Jupyter notebooks using the Pandas library of Python. After importing raw CSV files from the extraction step, we removed extraneous columns e.g. totals or ratio columns (these can be computed using other data from the database if needed, removing need to import them). We also dropped rows which did not pertain directly to states/territories e.g. cases for US Military. We standardized headings on the tables e.g. state_name, so that they were common across all tables. Finally, we converted fact data from string formats into integers/floats so that an analyst might be better able to perform calculations. Once the data was scrubbed, the clean data tables were exported as CSV files for the final phase.

## _Load:_
The clean CSV files were loaded into PostGres, using the state names as the primary key to join to many of the other tables. In all, we created seven data tables comprising:
 - COVID_data (cases, deaths, recovered and testing data, cumulative as of 3/20/21)
 - States (state names)
 - race_id (racial categories e.g. white, hispanic etc.)
 - Population_Density (state population data, growth rates and density)
 - Education_id (interstitial table to enable joining between Population Earnings and Population_edu_attain)
 - Population_by_race (population by racial mix)
 - Population_edu_attain (population by education levels)
 - Population_Earnings (average earnings by education level)


## _Data issues:_
We note the following items during our preliminary inspection of the data, which would need to be made clear to an analyst prior to commencing analysis. 
1) Population estimates are displayed in both the WorldoMeters and World Population Review sites and these estimates differ (likely because the data was estimated at different times).  Rather than drop one of these figures, we chose to keep both and give the analyst the choice of metric to use, noting that the differences in population data are less 5% between the two sources. 
2) Educational attainment categories were not consistant across the Population_edu_attain and Population_Earnings tables, necessitating the need for an interstitial mapping table (Education_id) which would allow an analyst to join data on both. As an example, educational attainment contains categories of "Less than 9th Grade", and "9th to 12th Grade", while Population_Earnings only has the category "Less than High School".
3) We do not have access to the underlying data supporting either of the two websites and therefore can make no assurances that the data was collected consistantly. As an example, data in the World Population Review cites 2019 Census information, while Worldometers quotes county coronavirus data current as of March 20, 2021.  Although the data is scrubbed by experts at the source before being ingested to both sites, we have no way of knowing the methods used in this scrubbing nor how they differ. Without the underlying data, it is also impossible to further explore anomalies in the tables. We therefore impress upon any analyst wishing to use this data, that it is a useful tool for gauging rough estimates, and NOT precise point metrics. 
4) Data from Worldometers is updated with cumulative inforamtion daily, while the World Population Review site is updated with new Census data published every few years. This mismatch in timing may cause issues in estimation. We note that the underlying demographic and economic factors are slow changing relative to the timeframe of the coronavirus data (approximately 1 year) and so this should have little impact on general trends.

