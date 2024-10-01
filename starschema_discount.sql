-- Fact Table
create view fact_sales as
select t.transactionid, t.storeid, t.saleschannelid, s.categoryid, t.discountpct,
s.sizeofshoe
from saletransaction t
join saleitem s
on t.transactionid = s.transactionid;

select * from fact_sales;

-- Category Dimension
create view dim_category as
select c.categoryid, c.categoryname, m.subcategoryid, f.subcategoryname
from maincategory c
join categorymap m 
on c.categoryid = m.maincategoryid
join subcategory f
on m.subcategoryid = f.subcategoryid;

select * from dim_category;

-- Sale channel dimension
create view dim_saleschannel as
select * from saleschannel;

-- store dimension
create view dim_store as
select storeid, storename, country
from storeinfo;

select * from dim_saleschannel;

select * from dim_store;

-- Generate report 
select dim_saleschannel.saleschannelname, count(fact_sales.transactionid) 
from fact_sales
join dim_saleschannel
on fact_sales.saleschannelid = dim_saleschannel.saleschannelid
where fact_sales.discountpct = 0
group by dim_saleschannel.saleschannelname;

select storeid, count(transactionid) from fact_sales
where discountpct = 0
group by storeid;


