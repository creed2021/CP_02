sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"db/productos/test/integration/pages/productosList",
	"db/productos/test/integration/pages/productosObjectPage"
], function (JourneyRunner, productosList, productosObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('db/productos') + '/test/flp.html#app-preview',
        pages: {
			onTheproductosList: productosList,
			onTheproductosObjectPage: productosObjectPage
        },
        async: true
    });

    return runner;
});

