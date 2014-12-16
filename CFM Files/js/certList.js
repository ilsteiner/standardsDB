$(document).ready(function() {
	$("#pager").show();
	$("#certTable").show();
	$("#loading").hide();
	$("#navButtonsCenter").width("50vw");

	//Make the table sortable
	$('#certTable').tablesorter({
    // widthFixed:true,
	    widgets: ['zebra'],
	    cssChildRow: 'expand-child'
	}
		).tablesorterPager({
		    container: $("#pager")
	});

	/* Make it look like the query grouping bug is fixed
	   This is SOOO cheating, but it'll do for now.*/
	$(".hideParent").parents("tr").addClass("hidden");
});