
CREATE DATABASE IF NOT EXISTS src_credit_card_system ; 
USE src_credit_card_system;

CREATE EXTERNAL TABLE IF NOT EXISTS src_cdw_sapp_d_branch    --with external table, only the data need to be dropped each time
(branch_code decimal(9), 
 branch_name varchar(25),
 branch_street varchar(30),
 branch_city varchar(30),
 branch_state varchar(30),
 branch_zip decimal(7),
 branch_phone varchar(13),
 last_updated timestamp)
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n' STORED AS TEXTFILE 
 LOCATION '${src_OUTPUT}/src_cdw_sapp_d_branch';


CREATE EXTERNAL TABLE IF NOT EXISTS src_cdw_sapp_f_credit_card 
(transaction_id decimal(9),
 cust_cc_no varchar(16),
 timeid     varchar(8),
 cust_ssn   decimal(9),
 branch_code decimal(10),
 transaction_type varchar(30),
 transaction_value decimal(20,3) )
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n' STORED AS TEXTFILE
 LOCATION '${src_OUTPUT}/src_cdw_sapp_f_credit_card';


CREATE EXTERNAL TABLE IF NOT EXISTS src_cdw_sapp_d_customer (
  CUST_SSN DECIMAL(9),
  CUST_F_NAME VARCHAR(40),
  CUST_M_NAME VARCHAR(40),
  CUST_L_NAME VARCHAR(40),
  CUST_CC_NO VARCHAR(16),
  CUST_STREET VARCHAR(38),
  CUST_CITY VARCHAR(30),
  CUST_STATE VARCHAR(30),
  CUST_COUNTRY VARCHAR(30),
  CUST_ZIP DECIMAL(7,0),
  CUST_PHONE VARCHAR(8),
  CUST_EMAIL VARCHAR(40),
  LAST_UPDATED TIMESTAMP)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' STORED AS TEXTFILE
LOCATION '${src_OUTPUT}/src_cdw_sapp_d_customer';


CREATE EXTERNAL TABLE IF NOT EXISTS src_cdw_sapp_d_time (
  transaction_id decimal(9),
  timeid varchar(8),
  day decimal(2),
  month decimal(2),
  quarter varchar(8),
  year decimal(4)
  ) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' STORED AS TEXTFILE 
LOCATION '${src_OUTPUT}/src_cdw_sapp_d_time';


