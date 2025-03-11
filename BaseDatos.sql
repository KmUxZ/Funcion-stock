DROP DATABASE IF EXISTS GAIT;
CREATE DATABASE IF NOT EXISTS GAIT;

USE GAIT;

CREATE TABLE IF NOT EXISTS distributors(
	id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  location VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS roles(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS users(
	id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  lastname VARCHAR(45) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  state TINYINT DEFAULT 0,
  phone VARCHAR(20) NOT NULL,
  id_distributor INT NOT NULL,
  id_role INT NOT NULL,
  FOREIGN KEY (id_role) REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_distributor) REFERENCES distributors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS categories(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL UNIQUE,
  description TEXT NOT NULL
);

CREATE TABLE brands (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products(
	id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL UNIQUE,
  price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
  discount DECIMAL(10, 2),
  stock INT DEFAULT 0 CHECK (stock >= 0),
  id_brand INT NOT NULL,
  id_category INT NOT NULL,
  FOREIGN KEY (id_brand) REFERENCES brands(id) ON DELETE CASCADE,
  FOREIGN KEY (id_category) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
  total DECIMAL(10, 2) NOT NULL,
  id_user INT NOT NULL,
  id_distributor INT NOT NULL,
  order_date DATETIME NOT NULL,
  dispatch_date DATETIME NOT NULL,
  delivery_date DATETIME NOT NULL,
  FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (id_distributor) REFERENCES distributors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_products(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_order INT NOT NULL,
  id_product INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price > 0),
  subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal > 0),
  FOREIGN KEY (id_order) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (id_product) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS payment_methods(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL UNIQUE,
  description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS payments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_order INT NOT NULL,
	id_payment_method INT NOT NULL,
  amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
  status ENUM('PENDING', 'COMPLETED', 'FAILED') DEFAULT 'PENDING',
  FOREIGN KEY (id_order) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (id_payment_method) REFERENCES payment_methods(id) ON DELETE CASCADE
);

-- Insertar marcas de prueba
INSERT INTO brands (name) VALUES
('Nike'),
('Adidas'),
('Puma'),
('Reebok');

-- Insertar categorías de prueba
INSERT INTO categories (name, description) VALUES
('Calzado', 'Zapatillas deportivas y casuales'),
('Ropa', 'Camisetas, pantalones y sudaderas'),
('Accesorios', 'Mochilas, gorras y relojes');

-- Insertar productos con stock
INSERT INTO products (name, price, discount, stock, id_brand, id_category) VALUES
('Zapatillas Air Max', 120.00, 10.00, 50, 1, 1),
('Camiseta Clásica', 25.00, 5.00, 100, 2, 2),
('Sudadera Negra', 45.00, 0.00, 75, 3, 2),
('Gorra Deportiva', 20.00, 2.00, 30, 4, 3),
('Mochila Urbana', 60.00, 8.00, 20, 1, 3);

