

-- task 1 

create view OrdersView as 
select orderID, quantity, totalCost 
from orders inner join menuorderdetail on orders.orderID = menuorderdetail.fk_orderID;

-- task 2

select customerID, customerName, orderID, totalCost, itemName, itemType
from customers inner Join bookings on customers.customerID = bookings.fk_CustomerID inner join orders on bookings.bookingID = orders.fk_bookingID 
inner join menuorderdetail on orders.orderID = menuorderdetail.fk_orderID inner join menu on menuorderdetail.fk_menuID = menu.menuID
where totalCost > 29.00
order by totalCost asc;


-- task 3 

select itemName, itemType 
from menu 
where menuID in (
select fk_menuID from menuorderdetail where quantity >1);


-- task 1.1

call GetMaxQuantity();


-- task 1.2

prepare GetOrderDetail from 'select orderID, quantity, totalCost
from bookings inner join orders on bookings.bookingID = orders.fk_bookingID inner join menuorderdetail on orders.orderID = menuorderdetail.fk_orderID
where fk_CustomerID = ? ';

set @id = 1;
execute GetOrderDetail using @id;

-- task 1.3

call CancelOrder(4);

select * from orders;



