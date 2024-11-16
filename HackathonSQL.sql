
-- Average thefts per week
SELECT COUNT(vehicle_id) / (EXTRACT(EPOCH FROM AGE(MAX(date_stolen), MIN(date_stolen))) / (7 * 86400)) AS avg_weekly_thefts
FROM stolen_vehicles;


-- Average thefts in autumn
SELECT COUNT(vehicle_id) / 3 AS avg_autumn_thefts
FROM stolen_vehicles
WHERE EXTRACT(MONTH FROM date_stolen) IN (9, 10, 11);

-- Most popular vehicle type in autumn
SELECT vehicle_type, COUNT(vehicle_id) AS theft_count
FROM stolen_vehicles
WHERE EXTRACT(MONTH FROM date_stolen) IN (9, 10, 11)
GROUP BY vehicle_type
ORDER BY theft_count DESC
LIMIT 1;


-- Top three manufacturers by theft count
WITH TopManufacturers AS (
    SELECT make_id
    FROM stolen_vehicles
    GROUP BY make_id
    ORDER BY COUNT(vehicle_id) DESC
    LIMIT 3
)

-- Count thefts from top manufacturers in even months
SELECT COUNT(vehicle_id) AS "thefts count from top3 makers"
FROM stolen_vehicles
WHERE make_id IN (SELECT make_id FROM TopManufacturers)
AND EXTRACT(MONTH FROM date_stolen) IN (2, 4, 6, 8, 10, 12);


-- Count the number of stolen vehicles for each color by region.
SELECT l.region, sv.color, COUNT(sv.vehicle_id) AS theft_count
FROM stolen_vehicles sv
JOIN locations l ON sv.location_id = l.location_id
GROUP BY l.region, sv.color
ORDER BY l.region, theft_count DESC;




