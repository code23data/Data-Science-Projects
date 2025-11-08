COPY employee 
FROM 'C:\Program Files\PostgreSQL\18\data\store data\employee.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"'
);