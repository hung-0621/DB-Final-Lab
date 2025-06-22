insert.sql
==================================================
-- 1. 使用者 (User)
INSERT INTO `User` (`user_id`, `email`, `password_hash`, `name`, `phone`, `rating`) VALUES
(1, 'alice@example.com', 'hashed_password_1', 'Alice', '0911111111', 4.85),
(2, 'bob@example.com', 'hashed_password_2', 'Bob', '0922222222', 4.90),
(3, 'charlie@example.com', 'hashed_password_3', 'Charlie', '0933333333', 4.70),
(4, 'david@example.com', 'hashed_password_4', 'David', '0944444444', 5.00),
(5, 'eve@example.com', 'hashed_password_5', 'Eve', '0955555555', 4.60),
(6, 'chen.da.wen@example.com', 'hashed_password_6', '陳大文', '0966666666', 4.95),
(7, 'lin.xiao.mei@example.com', 'hashed_password_7', '林小美', '0977777777', 4.88),
(8, 'huang.a.cai@example.com', 'hashed_password_8', '黃阿財', '0988888888', 4.75),
(9, 'frank@example.com', 'hashed_password_9', 'Frank', '0912345678', 0.00),
(10, 'grace@example.com', 'hashed_password_10', 'Grace', '0987654321', 0.00),
(11, 'heidi@example.com', 'hashed_password_11', 'Heidi', '0911223344', 4.50),
(12, 'ivan@example.com', 'hashed_password_12', 'Ivan', '0955667788', 5.00),
(13, 'judy@example.com', 'hashed_password_13', 'Judy', '0988112233', 4.80),
(14, 'kevin@example.com', 'hashed_password_14', 'Kevin', '0921556677', 4.90),
(15, 'linda@example.com', 'hashed_password_15', 'Linda', '0939887766', 0.00);

-- 2. 作者 (Author)
INSERT INTO `Author` (`author_id`, `name`) VALUES
(1, 'J.K. Rowling'),
(2, 'George Orwell'),
(3, 'J.R.R. Tolkien'),
(4, '金庸'),
(5, '劉慈欣'),
(6, '東野圭吾'),
(7, '村上春樹'),
(8, 'Yuval Noah Harari'),
(9, 'James Clear'),
(10, 'Robert C. Martin');

-- 3. 分類 (Category)
INSERT INTO `Category` (`category_id`, `name`) VALUES
(1, '奇幻'),
(2, '科幻'),
(3, '小說'),
(4, '歷史'),
(5, '商業理財'),
(6, '心理學'),
(7, '程式設計'),
(8, '懸疑推理'),
(9, '武俠'),
(10, '非小說');

-- 4. 書況 (Condition)
INSERT INTO `Condition` (`condition_id`, `name`) VALUES
(1, '全新'),
(2, '近全新'),
(3, '良好 (輕微使用痕跡)'),
(4, '普通 (有明顯使用痕跡)'),
(5, '尚可 (有筆記或劃線)'),
(6, '可接受 (含大量筆記)'),
(7, '有水漬/污損'),
(8, '精裝版'),
(9, '平裝版'),
(10, '圖書館除役書');

-- 5. 書籍 (Book)
INSERT INTO `Book` (`book_id`, `title`, `isbn`, `description`) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', '978-0747532743', '一個男孩發現自己是巫師的故事。'),
(2, '1984', '978-0451524935', '一部關於極權主義的經典反烏托邦小說。'),
(3, 'The Lord of the Rings', '978-0618640157', '一場摧毀至尊魔戒的史詩冒險。'),
(4, '射鵰英雄傳', '978-9573268498', '郭靖與黃蓉的武俠傳奇。'),
(5, '三體', '978-7536692930', '地球文明與三體文明的生死搏鬥。'),
(6, '解憂雜貨店', '978-9865743190', '一個可以諮詢煩惱的神奇雜貨店。'),
(7, '挪威的森林', '978-9571352228', '一部關於青春、愛情與失落的成長小說。'),
(8, '人類大歷史：從野獸到扮演上帝', '978-9862419097', '從認知革命到科學革命，全面性的人類歷史。'),
(9, '原子習慣', '978-9861755267', '建立良好習慣、戒除壞習慣的實用指南。'),
(10, 'Clean Code: A Handbook of Agile Software Craftsmanship', '978-0132350884', '提升軟體品質與程式碼可讀性的經典之作。'),
(11, 'The Hobbit', '978-0345339683', '比爾博·巴金斯意外的冒險旅程。'),
(12, '白夜行', '978-9571050014', '一對男女跨越19年的罪與愛。');

-- 6. 書籍-作者關聯 (BookAuthor)
INSERT INTO `BookAuthor` (`book_id`, `author_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 3),
(12, 6);

-- 7. 書籍-分類關聯 (BookCategory)
INSERT INTO `BookCategory` (`book_id`, `category_id`) VALUES
(1, 1), (1, 3),
(2, 2), (2, 3),
(3, 1), (3, 3),
(4, 3), (4, 9),
(5, 2), (5, 3),
(6, 3), (6, 8),
(7, 3),
(8, 4), (8, 10),
(9, 5), (9, 6),
(10, 7),
(11, 1), (11, 3),
(12, 3), (12, 8);

-- 8. 刊登 (Listing)
INSERT INTO `Listing` (`listing_id`, `book_id`, `seller_id`, `condition_id`, `price`, `stock`, `status`) VALUES
(1, 1, 1, 2, 250.00, 1, 'sold'),    -- Alice sells Harry Potter
(2, 4, 6, 3, 400.00, 1, 'sold'),    -- 陳大文 sells 射鵰英雄傳
(3, 9, 2, 1, 300.00, 1, 'sold'),    -- Bob sells 原子習慣
(4, 10, 3, 3, 750.00, 1, 'sold'),   -- Charlie sells Clean Code
(5, 5, 7, 2, 320.00, 1, 'sold'),    -- 林小美 sells 三體
(6, 8, 4, 1, 380.00, 1, 'sold'),    -- David sells 人類大歷史
(7, 2, 1, 4, 150.00, 1, 'sold'),    -- Alice sells 1984
(8, 12, 6, 2, 280.00, 1, 'sold'),   -- 陳大文 sells 白夜行
(9, 7, 7, 3, 220.00, 1, 'sold'),    -- 林小美 sells 挪威的森林
(10, 3, 8, 4, 600.00, 1, 'sold'),   -- 黃阿財 sells The Lord of the Rings
(11, 6, 2, 2, 260.00, 1, 'sold'),   -- Bob sells 解憂雜貨店
(12, 11, 3, 2, 200.00, 1, 'sold'),  -- Charlie sells The Hobbit
(13, 1, 5, 3, 230.00, 1, 'sold'), -- Eve sells Harry Potter (NOW SOLD)
(14, 2, 4, 3, 180.00, 1, 'sold'), -- David sells 1984 (NOW SOLD)
(15, 9, 8, 2, 310.00, 1, 'sold'), -- 黃阿財 sells 原子習慣 (NOW SOLD)
-- Active Listings
(16, 10, 11, 1, 800.00, 1, 'active'),-- Heidi sells Clean Code
(17, 5, 12, 3, 315.00, 1, 'active'), -- Ivan sells 三體
(18, 4, 13, 2, 450.00, 1, 'active'), -- Judy sells 射鵰英雄傳
(19, 8, 14, 2, 370.00, 1, 'active'), -- Kevin sells 人類大歷史
(20, 7, 1, 4, 200.00, 1, 'active'); -- Alice sells 挪威的森林

-- 9. 刊登圖片 (ListingImage)
INSERT INTO `ListingImage` (`listing_id`, `url`) VALUES
(1, 'https://placehold.co/600x400.png?text=Harry+Potter'),
(2, 'https://placehold.co/600x400.png?text=射鵰英雄傳'),
(3, 'https://placehold.co/600x400.png?text=原子習慣'),
(4, 'https://placehold.co/600x400.png?text=Clean+Code'),
(5, 'https://placehold.co/600x400.png?text=三體'),
(6, 'https://placehold.co/600x400.png?text=人類大歷史'),
(7, 'https://placehold.co/600x400.png?text=1984'),
(8, 'https://placehold.co/600x400.png?text=白夜行'),
(9, 'https://placehold.co/600x400.png?text=挪威的森林'),
(10, 'https://placehold.co/600x400.png?text=LOTR'),
(11, 'https://placehold.co/600x400.png?text=解憂雜貨店'),
(12, 'https://placehold.co/600x400.png?text=The+Hobbit'),
(13, 'https://placehold.co/600x400.png?text=Harry+Potter+2'),
(14, 'https://placehold.co/600x400.png?text=1984+ver2'),
(15, 'https://placehold.co/600x400.png?text=原子習慣+新'),
(16, 'https://placehold.co/600x400.png?text=Clean+Code+mint'),
(17, 'https://placehold.co/600x400.png?text=三體+v2'),
(18, 'https://placehold.co/600x400.png?text=射鵰英雄傳+v2'),
(19, 'https://placehold.co/600x400.png?text=人類大歷史+v2'),
(20, 'https://placehold.co/600x400.png?text=挪威的森林+v2');

-- 10. 訂單 (Order)
INSERT INTO `Order` (`order_id`, `buyer_id`, `total_amount`, `status`) VALUES
(1, 9, 0.00, 'completed'),   -- Frank buys item
(2, 10, 0.00, 'completed'),  -- Grace buys item
(3, 7, 0.00, 'completed'),   -- 林小美 buys item
(4, 8, 0.00, 'shipped'),    -- 黃阿財 buys item
(5, 1, 0.00, 'paid'),       -- Alice buys item
(6, 2, 0.00, 'completed'),   -- Bob buys item
(7, 3, 0.00, 'cancelled'),  -- Charlie cancels
(8, 4, 0.00, 'completed'),   -- David buys items
(9, 5, 0.00, 'completed'),    -- Eve buys item
(10, 15, 0.00, 'shipped');    -- Linda buys item

-- 11. 訂單明細 (OrderItem)
INSERT INTO `OrderItem` (`order_id`, `listing_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 250.00),   -- Frank buys Harry Potter from Alice
(2, 3, 1, 300.00),   -- Grace buys 原子習慣 from Bob
(3, 2, 1, 400.00),   -- 林小美 buys 射鵰英雄傳 from 陳大文
(4, 4, 1, 750.00),   -- 黃阿財 buys Clean Code from Charlie
(5, 5, 1, 320.00),   -- Alice buys 三體 from 林小美
(6, 6, 1, 380.00),   -- Bob buys 人類大歷史 from David
-- Order 7 is cancelled, no items
(8, 7, 1, 150.00),   -- David buys 1984 from Alice
(8, 8, 1, 280.00),   -- David also buys 白夜行 from 陳大文 (multi-item order)
(9, 10, 1, 600.00),  -- Eve buys The Lord of the Rings from 黃阿財
(10, 11, 1, 260.00); -- Linda buys 解憂雜貨店 from Bob

-- 12. 更新訂單總金額 (Update Order Total Amount)
-- 根據 OrderItem 的內容，回填正確的總金額
UPDATE `Order` o
SET o.total_amount = (
    SELECT SUM(oi.quantity * oi.unit_price)
    FROM `OrderItem` oi
    WHERE oi.order_id = o.order_id
)
WHERE o.order_id IN (SELECT DISTINCT order_id FROM `OrderItem`);

-- 13. 評價 (Review)
-- 只有 'completed' 或 'shipped' 的訂單才能評價
INSERT INTO `Review` (`review_id`, `order_id`, `reviewer_id`, `rating`, `comment`) VALUES
(1, 1, 9, 5, '書況非常好，賣家出貨迅速，值得推薦！'),
(2, 2, 10, 5, '很棒的書，包裝得很仔細。'),
(3, 3, 7, 4, '書的邊角有一點點折到，但整體來說還不錯。'),
(4, 4, 8, 5, '專業賣家，回覆問題很快！'),
(5, 6, 2, 5, 'Exactly as described. Thank you!'),
(6, 8, 4, 5, '一次買了兩本，都很滿意，謝謝！'),
(7, 9, 5, 4, '書本比想像中舊一點，但還在可接受範圍。');

-- 14. 更新 Order 的 created_at
-- 將訂單建立時間更新為對應商品刊登時間的幾天後，以模擬真實銷售週期
UPDATE `Order` o
JOIN `OrderItem` oi ON o.order_id = oi.order_id
JOIN `Listing` l ON oi.listing_id = l.listing_id
SET o.created_at = l.created_at + INTERVAL 5 DAY
WHERE o.order_id IN (1, 6);

UPDATE `Order` o
JOIN `OrderItem` oi ON o.order_id = oi.order_id
JOIN `Listing` l ON oi.listing_id = l.listing_id
SET o.created_at = l.created_at + INTERVAL 12 DAY
WHERE o.order_id IN (2, 8);

UPDATE `Order` o
JOIN `OrderItem` oi ON o.order_id = oi.order_id
JOIN `Listing` l ON oi.listing_id = l.listing_id
SET o.created_at = l.created_at + INTERVAL 22 DAY
WHERE o.order_id IN (3, 9);

UPDATE `Order` o
JOIN `OrderItem` oi ON o.order_id = oi.order_id
JOIN `Listing` l ON oi.listing_id = l.listing_id
SET o.created_at = l.created_at + INTERVAL 35 DAY
WHERE o.order_id IN (4, 10);
