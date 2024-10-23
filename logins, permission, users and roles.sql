-- Create Logins for Customers, Accountants, and Managers
CREATE LOGIN CustomerLogin WITH PASSWORD = 'CustomerPassword@123';
CREATE LOGIN AccountantLogin WITH PASSWORD = 'AccountantPassword@123';
CREATE LOGIN ManagerLogin WITH PASSWORD = 'ManagerPassword@123';

USE FinalDB;

-- Create Database Users
CREATE USER CustomerUser FOR LOGIN CustomerLogin;
CREATE USER AccountantUser FOR LOGIN AccountantLogin;
CREATE USER ManagerUser FOR LOGIN ManagerLogin;


-- Create Roles for Customers, Accountants, and Managers
CREATE ROLE CustomerRole;
CREATE ROLE AccountantRole;
CREATE ROLE ManagerRole;


-- Grant Select Permission on relevant Tables for Customers
GRANT SELECT ON dbo.orders TO CustomerRole;
GRANT SELECT ON dbo.product TO CustomerRole;
GRANT SELECT ON dbo.review TO CustomerRole;
GRANT SELECT ON dbo.subcategory TO CustomerRole;
GRANT SELECT ON dbo.category TO CustomerRole;
GRANT SELECT ON dbo.customer TO CustomerRole;



-- Grant Select Permission on Views for Customers
GRANT SELECT ON dbo.customer_info TO CustomerRole;
GRANT SELECT ON dbo.customer_reviews TO CustomerRole;
GRANT SELECT ON dbo.customer_orders_count TO CustomerRole;



-- Add CustomerUser to CustomerRole
EXEC sp_addrolemember 'CustomerRole', 'CustomerUser';



-- Grant Select and Update Permissions on relevant Tables for Accountants
GRANT SELECT, UPDATE ON dbo.payment TO AccountantRole;
GRANT SELECT, UPDATE ON dbo.transactions TO AccountantRole;
GRANT SELECT, UPDATE ON dbo.sales TO AccountantRole;
GRANT SELECT ON dbo.orders TO AccountantRole;
GRANT SELECT ON dbo.customer TO AccountantRole;


-- Grant Execute Permission on Stored Procedures related to payments and transactions
GRANT EXECUTE ON dbo.AddPayments TO AccountantRole;
GRANT EXECUTE ON dbo.GetTotalSalesbyProduct TO AccountantRole;


-- Grant Select Permissions on Views for Accountants
GRANT SELECT ON dbo.payment_det TO AccountantRole;
GRANT SELECT ON dbo.tran_summary TO AccountantRole;

-- Add AccountantUser to AccountantRole
EXEC sp_addrolemember 'AccountantRole', 'AccountantUser';


-- Grant Full Control (Select, Insert, Update, Delete) on all Tables for Managers
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.orders TO ManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.product TO ManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.customer TO ManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.payment TO ManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.transactions TO ManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.sales TO ManagerRole;


-- Grant Execute Permission on all Stored Procedures for Managers
GRANT EXECUTE ON dbo.AddInteraction TO ManagerRole;
GRANT EXECUTE ON dbo.AddOrderDetail TO ManagerRole;
GRANT EXECUTE ON dbo.AddOrders TO ManagerRole;
GRANT EXECUTE ON dbo.CancelOrder TO ManagerRole;
GRANT EXECUTE ON dbo.DeleteCustomer TO ManagerRole;


-- Grant Select Permissions on All Views for Managers
GRANT SELECT ON dbo.cat_Pro TO ManagerRole;
GRANT SELECT ON dbo.sales_det TO ManagerRole;
GRANT SELECT ON dbo.seller_info TO ManagerRole;
GRANT SELECT ON dbo.seller_order TO ManagerRole;
GRANT SELECT ON dbo.Total_sales TO ManagerRole;

-- Add ManagerUser to ManagerRole
EXEC sp_addrolemember 'ManagerRole', 'ManagerUser';


-- Revoke Delete permissions from AccountantRole (if mistakenly given)
REVOKE DELETE ON dbo.payment FROM AccountantRole;
