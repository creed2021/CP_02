using {
    cuid,
    managed
} from '@sap/cds/common';

namespace db;

entity productos : cuid, managed {
    name     : String;
    category : String;
}
