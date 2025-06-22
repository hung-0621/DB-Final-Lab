DELIMITER //

DROP PROCEDURE IF EXISTS `GetBookDetailsAndListings`//

CREATE PROCEDURE `GetBookDetailsAndListings`(
    IN p_book_id INT
)
BEGIN
    SELECT
        b.book_id,
        b.title,
        b.isbn,
        b.description,
        GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') AS authors,
        GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories
    FROM `Book` b
    LEFT JOIN `BookAuthor` ba ON b.book_id = ba.book_id
    LEFT JOIN `Author` a ON ba.author_id = a.author_id
    LEFT JOIN `BookCategory` bc ON b.book_id = bc.book_id
    LEFT JOIN `Category` c ON bc.category_id = c.category_id
    WHERE b.book_id = p_book_id
    GROUP BY b.book_id;

    SELECT
        l.listing_id,
        l.price,
        l.status,
        cond.name AS `condition`,
        u.user_id AS seller_id,
        u.name AS seller_name,
        u.rating AS seller_rating
    FROM `Listing` l
    JOIN `User` u ON l.seller_id = u.user_id
    JOIN `Condition` cond ON l.condition_id = cond.condition_id
    WHERE l.book_id = p_book_id AND l.status = 'active'
    ORDER BY l.price ASC;

END//

DELIMITER ;
