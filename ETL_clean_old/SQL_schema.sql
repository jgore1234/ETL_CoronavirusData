
CREATE TABLE state_edu_attained_dim (
   state_edu_attained_id VARCHAR(30) PRIMARY KEY,
   state_edu_attained VARCHAR(30)
);

CREATE TABLE state_earning_edu_dim (
   state_earning_edu_id VARCHAR(30) PRIMARY KEY,
   state_earning_edu VARCHAR(30)
);

CREATE TABLE race_data (
   race_id VARCHAR(30) PRIMARY KEY,
   state_pop_race VARCHAR
);


CREATE TABLE state_pop_data (
   state_id VARCHAR(30) PRIMARY KEY,
   state_name VARCHAR(30),
   state_initial VARCHAR(30),
   state_population VARCHAR(30),
   state_pop_growth VARCHAR(30),
   state_us_percent VARCHAR(30),
   state_density VARCHAR(30)
);


CREATE TABLE population_earnings (
   state_id VARCHAR(30) REFERENCES state_pop_data(state_id),
   state_earning_edu_id VARCHAR(30) REFERENCES state_earning_edu_dim(state_earning_edu_id),
   state_earning_average VARCHAR(30),
   state_earning_male VARCHAR(30),
   state_earning_female VARCHAR(30)
);

CREATE TABLE covid_data (
   state_id VARCHAR(30) REFERENCES state_pop_data(state_id),
   TotalCases VARCHAR(30),
   NewCases VARCHAR(30),
   TotalDeaths VARCHAR(30),
   NewDeaths VARCHAR(30),
   TotalRecovered VARCHAR(30),
   ActiveCases VARCHAR(30),
   TotalTests VARCHAR(30),
   date VARCHAR(30)
);

CREATE TABLE education_map (
   state_earning_edu_id VARCHAR(30) REFERENCES state_earning_edu_dim(state_earning_edu_id),
   state_edu_attained_id VARCHAR(30) REFERENCES state_edu_attained_dim(state_edu_attained_id)
);

CREATE TABLE population_eduattain (
   state_id VARCHAR(30) REFERENCES state_pop_data(state_id),
   state_edu_attained_id VARCHAR(30) REFERENCES state_edu_attained_dim(state_edu_attained_id),
   state_edu_attained_count VARCHAR(30),
   state_edu_attained_percentage VARCHAR(30)   
);


CREATE TABLE population_byrace (
   state_id VARCHAR(30) REFERENCES state_pop_data(state_id),
   race_id VARCHAR(30) REFERENCES race_data(race_id),
   state_pop_race_count VARCHAR(30),
   state_pop_race_percentage VARCHAR(30)   
);
