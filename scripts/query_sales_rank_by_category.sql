WITH BookSales AS (

    SELECT
        l.book_id,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM OrderItem oi
    JOIN Listing l ON oi.listing_id = l.listing_id
    JOIN `Order` o ON oi.order_id = o.order_id AND o.status IN ('completed', 'shipped')
    GROUP BY l.book_id
)

SELECT
    c.name AS category_name,
    b.title AS book_title,
    bs.total_revenue,
    RANK() OVER (PARTITION BY c.name ORDER BY bs.total_revenue DESC) AS sales_rank
FROM BookSales bs
JOIN Book b ON bs.book_id = b.book_id
JOIN BookCategory bc ON b.book_id = bc.book_id
JOIN Category c ON bc.category_id = c.category_id
ORDER BY c.name, sales_rank;
