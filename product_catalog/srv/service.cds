using {db as my} from '../db/data/schema.cds';

service MyFirstService {
    @odata.draft.enabled
    entity productos as projection on my.productos;
}
