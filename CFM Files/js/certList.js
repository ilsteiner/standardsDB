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
});