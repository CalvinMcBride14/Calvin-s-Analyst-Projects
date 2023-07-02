/* Datasets taken from Github include:
Accidents_2015.csv
Vehicles_2015.csv
vehicle_types.csv
*/ 

/* After creating schema and tables, used MySql Table Data Import Wizard to populate values */

/* Manually inserted values into "vehicle_types table" */


CREATE SCHEMA accidents;

USE accidents;

CREATE TABLE accident(
	accident_index VARCHAR(13),
    accident_severity INT
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);

CREATE TABLE vehicle_types(
	vehicle_code INT,
    vehicle_type VARCHAR(10)
    );
    
CREATE INDEX accident_index
ON accident(accident_index);

CREATE INDEX accident_index
ON vehicles(accident_index);


INSERT INTO vehicle_types (vehicle_code, vehicle_type)
VALUES
(0, 'Pedestrian'),
(1,	'Cyclist'), 
(2,	'Motorcycle 50cc and under rider or passenger'), 
(3,	'Motorcycle 125cc and under rider or passenger)'),
(4,	'Motorcycle over 125cc and up to 500cc rider or  passenger'),
(5,	'Motorcycle over 500cc rider or passenger'),
(8,	'Taxi/Private'),
(10, 'Minibus (8 - 16 passenger seats) occupant'),
(11, 'Bus or coach occupant (17 or more pass seats'),
(16, 'Horse rider'),
(17, 'Agricultural vehicle occupant'),
(19, 'Van'),
(20, 'Goods vehicle (over 3.5t. and under 7.5t.)'),
(21, 'Goods vehicle (7.5 tonnes mgw and over)'),
(22, 'Mobility scooter rider'),
(23, 'Electric motorcycle rider or passenger'),
(90, 'Other vehicle occupant'),
(97, 'Motorcycle - unknown cc rider or passenger'),
(98, 'Goods vehicle (unknown weight) occupant');


/* Beginning of Data Exploration */


/* Find Accident Severity and Total Accidents per Vehicle Type */

SELECT vt.vehicle_type AS 'Vehicle Type', a.accident_severity AS 'Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1, 2
ORDER BY 2,3;

/* Average Severity by vehicle type */

SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1
ORDER BY 2 DESC;



/* Find the average severity and total accidents by Motorcyle */

SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
WHERE vt.vehicle_type LIKE '%otorcycle%'
GROUP BY 1
ORDER BY 2,3;

