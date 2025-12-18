/*
You have a table stock_prices. 
The table includes stock, trade_date, and price. Some price values are NULL due to missing data.

Task is to forward-fill the NULL price values for each stock independently, using the most recent available price.
*/

use db_questions;

/*
CREATE TABLE stock_prices (
  stock VARCHAR(10) NOT NULL,
  trade_date DATE NOT NULL,
  price DECIMAL(10, 2),
  PRIMARY KEY (stock, trade_date)
);

INSERT INTO stock_prices (stock, trade_date, price) VALUES
('AAPL', '2099-01-01', 150.00),
('AAPL', '2099-01-02', NULL),
('AAPL', '2099-01-03', NULL),
('AAPL', '2099-01-04', 155.00),
('MSFT', '2099-01-01', 250.00),
('MSFT', '2099-01-02', NULL),
('MSFT', '2099-01-03', 252.00);
*/

with t1 as(
select *,
		case when price is not null then 1 else 0 end as reset_flag
		--sum(price) over(partition by stock order by trade_date asc) as modified_price
from stock_prices
), t2 as(
select *,
		sum(reset_flag) over(partition by stock order by trade_date asc) as flag
from t1
)
select stock,
	trade_date,
	price,
	sum(price) over(partition by stock,flag order by trade_date asc) as modified_price
from t2;

