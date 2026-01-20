using {com.logali as my} from '../db/schema';

service MyFirstService {
    @odata.draft.enabled
    entity productos         as projection on my.productos;
    entity Suppliers         as projection on my.Suppliers;
    entity Categories        as projection on my.Categories;
    entity StockAvailability as projection on my.StockAvailability;
    entity UnitOfMeasures    as projection on my.UnitOfMeasures;
    entity DimensionUnits    as projection on my.DimensionUnits;
    entity Months            as projection on my.Months;
    entity ProductReview     as projection on my.ProductReview;
    entity SalesData         as projection on my.SalesData;
    entity Order             as projection on my.Order;
    entity Car               as projection on my.Car;
}
