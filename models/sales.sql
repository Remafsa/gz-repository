{{ config(schema='transaction') }}

WITH 

  sales AS (SELECT * FROM {{ ref('stg_sales') }} )

  ,product AS (SELECT * FROM {{ ref('stg_product') }})

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id
  ###########
	-- qty --
	,s.qty
  -- revenue --
  ,s.turnover
  -- cost --
    ,p.purchase_price
	,ROUND(s.qty* purchase_price) AS purchase_cost
	-- margin --
	,{{margin('s.turnover', 'ROUND(s.qty*purchase_price,2)')}} AS product_margin
    , {{ margin_percent('s.turnover', 's.qty*purchase_price') }} as product_margin_percent
FROM sales s
INNER JOIN product p ON s.products_id = p.products_id