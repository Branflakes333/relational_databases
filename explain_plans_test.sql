Explain ANALYZE verbose select * from epa_test.epa_air_quality_primary_index;

explain select * from epa_test.epa_air_quality_primary_index where site_id = 60070008;

explain select * from epa_test.epa_air_quality_primary_index where site_id = 60070008 and date = '2020-01-04';

explain insert into epa_test.epa_air_quality_primary_index values('2021-09-22', 60431001, 23, 120);

explain delete from epa_test.epa_air_quality_primary_index where site_id = 60431001;

select * from epa_test.epa_air_quality_primary_index where site_id = 60070008 ;

-- ---------------
Explain ANALYZE verbose select * from epa_test.epa_air_quality_no_index;

explain select * from epa_test.epa_air_quality_no_index where site_id = 60070008;

explain insert into epa_test.epa_air_quality_no_index values('2021-09-22', 60431001, 23, 120);

explain delete from epa_test.epa_air_quality_no_index where site_id = 60431001;
-- ---------------

Explain ANALYZE verbose select * from epa_test.epa_air_quality_clustered;

explain select * from epa_test.epa_air_quality_clustered where site_id = 60070008;

explain insert into epa_test.epa_air_quality_clustered values('2021-09-22', 60431001, 23, 120);

explain delete from epa_test.epa_air_quality_clustered where site_id = 60431001;