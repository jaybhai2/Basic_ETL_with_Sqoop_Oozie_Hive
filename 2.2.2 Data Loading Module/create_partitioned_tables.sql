
CREATE DATABASE IF NOT EXISTS credit_card_system;
USE credit_card_system;

CREATE TABLE IF NOT EXISTS cdw_sapp_d_branch     --MAIN TABLE PARTITIONED, GET OVERWRITTEN EACH TIME
(branch_code decimal(9), 
 branch_name varchar(25),
 branch_street varchar(30),
 branch_city varchar(30),
 branch_zip decimal(7),
 branch_phone varchar(13),
 last_updated timestamp) PARTITIONED BY (branch_state varchar(30))
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n' STORED AS TEXTFILE 
 LOCATION '${OUTPUT}/cdw_sapp_d_branch';

SET hive.exec.dynamic.partition.mode=nonstrict;
INSERT OVERWRITE TABLE cdw_sapp_d_branch PARTITION(branch_state) 
SELECT branch_code, branch_name, branch_street, branch_city, branch_zip, branch_phone, last_updated, branch_state 
FROM src_credit_card_system.src_cdw_sapp_d_branch;

-- ----------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cdw_sapp_f_credit_card 
(transaction_id decimal(9),
 cust_cc_no varchar(16),
 timeid     varchar(8),
 cust_ssn   decimal(9),
 branch_code decimal(10),
 transaction_value decimal(20,3)) PARTITIONED BY (transaction_type varchar(30))
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n' STORED AS TEXTFILE
 LOCATION '${OUTPUT}/cdw_sapp_f_credit_card';

 INSERT OVERWRITE TABLE cdw_sapp_f_credit_card PARTITION (transaction_type) 
 SELECT transaction_id, cust_cc_no, timeid, cust_ssn, branch_code, transaction_value, transaction_type 
 FROM src_credit_card_system.src_cdw_sapp_f_credit_card; 

-- ----------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cdw_sapp_d_customer(
  CUST_SSN DECIMAL(9),
  CUST_F_NAME VARCHAR(40),
  CUST_M_NAME VARCHAR(40),
  CUST_L_NAME VARCHAR(40),
  CUST_CC_NO VARCHAR(16),
  CUST_STREET VARCHAR(38),
  CUST_CITY VARCHAR(30),
  CUST_COUNTRY VARCHAR(30),
  CUST_ZIP DECIMAL(7,0),
  CUST_PHONE VARCHAR(8),
  CUST_EMAIL VARCHAR(40),
  LAST_UPDATED TIMESTAMP) PARTITIONED BY (CUST_STATE VARCHAR(30))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' STORED AS TEXTFILE
LOCATION '${OUTPUT}/cdw_sapp_d_customer';

INSERT OVERWRITE TABLE CDW_SAPP_D_CUSTOMER PARTITION (CUST_STATE) 
SELECT CUST_SSN, CUST_F_NAME, CUST_M_NAME, CUST_L_NAME, CUST_CC_NO, CUST_STREET, CUST_CITY, CUST_COUNTRY, 
CUST_ZIP, CUST_PHONE, CUST_EMAIL, LAST_UPDATED , CUST_STATE FROM src_credit_card_system.src_CDW_SAPP_D_CUSTOMER;

-- ----------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cdw_sapp_d_time (
  transaction_id decimal(9),
  timeid varchar(8),
  day decimal(2),
  month decimal(2),
  year decimal(4)
  ) PARTITIONED BY (quarter varchar(8)) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
STORED AS TEXTFILE 
LOCATION '${OUTPUT}/cdw_sapp_d_time';

INSERT OVERWRITE TABLE cdw_sapp_d_time PARTITION (quarter) 
SELECT transaction_id,timeid,day,month,year,quarter FROM src_credit_card_system.src_cdw_sapp_d_time;

