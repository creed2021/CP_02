using {
    cuid,
    managed
} from '@sap/cds/common';


namespace com.logali;

type Name        : String(50);

type Gender      : String enum {
    male;
    female;
}

type OrderStatus : Integer enum {
    submitted = 1;
    fulfiller = 2;
    shipped = 3;
    cancel = -1;
}

type Priority    : String enum {

    high;
    medium;
    low;
}

type Address     : {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

context materials {

    entity Productos : cuid, managed {
        Name             : localized String not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to one sales.Suppliers;
        UnitOfMeasure    : Association to UnitOfMeasures;
        DimensionUnit    : Association to DimensionUnits;
        Currency         : Association to Currencies;
        Category         : Association to Categories;
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
    }


    entity Categories : cuid, managed {
        key ID   : String(1);
            Name : localized String;
    }

    entity StockAvailability : cuid, managed {
        Description : localized String;
    }

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    }


    entity DimensionUnits {
        key ID          : String(2);
            Description : localized String;
    }


    entity ProductReview : cuid, managed {
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to Productos;

    }


    entity SelProducts   as select from Productos;

    entity SelProducts1  as
        select from Productos {
            *
        };

    entity SelProducts2  as
        select from Productos {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3  as
        select from Productos
        left join ProductReview
            on Productos.Name = ProductReview.Name
        {
            Rating               as Rating,
            Productos.Name       as Name,
            sum(Productos.Price) as TotalPrice
        }
        group by
            Rating,
            Productos.Name
        order by
            Rating;


    entity ProjProducts  as projection on Productos;

    entity ProjProducts2 as
        projection on Productos {
            *
        };

    entity ProjProducts3 as
        projection on Productos {
            ReleaseDate,
            Name
        };

    extend Productos with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
    }


}

context sales {

    entity Suppliers : cuid, managed {
        Name    : String;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Productos
                      on Product.Supplier = $self;
    }


    entity Months {
        key ID               : String(2); // 01..12
            Description      : localized String; // January, February, ...
            ShortDescription : localized String(3); // Jan, Feb, ...
    }

    entity SalesData : cuid, managed {
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to materials.Productos;
        Currency      : Association to materials.Currencies;
        DeliveryMonth : Association to Months;
    }

    entity Order : cuid, managed {
        ClientGender : Gender;
        Status       : OrderStatus;
        Priority     : Priority;
    }

    entity Car : cuid, managed {
                name       : String;
        virtual discount_1 : Decimal;
        virtual discount_2 : Decimal;
    }

    entity Orders : cuid {
        Date     : DateTime;
        Customer : String;
        item     : Composition of many OrderItem
                       on item.Order = $self;
    }

    entity OrderItem : cuid {
        Order    : Association to Orders;
        Product  : Association to materials.Productos;
        Quantity : Integer;


    }


}
