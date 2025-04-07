****Data Dictionary for Gold Layer****

*Overview*

The Gold layer is the business-level data representation structured to support analytical and reporting use cases. It contains dimension tables and a fact table for specific business metrics.

**1. gold.dim_customers**

  -Purpose: Stores customer details enriched with demographic and geographic data.
  -Columns:

| Column Name      | Description                           |
|------------------|---------------------------------------|
| `customer_key`   | Serogate key uniquely identifying each customer record in the dimension table|
| `customer_id`    | Unique numerical identifier assigned to each customer|
| `customer_number`| Alphanumeric identifier representing the customer, used for tracking and referencing|
| `first_name`     | The customer's first name |
| `last_name`      | The customer's last name  |
| `country` | The country of residence of the customer (eg. 'Australia')|
| `marital_status`| The marital status of the customer (eg. 'Married', 'Single') |
| `gender` | The gender of the customer (eg. 'Male', 'Female', 'n/a' )|
| `birthdate`| The date of birth of the customer, format as YYYY-MM-DD(eg. 1765-06-10)|
| `create_date`   | The date and time when the customer record was created in the system|



**2. gold.dim_products**

  -Purpose: Provides information about products and their attributes.
  -Columns:

| Column Name      | Description                           |
|------------------|---------------------------------------|
| `product_key`   | Serogate key uniquely identifying each product record in the dimension table|
| `product_id`    | Unique numerical identifier assigned to each product for internal tracking and referencing|
| `product_number`| A structured alphanumeric code representing the product, often used for categorization|
| `product_name`     | Descriptive name of the product, including key details such as type and colour|
| `category_id`      | A unique identifier for product category.|
| `category` | The broader classification of the product (eg. 'Bikes') to group related items|
| `maintenance_required`| Indicates whether a product requires maintenance (eg 'Yes', 'No')|
| `cost` | The cost of the product|
| `product_line`| The particular line or series the product belongs to (eg 'Road')|
| `start_date`   | The date the product became available for sale|



**3. gold.fact_sales**

  -Purpose: Stores transactional sales data for analytical purposes.
  -Columns:

| Column Name      | Description                           |
|------------------|---------------------------------------|
| `order_number`   | A unique alphanumeric identifier for each sale order(eg. 'SOS44%')|
| `product_key`    | Surrogate key linking the order to the product dimension table|
| `customer_key`   | Surrogate key linking the order to the customer dimension table|
| `order_date`     | The date when the order was placed|
| `shipping_date`  | The date when the order was shipped to the customer|
| `due_date`       | The date when the order payment was due|
| `sales_amount`   | The total monetary value of the sale for the line item, in whole currency units (eg. 25)|
| `quantity`       | The number of units of the product ordered for the line item (eg. 1)|
| `price`          | The price per unit of the product for the line item, in whole currency units(eg. 25)|








































