-- Tabla de dimension dim_tiempo
CREATE TABLE dim_tiempo (
    id_tiempo INT PRIMARY KEY,
    year INT,
    mes INT,
    dia INT,
    trimestre INT
);

-- Tabla de Dimension dim_libro
CREATE TABLE dim_libro
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(100),
    autor VARCHAR(100),
    genero VARCHAR(50),
    precio_unitario DECIMAL(10, 2)
);

-- Tabla dimension dim_cliente
CREATE TABLE dim_cliente (
    id_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    edad INT,
    genero VARCHAR(10),
    ciudad VARCHAR(100)
);

-- Tabla dimension dim_tienda
CREATE TABLE dim_tienda (
    id_tienda INT PRIMARY KEY,
    nombre_tienda VARCHAR(100),
    ciudad VARCHAR(100),
    pais VARCHAR(100)
);


-- Tablas hechos
CREATE TABLE hechos_ventas_libros (
    id_venta INT PRIMARY KEY,
    id_tiempo INT,
    id_libro INT,
    id_cliente INT,
    id_tienda INT,
    cantidad INT,
    precio_total DECIMAL(10, 2),
    FOREIGN KEY (id_tiempo) REFERENCES dim_tiempo(id_tiempo),
    FOREIGN KEY (id_libro) REFERENCES dim_libro(id_libro),
    FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente),
    FOREIGN KEY (id_tienda) REFERENCES dim_tienda(id_tienda)
);

INSERT INTO dim_tiempo (id_tiempo, año, mes, dia, trimestre) VALUES
(1, 2023, 1, 10, 1),
(2, 2023, 2, 15, 1),
(3, 2023, 3, 20, 1);

INSERT INTO dim_libro (id_libro, titulo, autor, genero, precio_unitario) VALUES
(1, 'Book A', 'Author 1', 'Fiction', 15.99),
(2, 'Book B', 'Author 2', 'Science', 22.50),
(3, 'Book C', 'Author 3', 'History', 18.75),
(4, 'Book D', 'Author 4', 'Fiction', 10.99),
(5, 'Book E', 'Author 5', 'Science', 25.00);

INSERT INTO dim_cliente (id_cliente, nombre_cliente, edad, genero, ciudad) VALUES
(1, 'Alice', 30, 'F', 'New York'),
(2, 'Bob', 25, 'M', 'Los Angeles'),
(3, 'Charlie', 35, 'M', 'Chicago'),
(4, 'Diana', 28, 'F', 'San Francisco'),
(5, 'Eve', 22, 'F', 'Seattle');

INSERT INTO dim_tienda (id_tienda, nombre_tienda, ciudad, pais) VALUES
(1, 'Store 1', 'New York', 'USA'),
(2, 'Store 2', 'Los Angeles', 'USA'),
(3, 'Store 3', 'Chicago', 'USA');

INSERT INTO hechos_ventas_libros (id_venta, id_tiempo, id_libro, id_cliente, id_tienda, cantidad, precio_total) VALUES
(1, 1, 1, 1, 1, 2, 31.98),
(2, 1, 2, 2, 2, 1, 22.50),
(3, 2, 3, 3, 3, 3, 56.25),
(4, 2, 4, 4, 1, 1, 10.99),
(5, 3, 5, 5, 2, 2, 50.00),
(6, 1, 3, 1, 2, 1, 18.75),
(7, 2, 2, 2, 1, 4, 90.00),
(8, 3, 1, 3, 3, 3, 47.97),
(9, 3, 4, 4, 2, 1, 10.99),
(10, 2, 5, 5, 1, 2, 50.00);

SELECT l.genero, t.mes, SUM(h.precio_total) AS total_ventas
FROM hechos_ventas_libros h
JOIN dim_libro l ON h.id_libro = l.id_libro
JOIN dim_tiempo t ON h.id_tiempo = t.id_tiempo
GROUP BY l.genero, t.mes;

SELECT ti.nombre_tienda, l.autor, SUM(h.cantidad) AS total_libros_vendidos
FROM hechos_ventas_libros h
JOIN dim_libro l ON h.id_libro = l.id_libro
JOIN dim_tienda ti ON h.id_tienda = ti.id_tienda
GROUP BY ti.nombre_tienda, l.autor;

SELECT c.ciudad, t.trimestre, SUM(h.precio_total) AS ingresos_totales
FROM hechos_ventas_libros h
JOIN dim_cliente c ON h.id_cliente = c.id_cliente
JOIN dim_tiempo t ON h.id_tiempo = t.id_tiempo
GROUP BY c.ciudad, t.trimestre;

SELECT c.nombre_cliente, SUM(h.precio_total) AS total_ventas, SUM(h.cantidad) AS total_libros_comprados
FROM hechos_ventas_libros h
JOIN dim_cliente c ON h.id_cliente = c.id_cliente
GROUP BY c.nombre_cliente;


