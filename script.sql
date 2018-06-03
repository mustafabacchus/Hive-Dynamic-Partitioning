#1
CREATE TABLE int_patent (
patent BIGINT, gyear BIGINT, gdate BIGINT, appyear BIGINT, country STRING, 
poststate STRING, assignee BIGINT, asscode BIGINT, claims BIGINT, nclass BIGINT, 
cat BIGINT, subcat BIGINT, cmade BIGINT, creceive BIGINT, ratiocit DECIMAL(20, 7), 
general DECIMAL(20, 7), original DECIMAL(20, 7), fwdaplag DECIMAL(20, 7), 
bckgtlag DECIMAL(20, 7), selfctub DECIMAL(20, 7), selfctlb DECIMAL(20, 7), 
secdupbd DECIMAL(20, 7), secdlwbd DECIMAL(20, 7))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','  
LOCATION '/patent'
TBLPROPERTIES ("skip.header.line.count"="1");




#2
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

CREATE EXTERNAL TABLE ext_dyn_patent (
patent BIGINT, gdate BIGINT, appyear BIGINT, country STRING, 
poststate string, assignee BIGINT, asscode BIGINT, claims BIGINT, nclass BIGINT, 
cat BIGINT, subcat BIGINT, cmade BIGINT, creceive BIGINT, ratiocit DECIMAL(20, 7), 
general DECIMAL(20, 7), original DECIMAL(20, 7), fwdaplag DECIMAL(20, 7), 
bckgtlag DECIMAL(20, 7), selfctub DECIMAL(20, 7), selfctlb DECIMAL(20, 7), 
secdupbd DECIMAL(20, 7), secdlwbd DECIMAL(20, 7))
PARTITIONED BY (gyear BIGINT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFIlE;

INSERT OVERWRITE TABLE ext_dyn_patent
PARTITION (gyear)
SELECT patent, gdate, appyear, country, poststate, assignee, asscode, claims, 
nclass, cat, subcat, cmade, creceive, ratiocit, general, original, fwdaplag, bckgtlag, 
selfctub, selfctlb, secdupbd, secdlwbd, gyear
FROM temp_patent;



#3
SELECT COUNT(*) FROM ext_dyn_patent WHERE gyear = 1963;




#4
SELECT country, COUNT(*) FROM ext_dyn_patent WHERE gyear = 1999 GROUP BY country;
