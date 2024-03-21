 /*
    Обновляем поле "BudgetValue" в таблице "dbo.Family" по логике:
    "dbo.Family.BudgetValue - sum(dbo.Basket.Value)", где "dbo.Basket.Value" покупки для переданной в процедуру семьи
*/
create or alter procedure dbo.usp_MakeFamilyPurchase(
    @FamilySurName varchar(255)
)
as
begin
    if exists (
        select f.SurName
        from dbo.Family as f
        where f.SurName = @FamilySurName
    )
    update f
    set f.BudgetValue = f.BudgetValue - (
        select sum(b.Value)
        from dbo.Family as f
            -- Объединяем таблицы "dbo.Family" и "dbo.Basket", чтобы по "ID_Family" подтянуть "Value" 
            inner join dbo.Basket as b on b.ID_Family = f.ID
			    where f.SurName = @FamilySurName
		        group by f.SurName
	        )
            from dbo.Family as f
            where f.Surname = @FamilySurName
    else
    print 'Семьи "' + @FamilySurName + '" не сущетвует в таблице "dbo.Family"'
end