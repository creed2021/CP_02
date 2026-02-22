
using {com.training as training} from '../db/training';

define service ManageOrders {

    entity Orders as projection on training.Orders;

    entity Orders2 as select from training.Orders{
        ClientEmail,
        FirstName,
        LastName
    };


}
