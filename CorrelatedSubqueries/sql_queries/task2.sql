SELECT product_category.id, product_category.name
FROM product_category
WHERE product_category.id IN (
    SELECT product_title.product_category_id
    FROM product_title
    INNER JOIN product ON product_title.id = product.product_title_id
    WHERE product.id IN (
        SELECT order_details.product_id
        FROM order_details
        INNER JOIN customer_order ON order_details.customer_order_id = customer_order.id
    )
    GROUP BY product_title.product_category_id
    HAVING COUNT(DISTINCT product.id) = (
        SELECT COUNT(DISTINCT product.id)
        FROM product
        INNER JOIN product_title ON product.product_title_id = product_title.id
        WHERE product_title.product_category_id = product_category.id
    )
)
ORDER BY product_category.id;