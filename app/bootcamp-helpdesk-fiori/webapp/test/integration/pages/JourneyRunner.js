sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"bootcamphelpdeskfiori/bootcamphelpdeskfiori/test/integration/pages/TicketsList.gen",
	"bootcamphelpdeskfiori/bootcamphelpdeskfiori/test/integration/pages/TicketsObjectPage.gen"
], function (JourneyRunner, TicketsListGenerated, TicketsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('bootcamphelpdeskfiori/bootcamphelpdeskfiori') + '/test/flp.html#app-preview',
        pages: {
			onTheTicketsListGenerated: TicketsListGenerated,
			onTheTicketsObjectPageGenerated: TicketsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

