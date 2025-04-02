/*
=========================================
Topic: SQL Data Warehouse Setup Script (Create databases and schema) 
=========================================
Purpose: This script creates a structured data warehouse with Bronze, Silver, and Gold databases.  
Warning: Running this script will permanently delete existing databases, resulting in data loss. Proceed with caution.
*/



--Delete if database already exists
DROP DATABASE IF EXISTS Bronze

--Create Bronze database
CREATE DATABASE Bronze;

--Delete if database already exists
DROP DATABASE IF EXISTS Silver

--Create Silver database
CREATE DATABASE Silver;

--Delete if database already exists
DROP DATABASE IF EXISTS Gold

--Create Gold database
CREATE DATABASE Gold;
