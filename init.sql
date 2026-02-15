-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    region VARCHAR(50) NOT NULL,
    signup_date DATE NOT NULL,
    customer_segment VARCHAR(20) NOT NULL
);
-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    product_category VARCHAR(50) NOT NULL
);
-- Insert sample customers
INSERT INTO customers (
        first_name,
        last_name,
        email,
        region,
        signup_date,
        customer_segment
    )
VALUES (
        'John',
        'Smith',
        'john.smith@email.com',
        'Northeast',
        '2023-01-15',
        'Premium'
    ),
    (
        'Sarah',
        'Johnson',
        'sarah.j@email.com',
        'West',
        '2023-02-20',
        'Standard'
    ),
    (
        'Michael',
        'Williams',
        'michael.w@email.com',
        'South',
        '2023-03-10',
        'Premium'
    ),
    (
        'Emily',
        'Brown',
        'emily.b@email.com',
        'Midwest',
        '2023-04-05',
        'Standard'
    ),
    (
        'David',
        'Jones',
        'david.jones@email.com',
        'Northeast',
        '2023-05-12',
        'Premium'
    ),
    (
        'Jessica',
        'Garcia',
        'jessica.g@email.com',
        'West',
        '2023-06-18',
        'Standard'
    ),
    (
        'Christopher',
        'Martinez',
        'chris.m@email.com',
        'South',
        '2023-07-22',
        'Budget'
    ),
    (
        'Amanda',
        'Rodriguez',
        'amanda.r@email.com',
        'Midwest',
        '2023-08-30',
        'Premium'
    ),
    (
        'Matthew',
        'Davis',
        'matthew.d@email.com',
        'Northeast',
        '2023-09-14',
        'Standard'
    ),
    (
        'Ashley',
        'Lopez',
        'ashley.l@email.com',
        'West',
        '2023-10-25',
        'Budget'
    ),
    (
        'Daniel',
        'Gonzalez',
        'daniel.g@email.com',
        'South',
        '2023-11-08',
        'Premium'
    ),
    (
        'Jennifer',
        'Wilson',
        'jennifer.w@email.com',
        'Midwest',
        '2023-12-03',
        'Standard'
    ),
    (
        'James',
        'Anderson',
        'james.a@email.com',
        'Northeast',
        '2024-01-17',
        'Budget'
    ),
    (
        'Michelle',
        'Thomas',
        'michelle.t@email.com',
        'West',
        '2024-02-11',
        'Premium'
    ),
    (
        'Robert',
        'Taylor',
        'robert.t@email.com',
        'South',
        '2024-03-19',
        'Standard'
    );
-- Insert sample orders
INSERT INTO orders (
        customer_id,
        order_date,
        order_amount,
        product_category
    )
VALUES (1, '2023-02-01', 299.99, 'Electronics'),
    (1, '2023-03-15', 149.50, 'Books'),
    (2, '2023-03-10', 89.99, 'Clothing'),
    (3, '2023-04-05', 499.99, 'Electronics'),
    (4, '2023-05-20', 39.99, 'Books'),
    (5, '2023-06-12', 199.99, 'Home & Garden'),
    (6, '2023-07-08', 79.99, 'Clothing'),
    (7, '2023-08-15', 29.99, 'Books'),
    (8, '2023-09-22', 599.99, 'Electronics'),
    (9, '2023-10-10', 119.99, 'Home & Garden'),
    (10, '2023-11-05', 49.99, 'Clothing'),
    (11, '2023-12-01', 399.99, 'Electronics'),
    (12, '2024-01-14', 159.99, 'Home & Garden'),
    (13, '2024-02-20', 24.99, 'Books'),
    (14, '2024-03-08', 449.99, 'Electronics'),
    (15, '2024-03-25', 99.99, 'Clothing'),
    (1, '2024-04-12', 179.99, 'Home & Garden'),
    (3, '2024-04-18', 89.99, 'Books'),
    (5, '2024-05-02', 299.99, 'Electronics'),
    (8, '2024-05-15', 199.99, 'Clothing');
-- Create indexes for better query performance
CREATE INDEX idx_customers_region ON customers(region);
CREATE INDEX idx_customers_segment ON customers(customer_segment);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);