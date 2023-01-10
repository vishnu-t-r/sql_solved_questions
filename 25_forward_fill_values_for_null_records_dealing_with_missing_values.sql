--	question?
--fill null values in table with previous non null values?
--table
--'currencyrate

/*
CREATE TABLE [dbo].[CurrencyRate](
	[CurrencyKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[EndOfDayRate] [float] NULL,
	[Date] [datetime] NULL );

*/

--insert data into currencyrate table
/*
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20201229,0.999800039992002, '2020-12-29');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20201230,1.00090081072966, '2020-12-30');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20201231,0.999600159936026, '2020-12-31');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210101,Null, '2021-01-01');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210102,Null, '2021-01-02');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210103,Null, '2021-01-03')
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210104,0.999500249875062, '2021-01-04');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210105,1.000200040008, '2021-01-05');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210106,0.999200639488409, '2021-01-06');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210107,1.000200040008, '2021-01-07');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210108,0.999600159936026, '2021-01-08');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210109,Null, '2021-01-09');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210110,Null, '2021-01-10');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210111,1.00090081072966, '2021-01-11');
INSERT [dbo].[CurrencyRate] ([CurrencyKey], [DateKey], [EndOfDayRate], [Date]) VALUES (3, 20210112,0.99930048965724, '2021-01-12');
*/


--query

--select * from currencyrate

with cte1 as
(
select *,
		count(endofdayrate) over(partition by currencykey order by datekey) as rate_grp
from currencyrate
)

select *,
		first_value(endofdayrate) over(partition by currencykey,rate_grp order by datekey asc) as nw_rate
		--last_value(endofdayrate) over(partition by currencykey,rate_grp order by datekey desc
		--range between unbounded preceding and unbounded following) as nw_rate
from cte1