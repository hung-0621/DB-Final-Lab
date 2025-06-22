SELECT
    c.name AS condition_name,
    COUNT(oi.order_id) AS total_items_sold,
    AVG(oi.unit_price) AS average_price,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM OrderItem oi
JOIN Listing l ON oi.listing_id = l.listing_id
JOIN `Condition` c ON l.condition_id = c.condition_id
JOIN `Order` o ON oi.order_id = o.order_id AND o.status IN ('completed', 'shipped')
GROUP BY c.name
ORDER BY total_revenue DESC;
