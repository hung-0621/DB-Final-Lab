DROP VIEW IF EXISTS `ActiveListingsView`;

CREATE VIEW `ActiveListingsView` AS
SELECT
    l.listing_id,
    l.price,
    l.created_at AS listed_at,
    b.book_id,
    b.title AS book_title,
    b.isbn,
    cond.name AS `condition`,
    u.user_id AS seller_id,
    u.name AS seller_name,
    u.rating AS seller_rating,
    (SELECT url FROM `ListingImage` li WHERE li.listing_id = l.listing_id LIMIT 1) AS image_url
FROM `Listing` l
JOIN `Book` b ON l.book_id = b.book_id
JOIN `User` u ON l.seller_id = u.user_id
JOIN `Condition` cond ON l.condition_id = cond.condition_id
WHERE l.status = 'active';
