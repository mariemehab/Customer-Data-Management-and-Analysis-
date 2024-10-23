-- Dimension: Customer
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(50),
    Address TEXT
);

-- Dimension: Product
CREATE TABLE DimProduct (
    product_sk INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    Product_name VARCHAR(255),
    Description TEXT,
	category_name VARCHAR(255),
	subcategory_name VARCHAR(255)
);

-- Dimension: Seller
CREATE TABLE DimSeller (
    SellerKey INT IDENTITY(1,1) PRIMARY KEY,
    SellerID INT NOT NULL,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(50)
);

-- Dimension: Shipping Method
CREATE TABLE DimShipping_method (
    ShippingMethodKey INT IDENTITY(1,1) PRIMARY KEY,
    ShippingMethodID INT NOT NULL,
    ShippingMethodName VARCHAR(255),

);

-- Dimension: payment
CREATE TABLE Dimpayment (
    paymentKey INT IDENTITY(1,1) PRIMARY KEY,
    PaymentID INT NOT NULL,
    paymentDate date,
	paymentMethod varchar(50),
	CHECK (paymentMethod IN ('credit_card', 'paypal', 'bank_transfer')) -- Restrict the allowed values
);

-- Dimension: Date (For tracking order dates)
CREATE TABLE DimDate (
    DateKey INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month INT,
    Day INT
);

-- Fact: Orders
CREATE TABLE FactOrders (
    order_id_sk INT IDENTITY(1,1) PRIMARY KEY,
    customer_sk INT,
    product_sk INT,
    seller_sk INT,
    shipping_method_sk INT,
    payment_sk INT,
	order_date_sk INT,

	-- measures
	payment_amount decimal(10,2),
    TotalAmount DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(5, 2),
	Price DECIMAL(10, 2),
    Cost DECIMAL(10, 2), 
	salary decimal(8,2),


    -- Foreign Keys
    FOREIGN KEY (customer_sk) REFERENCES DimCustomer(customer_sk),
    FOREIGN KEY (product_sk) REFERENCES DimProduct(product_sk),
    FOREIGN KEY (seller_sk) REFERENCES DimSeller(seller_sk),
    FOREIGN KEY (shipping_method_sk) REFERENCES DimShipping_method(shipping_method_sk),
    FOREIGN KEY (payment_sk) REFERENCES Dimpayment(payment_sk),
    FOREIGN KEY (order_date_sk) REFERENCES DimDate(date_sk)
);
