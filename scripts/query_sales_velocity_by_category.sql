 WITH SalesCycle AS (
    SELECT
        l.book_id,
        o.order_id,

        TIMESTAMPDIFF(DAY, l.created_at, o.created_at) AS time_to_sell_days
    FROM `Listing` l
    JOIN `OrderItem` oi ON l.listing_id = oi.listing_id
    JOIN `Order` o ON oi.order_id = o.order_id
    WHERE l.status = 'sold' AND o.status IN ('completed', 'shipped')
)

SELECT
    c.name AS category_name,
    COUNT(sc.order_id) AS total_sold_items,
    AVG(sc.time_to_sell_days) AS avg_days_to_sell
FROM SalesCycle sc
JOIN `BookCategory` bc ON sc.book_id = bc.book_id
JOIN `Category` c ON bc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_days_to_sell ASC;
