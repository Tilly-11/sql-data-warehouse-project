

CREATE VIEW Gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) as customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	la.cntry as country,
	ci.cst_marital_status as marital_status,
CASE WHEN ci.cst_gndr != "n/a" THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, "n/a")
END AS gender,
ca.bdate as birthdate,
ci.cst_create_date as create_date
FROM Silver.crm_cust_info AS ci
LEFT JOIN Silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid;



CREATE VIEW Gold.dim_products AS
SELECT
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt,pn.prd_key) as product_key,
	pn.prd_id as product_id,
	pn.prd_key as product_number,
	pn.prd_nm as product_name,
    pn.cat_id as category_id,
    pc.cat as category,
    pc.subcat as subcategory,
    pc.maintenance,
	pn.prd_cost as cost,
	pn.prd_line as product_line,
	pn.prd_start_dt as start_date
FROM Silver.crm_product_info as pn
LEFT JOIN Silver.erp_px_cat_g1v2 as pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL;



CREATE VIEW Gold.fact_sales AS
SELECT 
sd.sls_ord_num as order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as price
FROM Silver.crm_sales_details as sd
LEFT JOIN Gold.dim_products as pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN Gold.dim_customers as cu
ON sd.sls_cust_id = cu.customer_id;
