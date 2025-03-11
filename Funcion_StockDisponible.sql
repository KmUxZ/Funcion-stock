DELIMITER //
CREATE FUNCTION StockProductos(product_id INT) 
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE product_name VARCHAR(100);
    DECLARE current_stock INT;
    DECLARE result VARCHAR(255);

    -- nombre del producto y stock
    SELECT name, stock INTO product_name, current_stock
    FROM products
    WHERE id = product_id;

    -- Formatear el resultado
    SET result = CONCAT('Producto: ', IFNULL(product_name, 'No encontrado'), 
                        ' | Stock: ', IFNULL(current_stock, 0));

    RETURN result;
END //
DELIMITER ;
