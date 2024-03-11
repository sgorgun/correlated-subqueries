SELECT
    product.id,
    product.comment AS title,
    product.price
FROM
    product
INNER JOIN
    product_title ON product.product_title_id = product_title.id
WHERE
    product.price > (
        SELECT
            AVG(p.price)
        FROM
            product as p
        INNER JOIN
            product_title as pt ON p.product_title_id = pt.id
        WHERE
            pt.product_category_id = product_title.product_category_id
    )
ORDER BY
    product.id;