# Changing column name ï»¿id to emp_id

ALTER TABLE hr 
CHANGE COLUMN ï»¿id emp_id varchar(20) NULL; 

describe hr; 

# changing birthdate format text to sql DATE format.

UPDATE hr
SET birthdate =
CASE
    WHEN birthdate LIKE '%/%'
        THEN STR_TO_DATE(birthdate, '%m/%d/%Y')
    WHEN birthdate LIKE '%-%'
        THEN STR_TO_DATE(birthdate, '%d-%m-%Y')
END;

ALTER TABLE hr MODIFY COLUMN birthdate DATE;

# changing hire_date text to date format.

UPDATE hr
SET hire_date =
CASE
    WHEN hire_date LIKE '%/%'
        THEN STR_TO_DATE(hire_date, '%m/%d/%Y')
    WHEN hire_date LIKE '%-%'
        THEN STR_TO_DATE(hire_date, '%d-%m-%Y')
END;
ALTER TABLE hr MODIFY COLUMN hire_date DATE;

# converting termdate blanks to null
UPDATE hr
SET termdate = NULL
where TRIM(termdate) = '';

#converting termdate to proper date

UPDATE hr
SET termdate = DATE(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate IS NOT NULL;
   
ALTER TABLE hr MODIFY COLUMN termdate DATE;


# adding new column 'age'

ALTER TABLE hr ADD COLUMN age INT;

# inserting values to age column using birthdate

UPDATE hr 
SET age = timestampdiff(YEAR,birthdate,CURDATE());
