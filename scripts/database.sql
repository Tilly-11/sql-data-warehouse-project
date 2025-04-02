/*
=========================================
Topic: SQL Data Warehouse Setup Script (Create database and schemas) 
=========================================
Purpose: This script creates a structured data warehouse with Bronze, Silver, and Gold schemas.  
Warning: Running this script will permanently delete the 'DataWarehouse' database if it exists, resulting in data loss. Proceed with caution.
*/



--Drop if exists 'DataWarehouse' database
DROP DATABASE IF EXISTS DataWarehouse;

--Create new database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

--Create schemas
CREATE SCHEMA Bronze;
CREATE SCHEMA Silver;
CREATE SCHEMA Gold;
