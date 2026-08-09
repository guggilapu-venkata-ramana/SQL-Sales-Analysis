-- ============================================================
-- SALES ANALYSIS PROJECT
-- Database: Oracle SQL
-- Table: SALES_DATA
-- ============================================================

-- PROJECT OBJECTIVE:
-- Analyze sales performance across customers, products,
-- categories, regions, states, months and payment modes.


-- ============================================================
-- 1. CHECK TABLE STRUCTURE
-- ============================================================

DESC sales_data;


-- ============================================================
-- 2. CHECK TOTAL RECORDS
-- ============================================================

SELECT COUNT(*) AS TOTAL_RECORDS
FROM sales_data;


-- ============================================================
-- 3. TOTAL SALES
-- ============================================================

SELECT
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data;


-- ============================================================
-- 4. TOTAL ORDERS
-- ============================================================

SELECT COUNT(*) AS TOTAL_ORDERS
FROM sales_data;


-- ============================================================
-- 5. TOTAL CUSTOMERS
-- ============================================================

SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMERS
FROM sales_data;


-- ============================================================
-- 6. AVERAGE ORDER VALUE
-- ============================================================

SELECT
    ROUND(
        AVG(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS AVG_ORDER_VALUE
FROM sales_data;


-- ============================================================
-- 7. SALES BY CATEGORY
-- ============================================================

SELECT
    CATEGORY,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY CATEGORY
ORDER BY TOTAL_SALES DESC;


-- ============================================================
-- 8. SALES BY REGION
-- ============================================================

SELECT
    REGION,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY REGION
ORDER BY TOTAL_SALES DESC;


-- ============================================================
-- 9. SALES BY PAYMENT MODE
-- ============================================================

SELECT
    PAYMENT_MODE,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY PAYMENT_MODE
ORDER BY TOTAL_SALES DESC;


-- ============================================================
-- 10. SALES BY PRODUCT
-- ============================================================

SELECT
    PRODUCT,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY PRODUCT
ORDER BY TOTAL_SALES DESC;


-- ============================================================
-- 11. SALES BY STATE
-- ============================================================

SELECT
    STATE,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY STATE
ORDER BY TOTAL_SALES DESC;


-- ============================================================
-- 12. MONTHLY SALES TREND
-- ============================================================

SELECT
    TO_CHAR(ORDER_DATE, 'MON') AS MONTH,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY
    TO_CHAR(ORDER_DATE, 'MON'),
    TO_CHAR(ORDER_DATE, 'MM')
ORDER BY TO_CHAR(ORDER_DATE, 'MM');


-- ============================================================
-- 13. SALES BY CUSTOMER
-- ============================================================

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY CUSTOMER_ID, CUSTOMER_NAME
ORDER BY TOTAL_SALES DESC;


-- ============================================================
-- 14. TOTAL QUANTITY SOLD
-- ============================================================

SELECT
    SUM(QUANTITY) AS TOTAL_QUANTITY_SOLD
FROM sales_data;


-- ============================================================
-- 15. AVERAGE DISCOUNT
-- ============================================================

SELECT
    ROUND(AVG(DISCOUNT), 2) AS AVG_DISCOUNT
FROM sales_data;


-- ============================================================
-- 16. HIGHEST-VALUE ORDER
-- ============================================================

SELECT
    ORDER_ID,
    CUSTOMER_NAME,
    PRODUCT,
    ROUND(
        QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100),
        2
    ) AS ORDER_SALES
FROM sales_data
ORDER BY ORDER_SALES DESC;


-- ============================================================
-- 17. SALES BEFORE AND AFTER DISCOUNT
-- ============================================================

SELECT
    ROUND(SUM(QUANTITY * UNIT_PRICE), 2) AS SALES_BEFORE_DISCOUNT,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS SALES_AFTER_DISCOUNT,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (DISCOUNT / 100)),
        2
    ) AS TOTAL_DISCOUNT_AMOUNT
FROM sales_data;


-- ============================================================
-- 18. CUSTOMERS WITH MULTIPLE ORDERS
-- ============================================================

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    COUNT(*) AS ORDER_COUNT,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES
FROM sales_data
GROUP BY CUSTOMER_ID, CUSTOMER_NAME
HAVING COUNT(*) > 1
ORDER BY ORDER_COUNT DESC;


-- ============================================================
-- 19. TOP 3 CUSTOMERS BY SALES
-- ============================================================

SELECT *
FROM (
    SELECT
        CUSTOMER_ID,
        CUSTOMER_NAME,
        ROUND(
            SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
            2
        ) AS TOTAL_SALES
    FROM sales_data
    GROUP BY CUSTOMER_ID, CUSTOMER_NAME
    ORDER BY TOTAL_SALES DESC
)
WHERE ROWNUM <= 3;


-- ============================================================
-- 20. PRODUCT SALES RANKING
-- ============================================================

SELECT
    PRODUCT,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES,
    RANK() OVER (
        ORDER BY SUM(
            QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)
        ) DESC
    ) AS SALES_RANK
FROM sales_data
GROUP BY PRODUCT
ORDER BY SALES_RANK;


-- ============================================================
-- 21. OVERALL SALES SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS TOTAL_ORDERS,
    COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMERS,
    SUM(QUANTITY) AS TOTAL_QUANTITY_SOLD,
    ROUND(
        SUM(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS TOTAL_SALES,
    ROUND(
        AVG(QUANTITY * UNIT_PRICE * (1 - DISCOUNT / 100)),
        2
    ) AS AVG_ORDER_VALUE,
    ROUND(AVG(DISCOUNT), 2) AS AVG_DISCOUNT
FROM sales_data;





