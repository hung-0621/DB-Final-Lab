create.sql
==================================================
-- 1. 使用者表
CREATE TABLE `User` (
  `user_id`       INT UNSIGNED AUTO_INCREMENT,
  `email`         VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `name`          VARCHAR(100) NOT NULL,
  `phone`         VARCHAR(20) NULL, -- 允許電話為空
  `rating`        DECIMAL(3,2) NOT NULL DEFAULT 0.00,
  `created_at`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_user` PRIMARY KEY (`user_id`),
  CONSTRAINT `uq_user_email` UNIQUE (`email`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. 作者表
CREATE TABLE `Author` (
  `author_id` INT UNSIGNED AUTO_INCREMENT,
  `name`      VARCHAR(200) NOT NULL,
  
  CONSTRAINT `pk_author` PRIMARY KEY (`author_id`),
  CONSTRAINT `uq_author_name` UNIQUE (`name`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. 分類表
CREATE TABLE `Category` (
  `category_id` INT UNSIGNED AUTO_INCREMENT,
  `name`        VARCHAR(100) NOT NULL,
  
  CONSTRAINT `pk_category` PRIMARY KEY (`category_id`),
  CONSTRAINT `uq_category_name` UNIQUE (`name`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. 書籍表
CREATE TABLE `Book` (
  `book_id`     INT UNSIGNED AUTO_INCREMENT,
  `title`       VARCHAR(255) NOT NULL,
  `isbn`        VARCHAR(20) NOT NULL,
  `description` TEXT,
  `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_book` PRIMARY KEY (`book_id`),
  CONSTRAINT `uq_book_isbn` UNIQUE (`isbn`),
  INDEX `idx_book_title` (`title`) -- 經常按書名查詢，建議建立索引
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. 書籍–作者關聯
CREATE TABLE `BookAuthor` (
  `book_id`   INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  
  CONSTRAINT `pk_bookauthor` PRIMARY KEY(`book_id`, `author_id`),
  CONSTRAINT `fk_bookauthor_book` FOREIGN KEY(`book_id`) REFERENCES `Book`(`book_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bookauthor_author` FOREIGN KEY(`author_id`) REFERENCES `Author`(`author_id`) ON DELETE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. 書籍–分類關聯
CREATE TABLE `BookCategory` (
  `book_id`     INT UNSIGNED NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  
  CONSTRAINT `pk_bookcategory` PRIMARY KEY(`book_id`,`category_id`),
  CONSTRAINT `fk_bookcategory_book` FOREIGN KEY(`book_id`) REFERENCES `Book`(`book_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bookcategory_category` FOREIGN KEY(`category_id`) REFERENCES `Category`(`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. 書況等級表
CREATE TABLE `Condition` (
  `condition_id` INT UNSIGNED AUTO_INCREMENT,
  `name`         VARCHAR(50) NOT NULL,
  
  CONSTRAINT `pk_condition` PRIMARY KEY (`condition_id`),
  CONSTRAINT `uq_condition_name` UNIQUE (`name`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. 刊登表
CREATE TABLE `Listing` (
  `listing_id`   INT UNSIGNED AUTO_INCREMENT,
  `book_id`      INT UNSIGNED NOT NULL,
  `seller_id`    INT UNSIGNED NOT NULL,
  `condition_id` INT UNSIGNED NOT NULL,
  `price`        DECIMAL(10,2) NOT NULL,
  `stock`        INT UNSIGNED NOT NULL DEFAULT 1,
  `status`       ENUM('active','sold','removed') NOT NULL DEFAULT 'active',
  `created_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_listing` PRIMARY KEY (`listing_id`),
  CONSTRAINT `fk_listing_book` FOREIGN KEY(`book_id`) REFERENCES `Book`(`book_id`),
  CONSTRAINT `fk_listing_seller` FOREIGN KEY(`seller_id`) REFERENCES `User`(`user_id`),
  CONSTRAINT `fk_listing_condition` FOREIGN KEY(`condition_id`) REFERENCES `Condition`(`condition_id`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. 刊登圖片表
CREATE TABLE `ListingImage` (
  `image_id`   INT UNSIGNED AUTO_INCREMENT,
  `listing_id` INT UNSIGNED NOT NULL,
  `url`        VARCHAR(500) NOT NULL,
  
  CONSTRAINT `pk_listingimage` PRIMARY KEY (`image_id`),
  CONSTRAINT `fk_listingimage_listing` FOREIGN KEY(`listing_id`) REFERENCES `Listing`(`listing_id`) ON DELETE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. 訂單表
CREATE TABLE `Order` (
  `order_id`     INT UNSIGNED AUTO_INCREMENT,
  `buyer_id`     INT UNSIGNED NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `status`       ENUM('pending','paid','shipped','completed','cancelled') NOT NULL DEFAULT 'pending',
  `created_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_order` PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_order_buyer` FOREIGN KEY(`buyer_id`) REFERENCES `User`(`user_id`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. 訂單明細
CREATE TABLE `OrderItem` (
  `order_id`   INT UNSIGNED NOT NULL,
  `listing_id` INT UNSIGNED NOT NULL,
  `quantity`   INT UNSIGNED NOT NULL DEFAULT 1,
  `unit_price` DECIMAL(10,2) NOT NULL,
  
  CONSTRAINT `pk_orderitem` PRIMARY KEY(`order_id`, `listing_id`),
  CONSTRAINT `fk_orderitem_order` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orderitem_listing` FOREIGN KEY(`listing_id`) REFERENCES `Listing`(`listing_id`) ON DELETE RESTRICT
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. 評價表
CREATE TABLE `Review` (
  `review_id`   INT UNSIGNED AUTO_INCREMENT,
  `order_id`    INT UNSIGNED NOT NULL,
  `reviewer_id` INT UNSIGNED NOT NULL,
  `rating`      TINYINT UNSIGNED NOT NULL,
  `comment`     TEXT,
  `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_review` PRIMARY KEY (`review_id`),
  CONSTRAINT `uq_review_order` UNIQUE (`order_id`), -- 一個訂單通常只有一個評價
  CONSTRAINT `fk_review_order` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_reviewer` FOREIGN KEY(`reviewer_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  CONSTRAINT `ck_review_rating` CHECK (`rating` BETWEEN 1 AND 5)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
