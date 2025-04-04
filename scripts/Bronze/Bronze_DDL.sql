/*
===============================================================
Script Name: Bronze_DDL.sql
Description: This script defines the schema and table structure  
               for the Bronze layer of the Data Warehouse.  
               It includes database creation, schema setup,  
               and table definitions.
===============================================================
*/

DROP TABLE IF EXISTS Bronze.crm_cust_info;
CREATE TABLE Bronze.crm_cust_info(
cust_id INT,
cust_key VARCHAR(50),
cst_firstname VARCHAR(50),
cst_lastname VARCHAR(50),
cst_marital_status VARCHAR(50),
cst_gndr VARCHAR(50),
cst_create_date DATE

);

DROP TABLE IF EXISTS Bronze.crm_product_info;
CREATE TABLE Bronze.crm_product_info(
prd_id INT,
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

DROP TABLE IF EXISTS Bronze.crm_sales_details;
CREATE TABLE Bronze.crm_sales_details(
sls_ord_num VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt DATETIME,
sls_sales INT,
sls_quantity INT,
sls_price INT
);

DROP TABLE IF EXISTS Bronze.erp_loc_a101;
CREATE TABLE Bronze.erp_loc_a101(
cid VARCHAR(50),
cntry VARCHAR(50)
);

DROP TABLE IF EXISTS Bronze.erp_cust_az12;
CREATE TABLE Bronze.erp_cust_az12(
cid VARCHAR(50),
bdate DATE,
gen VARCHAR(50)
);

DROP TABLE IF EXISTS Bronze.erp_px_cat_g1v2;
CREATE TABLE Bronze.erp_px_cat_g1v2(
id VARCHAR(50),
cat VARCHAR(50),
subcat VARCHAR(50),
maintenance VARCHAR(50)
);
