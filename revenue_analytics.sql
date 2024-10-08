select * from currencylist;

alter table currencylist
add column convertion_rate_to_dkk decimal(10, 4);

update currencylist
set convertion_rate_to_dkk = 0.64
where currencycode = 'NOK';

update currencylist
set convertion_rate_to_dkk = 0.66
where currencycode = 'SEK';

update currencylist
set convertion_rate_to_dkk = 1.00
where currencycode = 'DKK';

select p.paymentmethodname, st.country, 
SUM(s.totalprice-s.finalprice) as total_revenue,
SUM((s.totalprice-s.finalprice) * c.convertion_rate_to_dkk) as total_revenue_converted, 
extract(year from t.purchasedate) as year
from saleitem s
join saletransaction t
on s.transactionid = t.transactionid
join paymentmethod p
on p.paymentmethodid = t.paymentmethodid 
join storeinfo st
on st.storeid = t.storeid
join currencylist c
on c.currencycode = t.currencycode
group by st.country, p.paymentmethodname, year
order by year asc;

select country, paymentmethod;