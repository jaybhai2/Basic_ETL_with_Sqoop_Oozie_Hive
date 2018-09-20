# Basic_ETL_with_Sqoop_Oozie

# 2.2.1 Data Extraction and Transportation with Sqoop
-sqoop_metastore.txt

In the folder above, you will see sqoop_metastore.txt. This files contains the individual sqoop import command that embedded in Oozie workflow and store in metastore. When running optimized workflow, you must refer to sqoop_metastore.txt . See section Oozie (Sqoop and Hive optimized) for more details.

# 2.2.2 Data Loading Module
-create_src_table.sql
-create_partitioned_table.sql

After data being loading into HDFS, Hive tables are created and used to represent the imported data in an RDBMS manner. In addition, partitioned tables are created for query efficiency. These parts are done by two hive script, ‘create_src_table.sql’ which create source table for the data, and ‘create_partitioned_table.sql’ which create partitioned table inserted from the source tables. These two sql script can also be found in above folder and shall be uploaded to HDFS when running workflow.

# 2.2.4 Process Optimization Module
-lib
-cdw_workflow2.xm
-coordinator2.xml
-job.propertie
-password.txt

To run the workflow, open the job.properties file and edit the frequency, start and ending date of the workflow as needed. Frequency is expressed in cron format. The default value is ‘0/20 8-18 * * 2-6 ’ which represent every 20 minute from 8am to 4pm Monday to Friday. Be advised that if you run on VM, your host system time zone might be different than the VM/Oozie time, be sure the address the difference. Input a start daytime that is close to today’s datetime, if start daytime is too historical, Oozie would runs the workflow continuously to catch up the time. 
Set the end date time as needed.

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
