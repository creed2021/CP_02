using {com.logali as my} from '../db/schema';
using {com.training as myt} from '../db/training';

service CatalogService {

    //entity productos         as projection on my.materials.Productos;

    //entity Suppliers     as projection on my.sales.Suppliers;
    //entity Currency          as projection on my.materials.Currencies;
    //entity DimensionUnit     as projection on my.materials.DimensionUnits;
    //entity Category          as projection on my.materials.Categories;
    //entity SalesData     as projection on my.sales.SalesData;
    //entity Reviews       as projection on my.materials.ProductReview;
    //entity UnitOfMeasure     as projection on my.materials.UnitOfMeasures;
    entity Months            as projection on my.sales.Months;
    entity Course            as projection on myt.Course;

    @odata.draft.enabled
    entity Products          as
        select from my.materials.Productos {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity                         @(
                mandatory,
                assert.range: [
                    0,
                    20
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Category      as ToCategory      @mandatory,
            Category.Name as Category        @readonly,
            DimensionUnit as todimensionunit,
            SalesData,
            Supplier,
            Reviews
        }

    entity Suppliers         as
        select from my.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as Product
        }

    @readonly
    entity Reviews           as
        select from my.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product

        }

    @readonly
    entity SalesData         as
        select from my.sales.SalesData {

            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as currencykey,
            DeliveryMonth.ID          as deliverymonthid,
            DeliveryMonth.Description as deliverymonth,
            Product                   as toproduct
        }

    @readonly
    entity StockAvailability as
        select from my.materials.StockAvailability {
            ID,
            Description
        }

    @readonly
    entity VH_Categories     as
        select from my.materials.Categories {
            ID   as Code,
            Name as Text
        }

    @readonly
    entity VH_Currencies     as
        select from my.materials.Currencies {

            ID          as Code,
            Description as Text
        }

    @readonly
    entity VH_UnitOfMeasure  as
        select from my.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text

        }

    @readonly
    entity VH_DimensionUnits as
        select from my.materials.DimensionUnits {
            ID          as Code,
            Description as Text
        }
}

define service MyService {

    entity SuppliersProduct as
        select from my.materials.Productos[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;

    entity SupliersToSales  as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from my.materials.Productos
}
