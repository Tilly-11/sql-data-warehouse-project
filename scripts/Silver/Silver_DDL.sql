/*
===============================================================
Script Name  : Silevr_DDL.sql
Author       : Matilda Steiner
Description  : This script defines the schema and table structure  
               for the Silver layer of the Data Warehouse.  
               It includes database creation, schema setup,  
               and table definitions.
Warning      : Executing this script will modify the database  
               structure. Ensure you have backups before running it.  
===============================================================
*/


DROP TABLE IF EXISTS Silver.crm_cust_info;
CREATE TABLE Silver.crm_cust_info(
cust_id INT,
cust_key VARCHAR(50),
cst_firstname VARCHAR(50),
cst_lastname VARCHAR(50),
cst_marital_status VARCHAR(50),
cst_gndr VARCHAR(50),
cst_create_date DATE,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Silver.crm_product_info;
CREATE TABLE Silver.crm_product_info(
prd_id INT,
cat_id VARCHAR(50),
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Silver.crm_sales_details;
CREATE TABLE Silver.crm_sales_details(
sls_ord_num VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt DATE,
sls_ship_dt DATE,
sls_due_dt DATE,
sls_sales INT,
sls_quantity INT,
sls_price INT,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Silver.erp_loc_a101;
CREATE TABLE Silver.erp_loc_a101(
cid VARCHAR(50),
cntry VARCHAR(50),
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Silver.erp_cust_az12;
CREATE TABLE Silver.erp_cust_az12(
cid VARCHAR(50),
bdate DATE,
gen VARCHAR(50),
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Silver.erp_px_cat_g1v2;
CREATE TABLE Silver.erp_px_cat_g1v2(
id VARCHAR(50),
cat VARCHAR(50),
subcat VARCHAR(50),
maintenance VARCHAR(50),
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
