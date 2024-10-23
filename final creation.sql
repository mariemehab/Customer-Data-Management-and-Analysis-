CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL, -- البريد الإلكتروني يجب أن يكون فريدًا وغير فارغ
    phone VARCHAR(50),
    address TEXT
);


CREATE TABLE seller (
    seller_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(50),
	salary decimal(10, 2)
);




CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    seller_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2),
    --transaction_type VARCHAR(50), -- Using VARCHAR instead of ENUM
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
    --CHECK (transaction_type IN ('purchase', 'refund', 'other')) -- Restrict the allowed values
);



CREATE TABLE category (
    category_id INT PRIMARY KEY,
    name VARCHAR(255)
);


CREATE TABLE subcategory (
    subcategory_id INT PRIMARY KEY,
    category_id INT,
    name VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE product (
    product_id INT PRIMARY KEY,
    subcategory_id INT,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
);


CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY,
    name VARCHAR(255),
    cost DECIMAL(10, 2)
);



CREATE TABLE orders (
    order_id INT identity(1,1) PRIMARY KEY,
    customer_id INT,
    seller_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    shipping_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

CREATE TABLE order_detail (
    order_detail_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2), -- سعر المنتج في وقت الطلب
    discount DECIMAL(5, 2) DEFAULT 0, -- الخصم إن وجد
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);



CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50), -- Using VARCHAR instead of ENUM
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer')) -- Restrict the allowed values
);




CREATE TABLE sales (
    sales_id INT PRIMARY KEY,
    seller_id INT,
    total_sales DECIMAL(10, 2),
 
    sales_date DATE,
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id)
);






CREATE TABLE interaction (
    interaction_id INT PRIMARY KEY,
    customer_id INT,
    interaction_date DATE,
    type VARCHAR(50), -- Use VARCHAR instead of ENUM
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CHECK (type IN ('support_call', 'email', 'chat')) -- Restrict the allowed values
);




CREATE TABLE review (
    review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5), -- تصنيف من 1 إلى 5
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
------------------------------------