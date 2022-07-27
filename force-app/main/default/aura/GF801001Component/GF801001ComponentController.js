({
	New : function(component, event, helper) {
        var url = '/apex/grung__OpenDummyWindow?pageName=GF801002View';
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
	}
})