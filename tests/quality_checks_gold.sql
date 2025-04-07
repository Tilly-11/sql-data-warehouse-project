/*
===============================================================
Quality Checks
===============================================================
Script Purpose:
      This script performs various quality checks to validate the integrity,
      consistency and accuracy of the 'Gold' layer.
It includes checks for:
      -Uniqueness of surrogate keys in dimension tables.
      -Referential integrity between fact and dimension tables.
Usage: 
  -Run these checks after data loading, the Silver layer
  -Investigate and resolve any issues found during checks
===============================================================
*/


SELECT COUNT(*) FROM (
SELECT
ci.cst_id,
ci.cst_key,
ci.cst_firstname,
ci.cst_lastname,
ci.cst_marital_status,
ci.cst_gndr,
ci.cst_create_date,
ca.bdate,
ca.gen,
la.cntry
FROM Silver.crm_cust_info AS ci
LEFT JOIN Silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid
) t 
GROUP BY cst_id
HAVING COUNT(*) > 1;


ALTER TABLE Silver.crm_cust_info
CHANGE cst_marital_status g VARCHAR(50); 

ALTER TABLE Silver.crm_cust_info
CHANGE cst_gndr cst_marital_status VARCHAR(50); 

ALTER TABLE Silver.crm_cust_info
CHANGE g cst_gndr VARCHAR(50); 


SELECT DISTINCT
ci.cst_gndr,
ca.gen,
CASE WHEN ci.cst_gndr != "n/a" THEN ci.cst_gndr  --crm is the master for customer information
	ELSE COALESCE(ca.gen, "n/a")
END AS new_gen
FROM Silver.crm_cust_info AS ci
LEFT JOIN Silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid
ORDER BY 1,2;


SELECT prd_key, COUNT(*) FROM(
SELECT
	pn.prd_id,
	pn.prd_key,
	pn.prd_nm,
	pn.prd_cost,
	pn.prd_line,
	pn.prd_start_dt,
	pn.prd_end_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
FROM Silver.crm_product_info as pn
LEFT JOIN Silver.erp_px_cat_g1v2 as pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL) T --filtering out historical data
GROUP BY  prd_key
HAVING COUNT(*) > 1;
