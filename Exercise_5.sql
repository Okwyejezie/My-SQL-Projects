--Exercise 6
/* Analyze the climate disaster.csv datatset using SQL and provide 5 insights
and recommendations based on your findings*/

--Create disaster table before importing dataset
CREATE TABLE Disaster (
    year INTEGER,
    disaster_group TEXT,
    disaster_type TEXT,
    disaster_subtype TEXT,
    iso TEXT,
    region TEXT,
    continent TEXT,
    origin TEXT,
    associated_disaster TEXT,
    ofda_response VARCHAR,
    disaster_magnitude_value VARCHAR,
    latitude VARCHAR,
    longitude VARCHAR,
    start_year VARCHAR,
    end_year VARCHAR,
    total_deaths INTEGER,
    no_injured INTEGER,
    no_affected INTEGER,
    no_homeless INTEGER,
    total_affected INTEGER,
    total_damages_1000_usd INTEGER,
    total_damages INTEGER,
    adjusted_1000_usd INTEGER,
    country TEXT,
    location TEXT
);

--View table
select * from disaster;

--Insights
-- Which country have the highest desaster"?
SELECT country, COUNT(*) AS num_disasters
FROM Disaster
GROUP BY country
ORDER BY num_disasters DESC;

--What is the total casualties caused by desaster over time?
SELECT year, country,
       SUM(total_deaths) AS total_deaths_by_year, 
       SUM(no_injured) AS total_injured_by_year, 
       SUM(total_damages) AS total_damages_by_year
FROM Disaster
GROUP BY year, country
ORDER BY year ASC
LIMIT 10;

--The average number of casualties by desaster type
SELECT disaster_type, disaster_subtype, country, AVG(total_deaths + no_injured) AS avg_casualties
FROM Disaster
GROUP BY disaster_type, disaster_subtype, country
ORDER BY avg_casualties DESC
LIMIT 10;

-- What continent is mostly affected by disaster over time
SELECT year, continent, COUNT(*) AS num_disasters
FROM Disaster
GROUP BY year, continent
ORDER BY num_disasters DESC
LIMIT 10;

-- What is the total number of affected people in different location by year?
SELECT year, location, SUM(total_affected) AS total_affected
FROM Disaster
GROUP BY year, location
ORDER BY total_affected ASC;

--Which disaster subtype caused the highest number of homeless people?
SELECT disaster_subtype, SUM(no_homeless) AS total_homeless
FROM Disaster
GROUP BY disaster_subtype
ORDER BY total_homeless DESC;

--Which disaster subtypes had the highest total damages?
SELECT disaster_subtype, SUM(total_damages) AS total_damages
FROM Disaster
GROUP BY disaster_subtype
ORDER BY total_damages DESC

--What was the average number of people affected by each disaster type?
SELECT disaster_type, AVG(total_affected) AS avg_total_affected
FROM Disaster
GROUP BY disaster_type

-- Recommendations
/* Indonesia  be should on red alart: The data showed that the number of disasters 
and the total damages are on increase over the years in the country. Therefore, 
It is important for Indonesian governments and other humanitrain organizations
to increase disaster preparedness measures to reduce the impact of disasters when 
disaster occured*/

/*Improve Disaster Response: The data revealed that many countries have been affected
by disasters, causing casualties, injuries, homelessness, and damages.
Therefore, it is important to improve disaster response measures to mitigate the
negative impact of disasters. More emmergency personnel such as doctors, nurses, 
geologist, divers etc should be trained to increase manpower for rescue mission*/

/*Encourage Disaster Risk Reduction: Based on the analysis, it is evident that certain
disaster subtypes, such as earthquake, floods, drought and wildfare have caused the
highest casualties, injuries, and homelessness. Encouraging disaster risk reduction
measures for these specific disaster subtypes can help mitigate their impact*/

/*Address Climate Change: The analysis revealed that climate-related disasters 
such as floods and droughts are some of the most common types of disasters. 
It is important to address climate change to reduce the frequency and severity 
of these disasters. Countries must educates its citizens on impact of climate change
on my our environment*/

/*Improve Data Collection and Reporting: The quality and completeness of the data
available on disasters can vary widely. Improving data collection and reporting 
mechanisms can help in better understanding the impact of disasters and in developing
more effective disaster risk reduction strategies*/








