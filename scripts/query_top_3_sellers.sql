SELECT
    u.user_id,
    u.name AS seller_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM `User` u
JOIN `Listing` l ON u.user_id = l.seller_id
JOIN `OrderItem` oi ON l.listing_id = oi.listing_id
JOIN `Order` o ON oi.order_id = o.order_id AND o.status IN ('completed', 'shipped')
GROUP BY u.user_id, u.name
ORDER BY total_sales DESC
LIMIT 3;
