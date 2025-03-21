sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ust.prashant.purchaseorderapp',
            componentId: 'PoItemsObjectPage',
            contextPath: '/POs/Items'
        },
        CustomPageDefinitions
    );
});