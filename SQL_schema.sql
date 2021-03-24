DROP TABLE IF EXISTS "Covid_data";
CREATE TABLE "Covid_data" (
	"covid_id" INT NOT NULL PRIMARY KEY,
    "state_id" INT   NOT NULL,
    "state_name" VARCHAR   NOT NULL,
    "Totalcases" FLOAT   NOT NULL,
    "Newcases" FLOAT  NULL,
    "Totaldeaths" FLOAT  NULL,
    "Newdeaths" FLOAT  NULL,
    "Totalrecovered" FLOAT  NULL,
    "Activecases" FLOAT NULL,
    "TotalTests" FLOAT  NULL,
	"state_population" FLOAT NULL,
	"date" VARCHAR   NOT NULL
);
DROP TABLE IF EXISTS "States";
CREATE TABLE "States" (
    "state_id" INT   NOT NULL,
    "state_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_States" PRIMARY KEY (
        "state_id"
     )
);
DROP TABLE IF EXISTS "Population_Density";
CREATE TABLE "Population_Density" (
	"pop_density_id" INT NOT NULL,
    "state_id" INT   NOT NULL,
    "state_name" VARCHAR   NOT NULL,
    "state_population" FLOAT   NOT NULL,
    "state_pop_growth" FLOAT   NOT NULL,
    "state_us_percent" FLOAT   NOT NULL,
    "state_density" FLOAT   NOT NULL,
    CONSTRAINT "pk_Population_Density" PRIMARY KEY (
        "pop_density_id"
     )
);
DROP TABLE IF EXISTS "Population_edu_attain";
CREATE TABLE "Population_edu_attain" (
	"pop_edu_attain_id" INT NOT NULL,
    "state_id" INT   NOT NULL,
    "state_name" VARCHAR   NOT NULL,
    "state_edu_attained" VARCHAR   NOT NULL,
    "state_edu_attained_count" FLOAT   NOT NULL,
    "state_edu_attained_percentage" FLOAT   NOT NULL,
	"education_id" INT   NOT NULL,
    CONSTRAINT "pk_Population_edu_attain" PRIMARY KEY (
        "pop_edu_attain_id"
     )
);
DROP TABLE IF EXISTS "Population_Earnings";
CREATE TABLE "Population_Earnings" (
	"pop_earnings_id" INT NOT NULL,
    "state_id" INT   NOT NULL,
    "state_name" VARCHAR   NOT NULL,
    "state_earning_edu" VARCHAR NOT NULL,
    "state_earning_average" FLOAT   NOT NULL,
    "state_earning_male" FLOAT   NOT NULL,
    "state_earning_female" FLOAT   NOT NULL,
	"education_id" INT NOT NULL,
    CONSTRAINT "pk_Population_Earnings" PRIMARY KEY (
        "pop_earnings_id"
     )
);

DROP TABLE IF EXISTS "Population_by_race";
CREATE TABLE "Population_by_race" (
	"race_pop_id" INT NOT NULL,
    "state_id" INT   NOT NULL,
    "state_name" VARCHAR   NOT NULL,
    "race_id" INT   NOT NULL,
    "state_pop_race" VARCHAR   NOT NULL,
    "state_pop_race_count" FLOAT   NOT NULL,
    "state_pop_race_percentage" FLOAT   NOT NULL,
    CONSTRAINT "pk_Population_by_race" PRIMARY KEY (
        "race_pop_id"
     )
);
DROP TABLE IF EXISTS "Education_id";
CREATE TABLE "Education_id" (
    "education_id" INT   NOT NULL,
    "state_edu_attained" VARCHAR  NOT NULL,
    "state_earning_edu" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Education_id" PRIMARY KEY (
        "education_id"
     )
);
DROP TABLE IF EXISTS "race_id";
CREATE TABLE "race_id" (
    "race_id" INT   NOT NULL,
    "state_pop_race" VARCHAR   NOT NULL,
    CONSTRAINT "pk_race_id" PRIMARY KEY (
        "race_id"
     )
);

ALTER TABLE "Covid_data" ADD CONSTRAINT "fk_Covid_data_state_id" FOREIGN KEY("state_id")
REFERENCES "States" ("state_id");

ALTER TABLE "Population_Density" ADD CONSTRAINT "fk_Population_Density_state_id" FOREIGN KEY("state_id")
REFERENCES "States" ("state_id");

ALTER TABLE "Population_edu_attain" ADD CONSTRAINT "fk_Population_edu_attain_state_id" FOREIGN KEY("state_id")
REFERENCES "States" ("state_id");

ALTER TABLE "Population_edu_attain" ADD CONSTRAINT "fk_Population_edu_attain_State_edu_attained" FOREIGN KEY("education_id")
REFERENCES "Education_id" ("education_id");


ALTER TABLE "Population_Earnings" ADD CONSTRAINT "fk_Population_Earnings_state_id" FOREIGN KEY("state_id")
REFERENCES "States" ("state_id");

ALTER TABLE "Population_by_race" ADD CONSTRAINT "fk_Population_by_race_state_id" FOREIGN KEY("state_id")
REFERENCES "States" ("state_id");

ALTER TABLE "Population_Earnings" ADD CONSTRAINT "fk_Education_id_state_earning_edu" FOREIGN KEY("education_id")
REFERENCES "Education_id" ("education_id");


ALTER TABLE "Population_by_race" ADD CONSTRAINT "fk_race_id_race_id" FOREIGN KEY("race_id")
REFERENCES "race_id" ("race_id");
