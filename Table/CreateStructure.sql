if object_id('dbo.SKU') is null
begin
    create table dbo.SKU (
        ID int not null identity,
        Code as 's' + cast(ID as varchar(255)),
        Name varchar(255),
        constraint UK_SKU_Code unique (Code),
        constraint PK_SKU primary key clustered (ID)
    )
end

if object_id('dbo.Family') is null
begin
    create table dbo.Family (
        ID int not null identity,
        SurName varchar(255),
        BudgetValue decimal(18, 2),
        constraint PK_Family primary key clustered (ID)
    )
end

if object_id('dbo.Basket') is null
begin
    create table dbo.Basket (
        ID int not null identity,
        ID_SKU int,
        ID_Family int,
        Quantity decimal(18, 2),
        Value decimal(18, 2),
        PurchaseDate datetime constraint DF_Family_PurchaseDate default getdate(),
        DiscountValue decimal(18, 2),
        constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID),
        constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID),
        constraint CK_Family_Quantity check (Quantity >= 0),
        constraint CK_Family_Value check (Value >= 0)
    )
end


