select
    O.Market
    ,O.Category
    ,O.Region
    ,year(O.Order_Date) as Order_Year
    ,O.Customer_ID
    ,O.Customer_Name
    ,I.Total_Sales 
    ,O.Country
    ,O.City
    ,O.State
    ,O.Segment
    ,O.Order_ID
    ,O.Order_Date
    ,O.Sub_Category
    ,O.Product_ID
    ,O.Ship_Date
    ,O.Ship_Mode
    ,O.Sales_Value as Sales 
    ,O.Quantity
    ,O.Discount
    ,O.Profit
    ,O.Shipping_Cost
from 
    orders O 
inner join
    (select *
    from(
        select *,
            row_number() over(partition by Market, Category, Region, year order by Total_Sales desc) as Customer_Rank
        from(
            select 
                Market,
                Category,
                O.Region,
                year(Order_Date) as year,
                Customer_ID,
                sum(Sales_value) as Total_Sales
            from 
                orders O 
            left join 
                Returned_Orders R 
            on O.Order_ID = R.Order_ID
            where R.Returned is null
            and O.Segment <> 'Home Office'
            group by   Market,
                Category,
                O.Region,
                year(Order_Date),
                Customer_ID
            ) b
        ) a
    where Customer_Rank <= 20) I 
on O.Market = I.Market
and O.Category = I.Category
and O.Region = I.Region
and year(O.Order_Date) = I.year
and O.Customer_ID = I.Customer_ID;