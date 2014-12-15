$(document).ready(function() {
	//Take over the submit function of the new standard form
	// $("#newStandardForm").submit(addStandard);

	$("#newStandardForm").validate({
		  submitHandler: function(form) {
		    addStandard();
		  }
	});
});

function addStandard(){
	$.post("createStandard.cfm",$("#newStandardForm").serialize(),
		function(data){
			//Add the data from the query to the table on this page
            $("#formRow").parent().prepend(data);
		},"html");
	return false;
}