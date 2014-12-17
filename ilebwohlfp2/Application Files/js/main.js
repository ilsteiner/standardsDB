//Highlight the correct button for the current page
$(".navButton").click(function() {
	$(".navButton").removeClass('navSelected');

	$(this).addClass('navSelected');
});

$(function() {
	//Make tooltips look better
    $( document ).tooltip();

    $("option").tooltip();
 });