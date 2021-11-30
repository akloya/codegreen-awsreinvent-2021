-- TABLE CREATE QUERY FOR SPEC_FULL

CREATE EXTERNAL TABLE `spec_power_full`(
  `hardware vendor test sponsor` string COMMENT 'from deserializer', 
  `system enclosure ` string COMMENT 'from deserializer', 
  `date submitted` string COMMENT 'from deserializer', 
  `nodes` string COMMENT 'from deserializer', 
  `jvm vendor` string COMMENT 'from deserializer', 
  `cpu description` string COMMENT 'from deserializer', 
  `mhz` string COMMENT 'from deserializer', 
  `chips` string COMMENT 'from deserializer', 
  `cores` string COMMENT 'from deserializer', 
  `total threads` string COMMENT 'from deserializer', 
  `total memory` string COMMENT 'from deserializer', 
  `ssj_ops ` string COMMENT 'from deserializer', 
  `avg.watts` string COMMENT 'from deserializer', 
  `avg_watts_active_idle` string COMMENT 'from deserializer', 
  `results` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
  'separatorChar'=',') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/spec-full'
TBLPROPERTIES (
  'classification'='csv', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1638223926')

-- Table Create Data for aws_instances

CREATE EXTERNAL TABLE `aws-instances`(
  `instance_family` string, 
  `microarchitectrure` string, 
  `vcpus` string, 
  `memory` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/aws-instances'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1638221846')

-- Table create query for grid carbon 
CREATE EXTERNAL TABLE `grid_emissions_factors`(
  `country` string COMMENT 'from deserializer', 
  `nerc_region` string COMMENT 'from deserializer', 
  `co2e` string COMMENT 'from deserializer', 
  `source` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
  'separatorChar'=',') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/grid_emissions_factors'
TBLPROPERTIES (
  'classification'='csv', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1638225025')

--   Table create query for manufacturing emmission factor.
CREATE EXTERNAL TABLE `manufacturing_emissions_factors`(
  `ratio` string, 
  `value` string, 
  `comment` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/manufacturing_emissions_factors'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1638222018')

--  Table query to create intel architecture 
CREATE EXTERNAL TABLE `intel-cascadelake`(
  `cpu` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/intel-cascadelake'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'transient_lastDdlTime'='1638225132')

CREATE EXTERNAL TABLE `intel-broadwell`(
  `cpu` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/intel-broadwell'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'transient_lastDdlTime'='1638225103')

CREATE EXTERNAL TABLE `intel-coffeelake`(
  `cpu` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://reinvent-carbon-outputs/intel-coffeelake'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'transient_lastDdlTime'='1638225166')
  
  
-- Query to watt hrs per vCPUs
SELECT AVG("avg_watts_active_idle"/"total threads") FROM reinvent.spec_power_full WHERE "cpu description" IN (SELECT cpu from reinvent.amd_epyc_gen3)
