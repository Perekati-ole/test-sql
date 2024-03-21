/*
    Если в таблицу "dbo.Basket" за раз добавляются 2 и более записей одного "ID_SKU",
    то значение в поле "DiscountValue", для этого "ID_SKU" рассчитывается по формуле "Value" * 5%, иначе "DiscountValue" = 0
*/
create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
    update b
    set DiscountValue =
        case 
	        when c > = 2
                then Value * 0.05
	        else 0
	    end
	from dbo.Basket as b
        -- Выводим количество новых записей для каждого добавленного "ID_SKU"
	    inner join (
		    select i.ID_SKU, count(*) as c
		    from inserted as i
		    group by i.ID_SKU
	    ) i on b.ID_SKU = i.ID_SKU
end