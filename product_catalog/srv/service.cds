using {com.logali as my} from '../db/schema';
using {com.training as myt} from '../db/training';

service MyFirstService {
    @odata.draft.enabled
    entity productos     as projection on my.materials.Productos;

    entity Suppliers     as projection on my.sales.Suppliers;
    entity Currency      as projection on my.materials.Currencies;
    entity DimensionUnit as projection on my.materials.DimensionUnits;
    entity Category      as projection on my.materials.Categories;
    entity SalesData     as projection on my.sales.SalesData;
    entity Reviews       as projection on my.materials.ProductReview;
    entity UnitOfMeasure as projection on my.materials.UnitOfMeasures;
    entity Months        as projection on my.sales.Months;

    entity Course as projection on myt.Course;

}
