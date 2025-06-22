WITH FirstPurchase AS (

    SELECT
        buyer_id AS user_id,
        MIN(created_at) AS first_purchase_date
    FROM `Order`
    WHERE status IN ('completed', 'shipped', 'paid') 
    GROUP BY buyer_id
),
FirstSale AS (

    SELECT
        l.seller_id AS user_id,
        MIN(o.created_at) AS first_sale_date
    FROM `Order` o
    JOIN `OrderItem` oi ON o.order_id = oi.order_id
    JOIN `Listing` l ON oi.listing_id = l.listing_id
    WHERE o.status IN ('completed', 'shipped')
    GROUP BY l.seller_id
)

SELECT
    u.user_id,
    u.name,
    fp.first_purchase_date,
    fs.first_sale_date
FROM `User` u
JOIN FirstPurchase fp ON u.user_id = fp.user_id 
JOIN FirstSale fs ON u.user_id = fs.user_id    
WHERE fs.first_sale_date >= fp.first_purchase_date;
