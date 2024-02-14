-- Load the dataset
data = LOAD '/medical_reviews/Independent_Medical_Reviews_Filled.csv' USING PigStorage(',')
    AS (reference_id: chararray, report_year: int, diagnosis_category: chararray,
        diagnosis_sub_category: chararray, treatment_category: chararray,
        treatment_sub_category: chararray, determination: chararray,
        type: chararray, age_range: chararray, patient_gender: chararray, findings: chararray);

-- Group the data by treatment and diagnosis categories
grouped_data = GROUP data BY (treatment_category, diagnosis_category);

-- Count the number of records in each group and include field names
counts = FOREACH grouped_data GENERATE group.treatment_category AS treatment_category,
                                        group.diagnosis_category AS diagnosis_category,
                                        COUNT(data) AS record_count;

-- Store the result
STORE counts INTO '/output/treatment_diagnosis_correlation' USING PigStorage(',');
