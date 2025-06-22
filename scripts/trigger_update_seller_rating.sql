DELIMITER //

DROP TRIGGER IF EXISTS `AfterReviewInsertUpdateRating`//

CREATE TRIGGER `AfterReviewInsertUpdateRating`
AFTER INSERT ON `Review`
FOR EACH ROW
BEGIN
    DECLARE v_seller_id INT;
    DECLARE v_new_avg_rating DECIMAL(3, 2);

    SELECT l.seller_id INTO v_seller_id
    FROM `OrderItem` oi
    JOIN `Listing` l ON oi.listing_id = l.listing_id
    WHERE oi.order_id = NEW.order_id
    LIMIT 1;

    IF v_seller_id IS NOT NULL THEN
        SELECT AVG(r.rating) INTO v_new_avg_rating
        FROM `Review` r
        JOIN `OrderItem` oi ON r.order_id = oi.order_id
        JOIN `Listing` l ON oi.listing_id = l.listing_id
        WHERE l.seller_id = v_seller_id;

        UPDATE `User`
        SET `rating` = v_new_avg_rating
        WHERE `user_id` = v_seller_id;
    END IF;

END//

DELIMITER ;
