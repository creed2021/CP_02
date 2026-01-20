using {
    cuid,
    managed
} from '@sap/cds/common';

namespace com.logali;

type Name               : String(50);

type Gender             : String enum {
    male;
    female;
}

type OrderStatus        : Integer enum {
    submitted = 1;
    fulfiller = 2;
    shipped = 3;
    cancel = -1;
}

type Priority           : String enum {

    high;
    medium;
    low;
}

type Address            : {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};


type EmailsAddresses_01 : {
    kind  : String;
    email : String;
};

type EmailsAddresses_02 : {
    kind  : String;
    email : String;
};

/** Tipo "matriz" (con colecciones) */
type Emails             : {
    email_01 : EmailsAddresses_01;
    email_02 : many EmailsAddresses_02;
    email_03 : many {
        kind  : String;
        email : String;
    };
};


entity productos : cuid, managed {
    name             : String not null;
    Descripcion      : String;
    ImageUrl         : String;
    ReleaseDate      : DateTime default $now;
    DiscontinuedDate : DateTime;
    Price            : Decimal(16, 2);
    Height           : type of Price;
    Width            : Decimal(16, 2);
    Depth            : Decimal(16, 2);
    Quantity         : Decimal(16, 2);

}

entity Suppliers : cuid, managed {
    name    : type of productos : name;
    address : Address;
    email   : String;
    phone   : String;
    fax     : String;
}

entity Categories : cuid, managed {
    key ID   : String(1);
        Name : String;
}

entity StockAvailability : cuid, managed {
    Description : String;
}


entity UnitOfMeasures {
    key ID          : String(2);
        Description : String;
}


entity DimensionUnits {
    key ID          : String(2);
        Description : String;
}

entity Months {
    key ID               : String(2); // 01..12
        Description      : String; // January, February, ...
        ShortDescription : String(3); // Jan, Feb, ...
}

entity ProductReview {
    key Name    : String;
    key Rating  : Integer;
        Comment : String;
}

entity SalesData : cuid, managed {
    DeliveryDate : DateTime;
    Revenue      : Decimal(16, 2);
}

entity Order : cuid, managed {
    clientGender : Gender;
    status       : OrderStatus;
    priority     : Priority;
}

entity Car : cuid, managed {
            name       : String;
    virtual discount_1 : Decimal;
    virtual discount_2 : Decimal;
}

entity prueba as select from productos;

entity prueba2 as select from Car;

entity prueba3 as projection on productos;