# Diagnosis Trends in Medical Reviews

This project involves analyzing the "Independent Medical Reviews" dataset using Hadoop/MapReduce with Apache Pig for data processing, Apache Hive for data storage, and Tableau for data visualization.

## Prerequisites
- Cloudera Quickstart Docker Image
- Apache Pig and Hive (included in the Cloudera Docker image)
- Tableau Desktop with ODBC driver installed
- Access to the "Independent Medical Reviews" dataset
- Copy pig script and the "Independent Medical Reviews" dataset to the docker container.
## Setup and Execution Guide

Once the pipeline is setup you can access the tableau workbook to view the dashboard
You will need to edit the connection to use your IP Address.

**Username** - hive

**Password** - cloudera

### Setting Up the Environment
1. Start the Cloudera Docker container:
   ```bash
   docker run --hostname=quickstart.cloudera --privileged=true -t -i --publish-all=true -p 8888:8888 -p 7180:7180 -p 80:80 cloudera/quickstart /usr/bin/docker-quickstart
Access the Cloudera environment through a web browser or terminal.

### Data Processing with Apache Pig

1. Load the dataset into HDFS:
```bash
hdfs dfs -put Independent_Medical_Reviews_Filled.csv /medical_reviews/
```

2. Execute the Pig script for data processing:
```bash
pig diagnosis_correlation.pig
```

### Data Storage in Hive
1. Access Hive and create a table for the processed data:

```bash
CREATE TABLE medical_data (
    treatment_category STRING,
    diagnosis_category STRING,
    case_count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
```

2. Load the data into the Hive table:

```bash
LOAD DATA INPATH '/output/treatment_diagnosis_correlation' INTO TABLE medical_data;
```
### Visualization in Tableau
1. Set up an ODBC connection in Tableau to the Hive server.
2. Import data from the medical_data Hive table with the cloudera hadoop connection in Tableau.
3. Login using the username "hive" and password "cloudera". 
4. Create the heatmap visualizations.

