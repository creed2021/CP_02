namespace com.training;

using {
    cuid,
    managed
} from '@sap/cds/common';



// entity ParamProductos(pName: String)  as
//  select from productos {
//    name,
//   Price,
//  Quantity
//  }
//  where
//    name = :pName;

// entity ProjParamProducts(pName: String) as projection on productos
//                                       where
//                                         name = :pName;


entity Course {
    key ID      : UUID;
        Student : Association to many StudentCourse
                      on Student.Course = $self;
}

entity Student {
    key ID     : UUID;
        Course : Association to many StudentCourse
                     on Course.Student = $self;
}

entity StudentCourse : cuid, managed {
    Student : Association to Student;
    Course  : Association to Course;
}

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
