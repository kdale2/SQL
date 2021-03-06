/*Purpose: Create a relational database schema consisting of four relation schemas 
representing various entities recorded by a furniture company. Define all necessary 
attributes, domains, and primary and foreign keys. */

drop table FullOrder;
drop table Request;
drop table Customer;
drop table Product;

create table Customer (
  CustomerID    number(3),
  Name      	varchar(25),
  Address       varchar(50),
  
  primary key (CustomerID)

); 

create table FullOrder (
  OrderID       number(5),
  OrderDate   	DATE,
  CustomerID    number(3),
  
  primary key (OrderID),
  foreign key (CustomerID) references Customer(CustomerID)
); 

create table Product (
	ProductID		number(2),
	Description		varchar(28),
	Finish			varchar(10),
	Price			number(5,2),

	primary key (ProductID)
);

create table Request (
	OrderID	number(5),
	ProductID	number(2),
	Quantity	number,

	foreign key (OrderID) references FullOrder(OrderID),
	foreign key (ProductID) references Product(ProductID),
	
	CONSTRAINT check_quantity
		CHECK (Quantity BETWEEN 1 and 101)
);

delete from Customer;
delete from FullOrder;
delete from Product;
delete from Request;


insert into Customer
    values ( 2, 'Casual Furniture', 'Plano, TX');
insert into Customer
    values ( 6, 'Mountain Gallery', 'Boulder, CO');
    
insert into FullOrder
    values ( 1006, '24-MAR-10', 2);
insert into FullOrder
    values ( 1007, '25-MAR-10', 6);
insert into FullOrder
    values ( 1008, '25-MAR-10', 6);
insert into FullOrder
    values ( 1009, '26-MAR-10', 2);
	
insert into Product
    values ( 10, 'Writing Desk', 'Oak', 425);
insert into Product
    values ( 30, 'Dining Table', 'Ash', 600);
insert into Product
    values ( 40, 'Entertainment Center', 'Maple', 650);
insert into Product
    values ( 70, 'Childrens Dresser', 'Pine', 300);
    
insert into Request
	values (1006, 10, 4);
insert into Request
	values (1006, 30, 2);
insert into Request
	values (1006, 40, 1);
insert into Request
	values (1007, 40, 3);
insert into Request
	values (1007, 70, 2);
insert into Request
	values (1008, 70, 1);
insert into Request
	values (1009, 10, 2);
insert into Request
	values (1009, 40, 1);
	
SELECT *
FROM Customer;

SELECT *
FROM FullOrder;

SELECT *
FROM Request;

SELECT *
FROM Product;
