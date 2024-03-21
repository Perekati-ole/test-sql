/*
    Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта,
    используя функцию dbo.udf_GetSKUPrice
*/
create or alter view dbo.vw_SKUPrice
as
select s.*, dbo.udf_GetSKUPrice(s.ID) as SKUPrice
from dbo.SKU as s

