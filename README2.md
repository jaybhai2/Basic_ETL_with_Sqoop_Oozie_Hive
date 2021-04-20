# DE03-NY
case study submittion



# Core Java
  -	2.1.1 Customer and Transaction Detail Module
    -	Credit_Card_Management_System
    -	db
    
We will use Eclipse IDE to execute the application.
It is assumed you have basic knowledge of Eclipse or any IDE, so no detailed steps provided. 
To run the application, import entire project zip file to Eclipse using ‘Archive File’ import. Add mysql-connector jar file to the library by right click on the project and click ‘configure build path’, add connector as external jar. Ensure login.property file is located in the project directory (same level as src folder). This is the file that contain database information that you want to connect. If it is located at other directory, ensure to specify full path in OperationUI class. getConnection Method.
You may change the password or username in the file according to your database.  

# RDBMS/mySQL Description:  
  -	2.1.1 Customer and Transaction Detail Module
    -	CDW_SAPP.sql’  

mySQL database in used in the core java application. The CDW_SAPP sql script is attached in the db folder along with jave applicatipn folder.  To run the script, open cmd prompt. First, cd to the folder that contain CDW_SAPP.sql. 
Second, login to your db server by running ‘mysql -r <username> -p’ and enter your password . Then, type command ‘source CDW_SAPP.sql’ . This will create all database and tables required. This is the database that connected to java application through JDBC.  
Tables: 
  CDW_SAPP_BRANCH
  CDW_SAPP_CUSTOMER
  CDW_SAPP_CREDITCARD 
Note: it is recommended for the username to be ‘root’ so that ETL part’s username does not have to be modified. 

# Hadoop/hdfs/dataware housing 
  -	2.2.1 Data Extraction and Transportation with Sqoop
    -	sqoop_import.txt
    -	sqoop_metastore.txt

In the folder above, you will see following files; sqoop_import.txt  and sqoop_metastore.txt. There files contains the individual sqoop import command that embedded in Oozie workflow. Sqoop_import.txt acts as reference guide only, you will not be required to using it when you running unoptimized workflow. When running optimized workflow, you must refer to sqoop_metastore.txt . See section Oozie (Sqoop and Hive optimized) for more details.

# Hive and Partition
  -	2.2.2 Data Loading Module
    - create_src_table.sql
    - create_partitioned_table.sql

After data being loading into HDFS, Hive tables are created and used to represent the imported data in an RDBMS manner. In addition, partitioned tables are created for query efficiency. These parts are done by two hive script, ‘create_src_table.sql’ which create source table for the data, and ‘create_partitioned_table.sql’ which create partitioned table inserted from the source tables. These two sql script can also be found in above  folder and shall be uploaded to HDFS when running workflow.

# Oozie (Sqoop and Hive)
  -	2.2.3 Automating the Process with Oozie
    -	cdw_workflow1.xml
    -	coordinator1.xml
    -	job.properties
    
To run the workflow, open the job.properties file and edit the frequency, start and ending date of the workflow as needed. Frequency is expressed in cron format. The default value is ‘0/20 8-18 * * 2-6 ’ which represent every 20 minute from 8am to 4pm Monday to Friday. Be advised that if you run on VM, your host system time zone might be different than the VM/Oozie time, be sure the address the difference. Input a start daytime that is close to today’s datetime, if start daytime is too historical, Oozie would runs the workflow continuously to catch up the time. 
Set the end date time as needed. Other variables are may be changed if you have to. 

To run the workflow, perform following actions;

1)	Using Ambari UI, create a new folder in hdfs /user/maria_dev and name it as /cdw_ooziejob
2)	Upload all files in 2.2.3 folder to /user/maria_dev /cdw_ooziejob, except job.properties.
3)	Upload both sql scripts in 2.2.2 folder to /cdw_ooziejob.
4)	job.properties should be on the local/linux machine. If you are using VM, move the file to VM.
5)	Open command prompt on Linux machine and cd to the directory where job.properties is located. 
6)	Run the following command:
oozie job   -oozie http://localhost:11000/oozie  -config  job.properties  -run

To kill a job use: oozie job -oozie http://localhost:11000/oozie -kill {job id}

# Oozie (Sqoop and Hive optimized)
  -	2.2.4 Process Optimization Module
    -	lib
    -	cdw_workflow2.xm
    -	coordinator2.xml
    -	job.propertie
    -	password.txt
   
To run the workflow, open the job.properties file and edit the frequency, start and ending date of the workflow as described in previous section.
To run the workflow, perform following actions;

1)	Using Ambari UI, create a new folder in hdfs /user/maria_dev and name it as /cdw_ooziejob
2)	Upload all files in 2.2.4 folder to /cdw_ooziejob, except job.properties.
3)	Upload both sql script in 2.2.2 folder to /cdw_ooziejob
4)	job.properties should be on the local/linux machine. If you are using VM, move the file to VM.
5)	Now, this ETL required sqoop metastore. Open command prompt, run: 
nohup sqoop-metastore &
		Meastore will be running on the back end. 
6)	Go to 2.2.1 folder, open sqoop_metastore.txt. This file contain all metastore job creation command required for this ETL. Read the note and run each sqoop metastore job one by one. 
7)	On the command prompt, cd to the directory where job.properties is located. 
8)	Run the following command:
oozie job   -oozie http://localhost:11000/oozie  -config  job.properties  -run

To kill a job use: oozie job -oozie http://localhost:11000/oozie -kill {job id}

Note: Metastore does not save the database password, so there is password.txt containing the password for your db server.

# Visualization
  -	2.2.5 Data Visualization
  
This file contains HiveQL to perform analysis on credit card transaction database including result table and graph.
