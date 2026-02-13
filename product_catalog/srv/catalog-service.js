const cds = require("@sap/cds")
const { SELECT } = cds.ql;
const { Orders } = cds.entities("com.training")

module.exports = (srv) => {
    srv.on("READ", "Orders", async (req) => {
        console.log("🚀 Entró al READ Orders");
        return await SELECT.from(Orders);
    });
}