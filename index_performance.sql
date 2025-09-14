CREATE TABLE epa_test.epa_air_quality_no_index
(
	date DATE DEFAULT CURRENT_DATE,
	site_id INTEGER CHECK (site_id > 0),
	daily_mean_pm10_concentration REAL NOT NULL,	
	daily_aqi_value REAL NOT NULL
);

COPY epa_test.epa_air_quality_no_index 
FROM '/Users/brandonminer/usf/relational_databases/data/epa_air_quality.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO epa_test.epa_air_quality_no_index VALUES ('2020-08-01', 60070008, 29, 20);

CREATE TABLE epa_test.epa_air_quality_primary_index
(
	date DATE DEFAULT CURRENT_DATE,
	site_id INTEGER CHECK (site_id > 0),
	daily_mean_pm10_concentration REAL NOT NULL,
	daily_aqi_value REAL NOT NULL,
	PRIMARY KEY (date, site_id)
);

COPY epa_test.epa_air_quality_primary_index 
FROM '/Users/brandonminer/usf/relational_databases/data/epa_air_quality.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO epa_test.epa_air_quality_primary_index VALUES ('2020-08-01', 60070008, 29, 20);

CREATE TABLE epa_test.epa_site_location
(
	site_id INTEGER CHECK (site_id > 0),
	site_name VARCHAR(100) NOT NULL,
	site_latitude REAL NOT NULL,
	site_longitude REAL NOT NULL,
	county VARCHAR(20) NOT NULL,
	state VARCHAR(20) NOT NULL,
	PRIMARY KEY (site_id)
);

CREATE TABLE epa_test.epa_air_quality
(
	date DATE DEFAULT CURRENT_DATE,
	site_id INTEGER CHECK (site_id > 0),
	daily_mean_pm10_concentration REAL NOT NULL,
	daily_aqi_value REAL NOT NULL,
	PRIMARY KEY (date, site_id),
	FOREIGN KEY (site_id) 
	REFERENCES epa_site_location (site_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);
COPY epa_test.epa_site_location 
FROM '/Users/brandonminer/usf/relational_databases/data/epa_site_location.csv'
DELIMITER ','
CSV HEADER;

COPY epa_test.epa_air_quality
FROM '/Users/brandonminer/usf/relational_databases/data/epa_air_quality.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO epa_test.epa_air_quality VALUES ('2020-08-01', 60070008, 29, 20);

-- Clustering

CREATE TABLE epa_test.epa_air_quality_clustered
(
	date DATE DEFAULT CURRENT_DATE,
	site_id INTEGER CHECK (site_id > 0),
	daily_mean_pm10_concentration REAL NOT NULL,
	daily_aqi_value REAL NOT NULL
);
-- 26ms

COPY epa_test.epa_air_quality_clustered
FROM '/Users/brandonminer/usf/relational_databases/data/epa_air_quality.csv'
DELIMITER ','
CSV HEADER;
-- 16ms

CREATE INDEX epa_air_quality_btree
ON epa_test.epa_air_quality_clustered 
USING btree (site_id);
-- 8ms

CLUSTER epa_test.epa_air_quality_clustered USING epa_air_quality_btree;
--15ms

INSERT INTO epa_test.epa_air_quality_clustered VALUES ('2020-08-01', 60070008, 29, 20);
-- 4ms

-- Clustering index on a table --


