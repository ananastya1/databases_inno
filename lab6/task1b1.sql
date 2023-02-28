SELECT 
    orders.orderId, 
    SUM(order_items.quantity) AS total_items, 
    SUM(order_items.quantity * items.price) AS total_amount 
FROM 
    orders 
    JOIN order_items ON orders.orderId = order_items.orderId 
    JOIN items ON order_items.itemId = items.itemId 
GROUP BY 
    orders.orderId;
