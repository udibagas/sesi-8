-- SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
--     [ { * | expression [ [ AS ] output_name ] } [, ...] ]
--     [ FROM from_item [, ...] ]
--     [ WHERE condition ]
--     [ GROUP BY [ ALL | DISTINCT ] grouping_element [, ...] ]
--     [ HAVING condition ]
--     [ WINDOW window_name AS ( window_definition ) [, ...] ]
--     [ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
--     [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
--     [ LIMIT { count | ALL } ]
--     [ OFFSET start [ ROW | ROWS ] ]
--     [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } { ONLY | WITH TIES } ]
--     [ FOR { UPDATE | NO KEY UPDATE | SHARE | KEY SHARE } [ OF table_name [, ...] ] [ NOWAIT | SKIP LOCKED ] [...] ]

-- SELECT [column...]
-- FROM [table]
-- JOIN [table] ON pk = fk
-- WHERE [...condition]
-- GROUP BY [column, ...]
-- HAVING [condition]
-- ORDER BY [column, ...]
-- LIMIT [number]
-- OFFSET [number]

update "Orders" set "totalAmount" = price * qty;

-- select distinct(gender) as "Jenis Kelamin" from "Customers";
select
    o.date,
    p.name as "Product",
    o.qty,
    o.price,
    o."totalAmount",
    c.name as "Customer"
from
    "Orders" o
    join "Customers" c on c.id = o."CustomerId"
    join "Products" p on p.id = o."ProductId"
where
    qty > 10
    and date between '2024-08-01' and '2024-08-31';

select
    o.date,
    p.name as "Product",
    o.qty,
    o.price,
    o."totalAmount",
    c.name as "Customer"
from
    "Orders" o
    join "Customers" c on c.id = o."CustomerId"
    join "Products" p on p.id = o."ProductId"
where (
        qty > 10
        or o."totalAmount" >= 1000000
    )
    and date between '2024-08-01' and '2024-08-31';

select * from "Orders" where "CustomerId" = 1 or "CustomerId" = 2;

select * from "Orders" where "CustomerId" not in (1, 2, 3);

select * from "Orders" where "price" between 50000 and 100000;
-- inklusif
select * from "Products" where name ilike 'a%';

select * from "Products" where name not ilike '__a%';

select * from "Customers" where name is not null;

select
    c.name as "Customer",
    date_part('year', date) as "Year",
    round(avg("totalAmount")) "Rata - Rata"
from "Orders" o
    join "Customers" c on c.id = o."CustomerId"
group by
    "Customer",
    "Year"
having
    avg("totalAmount") >= 1000000
order by "Year" asc, "Rata - Rata" desc
limit 10;

select * from "Orders" order by "id" asc limit 10 offset 20;