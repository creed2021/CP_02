using {com.logali as logali} from '../db/schema';
using {com.training as training} from '../db/training';

service CatalogService {

    //entity productos         as projection on my.materials.Productos;

    //entity Suppliers     as projection on my.sales.Suppliers;
    //entity Currency          as projection on my.materials.Currencies;
    //entity DimensionUnit     as projection on my.materials.DimensionUnits;
    //entity Category          as projection on my.materials.Categories;
    //entity SalesData     as projection on my.sales.SalesData;
    //entity Reviews       as projection on my.materials.ProductReview;
    //entity UnitOfMeasure     as projection on my.materials.UnitOfMeasures;
    entity Months            as projection on logali.sales.Months;
    entity Course            as projection on training.Course;

    @odata.draft.enabled
    entity Products          as
        select from logali.Reports.Products {
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
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailability
        }

    entity Suppliers         as
        select from logali.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as Product
        }

    @readonly
    entity Reviews           as
        select from logali.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product

        }

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {

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
        select from logali.materials.StockAvailability {
            ID,
            Description
        }

    @readonly
    entity VH_Categories     as
        select from logali.materials.Categories {
            ID   as Code,
            Name as Text
        }

    @readonly
    entity VH_Currencies     as
        select from logali.materials.Currencies {

            ID          as Code,
            Description as Text
        }

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text

        }

    @readonly
    entity VH_DimensionUnits as
        select from logali.materials.DimensionUnits {
            ID          as Code,
            Description as Text
        }
}

define service MyService {

    entity SuppliersProduct as
        select from logali.materials.Productos[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;

    entity SupliersToSales  as
        select from logali.materials.Productos {
            key Supplier.ID as SupplierID,
                Supplier.Email,
                Category.Name,
                SalesData.Currency.ID,
                SalesData.Currency.Description
        }

    entity EntityInfix      as
        select Supplier[Name = 'Exotic Liquids'].Phone from logali.materials.Productos
        where
            Productos.Name = 'Bread';

    entity EntityJoin       as
        select Phone from logali.materials.Productos
        left join logali.sales.Suppliers as Supp
            on (
                Supp.ID   = Productos.Supplier.ID
            )
            and Supp.Name = 'Exotic Liquids'
        where
            Productos.Name = 'Bread'

}

define service Reports {

    entity AverageRating as projection on logali.Reports.AverageRating;

    entity EntityCasting as
        select
            Description,
            ID,
            cast(
                Price as Integer
            ) as Price2
        from logali.materials.Productos;

    entity EntityExists  as
        select from logali.materials.Productos {
            Name
        }
        where
            exists Supplier[Name = 'Exotic Liquids']

    entity EntityPrueba  as
        select from logali.Reports.Prueba {
            Name,
            Description,
            Depth,
            DimensionUnit
        }
        where
            exists Supplier[Name = 'Exotic Liquids']

}

define service ManageOrders {

    entity Orders as projection on training.Orders;


}
