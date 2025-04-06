/*
===============================================================
Quality Checks
===============================================================
Script Purpose:
      This script performs various quality checks for data consistency,
      accuracy, and standadization across the 'silver' schema. It 
      includes checks for:
      -Null or duplicate Primary keys
      -Unwanted spcaes in string fields
      -Invalid date ranges and orders
      -Date consistency between erelated fields.

Usage: 
  -Run these checks after data loading Silver layer
  -Investigate and resolve any issues found during checks
===============================================================
*/

SELECT 
cst_id,
COUNT(cst_id)
FROM Silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(cst_id) > 1 OR cst_id IS NULL
;

SELECT 
prd_cost
FROM Silver.crm_product_info
WHERE prd_cost <0 OR prd_cost IS NULL;

SELECT *
FROM  Silver.crm_product_info
WHERE prd_end_dt < prd_start_dt;

SELECT prd_nm 
FROM Silevr.crm_product_info
WHERE prd_nm != TRIM(prd_nm);

SELECT 
sls_due_dt
FROM Silver.crm_sales_details
WHERE sls_due_dt <= 0 OR LENGTH(sls_due_dt) != 8 
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101; 

SELECT
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM  Silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt;

SELECT DISTINCT
sls_sales AS old_sales,
sls_quantity ,
sls_price AS old_price,
CASE
	WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,
CASE 
	WHEN sls_price IS NULL OR sls_price <=0 THEN  sls_sales/ NULLIF(sls_quantity,0)
    ELSE sls_price
END AS sls_price
FROM Silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

SELECT 
bdate
FROM Silver.erp_cust_az12
WHERE bdate < "1942-01-02" OR bdate > current_date(); 

SELECT distinct
gen,
CASE 
	WHEN UPPER(TRIM(gen)) IN ("F", "FEMALE") THEN "Female"
	WHEN UPPER(TRIM(gen)) IN ("M", "MALE") THEN "Male"
    ELSE "n/a"
END AS gen
FROM Silver.erp_cust_az12;

SELECT DISTINCT
cntry,
CASE
	WHEN TRIM(cntry) = "DE" THEN "Germany"
    WHEN TRIM(cntry) IN ("US", "USA") THEN "United States"
    WHEN TRIM(cntry) = ""  OR cntry IS NULL THEN "n/a"
    ELSE TRIM(cntry)
END AS cntry
FROM Silver.erp_loc_a101
ORDER BY cntry;

SELECT
prd_id,
prd_key,
prd_nm,
prd_start_dt,
prd_end_dt,
LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)- INTERVAL 1 DAY AS prd_ex_end_dt
FROM Silver.crm_product_info
WHERE  prd_key IN ("AC-HE-HL-U509-R", "AC-HE-HL-U509");
