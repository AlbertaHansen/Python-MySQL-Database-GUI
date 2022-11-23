#drop database essential_books;
create database if not exists essential_books;
use essential_books;

CREATE TABLE IF NOT EXISTS publisher (
    publisher_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    f_name VARCHAR(30),
    l_name VARCHAR(30),
    phone VARCHAR(16)
);

INSERT INTO publisher (f_name, l_name, phone)
VALUES
("Jenny", "Brown", "867-5309"),
("Robert", "King", "574-9856");

CREATE TABLE IF NOT EXISTS author(
    author_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    f_name VARCHAR(30),
    l_name VARCHAR(30),
	publisher_id INT NOT NULL,
    FOREIGN KEY (publisher_id)
        REFERENCES publisher (publisher_id)
);

INSERT INTO author (f_name, l_name, publisher_id)
VALUES
("Lewis", "Stone", 1),
("Maggie", "Long", 1),
("Sara", "Troy", 2);

CREATE TABLE IF NOT EXISTS book (
    isbn VARCHAR(13) NOT NULL PRIMARY KEY,
    publisher_id INT NOT NULL,
    FOREIGN KEY (publisher_id)
        REFERENCES publisher (publisher_id),
    title VARCHAR(100),
    release_year INT,
    price DECIMAL(5 , 2 ),
    stock INT
);

INSERT INTO book (isbn, publisher_id, title, release_year, price, stock)
VALUES
("4ce5sc5ascr45", 1, "From the Depths", 1994, 14.99, 7),
("854795lo6584", 2, "Goosebumps", 2000, 9.99, 10),
("1774262061", 1, "A Tale of Two Cities", 1859, 19.99, 6),
("978-140521634", 2, "The Little Prince",1943 ,17.95 , 0),
("0261102214", 1, "The Hobbit", 1937 , 10.88 , 24),
("0307474275", 2, "The Da Vinci Code", 2003 , 12.86 , 9),
("9780679723165", 1, "Lolita", 1955 , 21.00 , 2),
("979-846103418", 2, "Black Beauty", 1877 , 19.26 , 2),
("9780241953235", 1, "Watership Down", 1972  , 19.79 , 11),
("0061232912", 2, "Charlotte's Web", 1952 , 10.88 , 1);

CREATE TABLE IF NOT EXISTS customer (
    customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    l_name VARCHAR(30),
    email VARCHAR(100),
    phone VARCHAR(16),
    delivery_address VARCHAR(100),
    postal_code VARCHAR(10)
);

INSERT INTO customer (l_name, email, phone, delivery_address, postal_code)
VALUES
("Drew", "drew_123@gmail.com", "847-8569", "123 Main Street, St.John's", "A9S 9Y7"),
("Power", "Megan_power@gmail.com", "548-5556", "56 Other Street, Mount Pearl", "AP9 K0Y");

CREATE TABLE IF NOT EXISTS the_order (
    order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
);

INSERT INTO the_order (customer_id)
VALUES
(2),
(2),
(1);

CREATE TABLE IF NOT EXISTS book_order (
    order_id INT NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    PRIMARY KEY (order_id, isbn),
    count INT,
    FOREIGN KEY (order_id)
        REFERENCES the_order (order_id),
    FOREIGN KEY (isbn)
        REFERENCES book (isbn)
);

INSERT INTO book_order (order_id, isbn, count)
VALUES
(1, "4ce5sc5ascr45", 3),
(1, "854795lo6584", 1),
(2, "854795lo6584", 2),
(3, "4ce5sc5ascr45", 1);

CREATE TABLE IF NOT EXISTS invoice (
    invoice_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES the_order (order_id),
    total DECIMAL(5 , 2 ),
    num_items INT,
    sale_date DATETIME
);

INSERT INTO invoice (order_id, total, num_items, sale_date)
VALUES
(2, 19.98, 2, NOW()),
(1, 54.96, 4, NOW()),
(3, 14.99, 1, NOW());

SELECT * FROM author;
SELECT * FROM publisher;
SELECT * FROM book;
SELECT * FROM book_order;
SELECT * FROM the_order;
SELECT * FROM customer;
SELECT * FROM invoice;