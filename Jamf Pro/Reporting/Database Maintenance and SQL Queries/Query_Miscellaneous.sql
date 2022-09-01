-- Queries on Miscellaneous Configurations
-- Most of these should be working, but some may still be a work in progress.
-- These are formatted for readability, just fyi.

-- ##################################################
-- Computer Inventory Submissions

-- Count the number inventory submissions per day per computer
SELECT DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY)) AS "Date", computer_id AS "Computer ID", COUNT(*) AS "Inventory Reports"
FROM reports
WHERE 
	reports.date_entered_epoch > unix_timestamp(date_sub(now(), INTERVAL 1 DAY))*1000
	AND computer_id != 0
GROUP BY DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY)), computer_id
ORDER BY COUNT(*) DESC


-- Count the number of inventory submissions per day
SELECT DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY)) AS "Date", COUNT(*) AS "Inventory Reports"
FROM reports
WHERE computer_id != 0
GROUP BY DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY))
ORDER BY DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY)) DESC


-- Count the number of inventory submissions per day in the last 7 days
SELECT DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY)) AS "Date", COUNT(*) AS "Inventory Reports"
FROM reports
WHERE 
	reports.date_entered_epoch > unix_timestamp(date_sub(now(), INTERVAL 7 DAY))*1000
	AND computer_id != 0
GROUP BY DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY))
ORDER BY DATE(date_sub(from_unixtime(reports.date_entered_epoch/1000), INTERVAL 1 DAY)) DESC


-- ##################################################
-- Printers

-- Unused Printers
SELECT DISTINCT printers.printer_id, printers.display_name
FROM printers 
WHERE printers.printer_id NOT IN ( 
    SELECT printer_id FROM policy_printers 
    );


-- ##################################################
-- Queries to check configuration profiles would likely be useful
