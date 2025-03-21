sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ust/prashant/purchaseorderapp/test/integration/FirstJourney',
		'ust/prashant/purchaseorderapp/test/integration/pages/POsList',
		'ust/prashant/purchaseorderapp/test/integration/pages/POsObjectPage',
		'ust/prashant/purchaseorderapp/test/integration/pages/PoItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PoItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ust/prashant/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePoItemsObjectPage: PoItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);