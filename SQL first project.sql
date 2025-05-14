SELECT * 
FROM vgsales;

create table vgsales_2
Like vgsales
;

insert vgsales_2
select *
from vgsales;

Select *,
row_number() over(partition by 'Rank', Name, platform, 'year', genre,
 publisher, NA_sales, EU_Sales, JP_Sales, Other_sales, global_sales) as row_num
From vgsales
;

with duplicate_cte as
(Select *,
row_number() over(partition by 'Rank', Name, platform, 'year', genre,
 publisher, NA_sales, EU_Sales, JP_Sales, Other_sales, global_sales) as row_num
From vgsales)
select *
from duplicate_cte 
where row_num >1;


select distinct Platform
from vgsales_2
where Platform like 'P%%';


select distinct Genre
from vgsales_2;

select distinct Publisher
from vgsales_2
where Publisher like 'N/A';


select *
from vgsales_2
where Publisher like 'N/A';

select *
from vgsales_2
where Year = '';

select max(Na_Sales), min(NA_Sales)
from vgsales_2;

-- Sales Over Time

select year,
format(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 4) as Total_Sales
from vgsales_2
group by 1
order by 1 DESC;

-- Genre Performance

select genre,
sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales) as Total_Sales
from vgsales_2
group by Genre
order by 2 DESC;


select Platform,
sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales) as Total_Sales
from vgsales_2
group by Platform
order by 2 DESC;

select Publisher,
sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales) as Total_Sales
from vgsales_2
group by Publisher
order by 2 DESC;


Select Year,
sum(NA_Sales) as NA_sales,
Sum(EU_Sales) as EU_sales,
Sum(JP_Sales) as JP_sales,
Sum(Other_Sales) as Other_sales,
Sum(Global_Sales) as Global_sales
From vgsales_2
group by Year
Order by 1;


-- Top-selling games 

select
name,
Format(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 4) as Total_Sales
from vgsales_2
group by Name
order by Total_Sales DESC LIMIT 10;

select genre, platform,
Format(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 4) as Total_Sales
from vgsales_2
group by Genre, Platform
order by Total_Sales DESC;



select Publisher, platform,
Format(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 4) as Total_Sales
from vgsales_2
group by Publisher, Platform
order by Total_Sales DESC;

-- Year over Year growth/decline

Select Year, 
sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales) as Total_Sales,
lag(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 1)
Over (Order by year) as Prev_year_sales, sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales) - 
lag(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 1)
Over (Order by year) / lag(sum(NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales), 1)
Over(Order by year)  * 100 as growth_rate
from vgsales_2
group by Year
order by Year;

-- sales distribution
Select year,  





