-- Procedures

--1) insert into interaction
CREATE PROCEDURE AddInteraction
@interactionID int,
@customerID int,
@date date,
@type varchar(50),
@notes text
AS
BEGIN
    INSERT INTO interaction (interaction_id, customer_id, interaction_date, type, notes)
    VALUES(@interactionID, @customerID, @date, @type, @notes)
END;


--2) insert into transaction
CREATE PROCEDURE AddTransaction 
    @transaction_id INT,
    @customer_id INT,
    @seller_id INT,
    @transaction_date DATE,
    @amount DECIMAL(10, 2),
    @transaction_type VARCHAR(50)
AS
BEGIN
    INSERT INTO transactions (transaction_id, customer_id, seller_id, transaction_date, amount)
	VALUES (@transaction_id, @customer_id, @seller_id, @transaction_date, @amount);
END;


--3) insert into Product
CREATE PROCEDURE AddProduct
    @product_id INT,
    @subcategory_id INT,
    @Product_name VARCHAR(255),
    @description TEXT,
    @price DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO product (product_id, subcategory_id, name, description, price)
    VALUES (@product_id, @subcategory_id, @Product_name, @description, @price);
END;


--4) insert into customer
CREATE PROCEDURE AddCustomer
    @customer_id INT,
    @name VARCHAR(255),
    @email VARCHAR(255),
    @phone VARCHAR(50),
    @address TEXT
AS
BEGIN
    INSERT INTO customer (customer_id, name, email, phone, address)
    VALUES (@customer_id, @name, @email, @phone, @address);
END;


--5) insert into Category
CREATE PROCEDURE AddCategory
    @category_id INT,
    @Category_name VARCHAR(255)
AS
BEGIN
    INSERT INTO category (category_id, name)
    VALUES (@category_id, @Category_name);
END;


--6)insert into subcategory
CREATE PROCEDURE AddSubcategory
    @subcategory_id INT,
    @category_id INT,
    @subcategory_name VARCHAR(255)
AS
BEGIN
    INSERT INTO subcategory (subcategory_id, category_id, name)
    VALUES (@subcategory_id, @category_id, @subcategory_name);
END;


--7)insert into seller
CREATE PROCEDURE AddSeller
    @seller_id INT,
    @name VARCHAR(255),
    @email VARCHAR(255),
    @phone VARCHAR(50)
AS
BEGIN
    INSERT INTO seller (seller_id, name, email, phone)
    VALUES (@seller_id, @name, @email, @phone);
END;


--8) insert into review
CREATE PROCEDURE AddReview
    @review_id INT,
    @customer_id INT,
    @product_id INT,
    @rating INT,
    @comment TEXT,
    @review_date DATE
AS
BEGIN
    INSERT INTO review (review_id, customer_id, product_id, rating, comment, review_date)
    VALUES (@review_id, @customer_id, @product_id, @rating, @comment, @review_date);
END;


--9) insert into shippingMethod
CREATE PROCEDURE AddShippingMethod
    @shipping_method_id INT,
    @shippingmethod_name VARCHAR(255),
    @cost DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO shipping_method (shipping_method_id, name, cost)
    VALUES (@shipping_method_id, @shippingmethod_name, @cost);
END;


--10) insert into order
CREATE PROCEDURE AddOrders
    @order_id INT,
    @customer_id INT,
    @seller_id INT,
    @order_date DATE,
    @total_amount DECIMAL(10, 2),
    @shipping_method_id INT
AS
BEGIN
    INSERT INTO orders (order_id, customer_id, seller_id, order_date, total_amount, shipping_method_id)
    VALUES (@order_id, @customer_id, @seller_id, @order_date, @total_amount, @shipping_method_id);
END;


--11) insert into order_detail
CREATE PROCEDURE AddOrderDetail
    @order_id INT,
    @product_id INT,
    @quantity INT,
    @price DECIMAL(10, 2),
    @discount DECIMAL(5, 2) = 0 -- Default value for discount
AS
BEGIN
    INSERT INTO order_detail (order_id, product_id, quantity, price, discount)
    VALUES (@order_id, @product_id, @quantity, @price, @discount);
END;


--12)insert into payment
CREATE PROCEDURE AddPayments
    @payment_id INT,
    @order_id INT,
    @payment_date DATE,
    @amount DECIMAL(10, 2),
    @payment_method VARCHAR(50)
AS
BEGIN
    -- Insert into payment table
    INSERT INTO payment (payment_id, order_id, payment_date, amount, payment_method)
    VALUES (@payment_id, @order_id, @payment_date, @amount, @payment_method);
END;



--13) insert into Sales
CREATE PROCEDURE AddSales
    @sales_id INT,
    @seller_id INT,
    @total_sales DECIMAL(10, 2),
    @salary DECIMAL(10, 2),
    @sales_date DATE
AS
BEGIN
    INSERT INTO sales (sales_id, seller_id, total_sales,sales_date)
    VALUES (@sales_id, @seller_id, @total_sales,@sales_date);
END;



--14)Delete Customer
CREATE PROCEDURE DeleteCustomer
    @customer_id INT
AS
BEGIN
    DELETE FROM review
    WHERE customer_id = @customer_id;

    DELETE FROM interaction
    WHERE customer_id = @customer_id;

    DELETE FROM transactions
    WHERE customer_id = @customer_id;

    DELETE FROM orders
    WHERE customer_id = @customer_id;

    DELETE FROM customer
    WHERE customer_id = @customer_id;
END;


--15) cancel order
CREATE PROCEDURE CancelOrder
    @order_id INT
AS
BEGIN
    DELETE FROM order_detail
    WHERE order_id = @order_id;

    DELETE FROM payment
    WHERE order_id = @order_id;

    DELETE FROM orders
    WHERE order_id = @order_id;
END;


--16) delete product
CREATE PROCEDURE DeleteProduct
    @product_id INT
AS
BEGIN
    DELETE FROM order_detail
    WHERE product_id = @product_id;

    DELETE FROM product
    WHERE product_id = @product_id;
END;



--17)update customer info
CREATE PROCEDURE UpdateCustomer
    @customer_id INT,
    @name VARCHAR(255),
    @phone VARCHAR(50),
    @address TEXT
AS
BEGIN
    UPDATE customer
    SET name = @name,
        phone = @phone,
        address = @address
    WHERE customer_id = @customer_id;
END;


--18)update product info
CREATE PROCEDURE UpdateProduct
    @product_id INT,
    @subcategory_id INT,
    @product_name VARCHAR(255),
    @description TEXT,
    @price DECIMAL(10, 2)
AS
BEGIN
    UPDATE product
    SET subcategory_id = @subcategory_id,
        name = @product_name,
        description = @description,
        price = @price
    WHERE product_id = @product_id;
END;

--19)update order
CREATE PROCEDURE UpdateOrder
    @order_id INT,
    @total_amount DECIMAL(10, 2),
    @shipping_method_id INT
AS
BEGIN
    UPDATE orders
    SET total_amount = @total_amount,
        shipping_method_id = @shipping_method_id
    WHERE order_id = @order_id;
END;


--20)Get All Products in a Subcategory
CREATE PROCEDURE GetProductsBySubcategory
    @subcategory_id INT
AS
BEGIN
    SELECT * 
    FROM product
    WHERE subcategory_id = @subcategory_id;
END;

EXEC GetProductsBySubcategory 3



--21)get total sales for a seller
CREATE PROCEDURE GetTotalSalesForSeller
    @seller_id INT
AS
BEGIN
    SELECT SUM(total_sales) AS TotalSales
    FROM sales
    WHERE seller_id = @seller_id;
END;


EXEC GetTotalSalesForSeller 4

--22) get product review
CREATE PROCEDURE GetProductReviews
    @product_id INT
AS
BEGIN
    SELECT * 
    FROM review
    WHERE product_id = @product_id;
END;

EXEC GetProductReviews 3

--23) get customer order
CREATE PROCEDURE GetCustomerOrders
    @customer_id INT
AS
BEGIN
    SELECT * 
    FROM orders
    WHERE customer_id = @customer_id;
END;

EXEC GetCustomerOrders 5