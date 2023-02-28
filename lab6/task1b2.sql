SELECT 
    orders.customerId, 
    SUM(order_items.quantity * items.price) AS total_spent 
FROM 
    orders 
    JOIN order_items ON orders.orderId = order_items.orderId 
    JOIN items ON order_items.itemId = items.itemId 
GROUP BY 
    orders.customerId 
ORDER BY 
    total_spent DESC 
LIMIT 1;
