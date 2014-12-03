//Update the list of selected elements
$(".active").click(function() {
	$(this).toggleClass('selected');

	//Clear the hidden input for the selected elements
	$("#elements").val("");

	//Put the text of the symbol for each selected element into an array
	var selElems = $(".selected > .symbol").map(function(){
						return $(this).text();
					}).get();
	
	//Convert that array to a comma delimited list and set it as the value of the hidden input
	$("#elements").val(selElems.join());

	//Submit the form to update the results
	$("#sliderForm").submit();
});

$("input").on('input change',function(){
	$("#sliderForm").submit();
});

$("#rangeSlider").on("slidestop", function(e){
    $("#sliderForm").submit();
});

//Code for the jQueryUI slider
$(function() {
    $( "#rangeSlider" ).slider({
      range: true,
      min: 2,
      max: 1002,
      step: 2,
      values: [ 2, 500 ],
      slide: function( event, ui ) {
      	$("#minThick").val(ui.values[ 0 ]);
      	$("#maxThick").val(ui.values[ 1 ]);
      	checkInfinite();
      }
    });
    $( "#minThick" ).val($( "#rangeSlider" ).slider( "values", 0 ));
    $( "#maxThick" ).val($( "#rangeSlider" ).slider( "values", 1 ));

    $("#minThick").change(function () {
	    var value = this.value;
	    if((parseInt(value) > parseInt($("#maxThick").val()))){
	    	$("#maxThick").val(value);
	    	$("#rangeSlider").slider("values",1,parseInt(value));
	    }
	    console.log(value);
	    $("#rangeSlider").slider("values",0,parseInt(value));
	});

	$("#maxThick").change(function () {
	    var value = this.value;
	    if((parseInt(value) < parseInt($("#minThick").val()))){
	    	$("#minThick").val(value);
	    	$("#rangeSlider").slider("values",0,parseInt(value));
	    }
	    console.log(value);
	    $("#rangeSlider").slider("values",1,parseInt(value));
	});
  });

//Take over the submit function of the form
$(document).ready(function() {
	$("#sliderForm").submit(updateList);
});

//Query the DB for the parts associated with the parameters selected
function updateList() {
	$.post('inventory.cfm', $('input').serialize(),function(data,status){
		//Remove the headers if no elements are selected
		if(($("#elements").val().length === 0) && $("#partialPart").val().length === 0){
			$("#formResults").html("");
		}
		//Otherwise, return the data
		else{
			$("#formResults").html(data);
		}
	});
	return false;
};

//If one of the values goes to or from 1002 or greater, make it look infinite
$("#minThick,#maxThick").change(function(){
	checkInfinite();
});

function checkInfinite(){
	if($("#minThick").val() > 1000){
		$("#minThick").addClass('infinity');
	}
	else{
		$("#minThick").removeClass('infinity');
	}

	if($("#maxThick").val() > 1000){
		$("#maxThick").addClass('infinity');
	}
	else{
		$("#maxThick").removeClass('infinity');
	}
}

//If we are searching by part number, get all of the elements in the returned parts
$("#partialPart").on('input change',function(e){
	//For element we sell (or that was selected in some other way...that'd be an error)
	$(".active .partSelected").each(function(){
		/*
			Check if an element exists in the selected
			elements table that has an ID equal to the 
			text of the element in the periodic table
			currently being checked by the loop.
			This is done by checking if the length
			property of this hypothetical element 
			returns something truthy (i.e. not 0 or null).
		*/
		if($(".chosenElem:contains(this.id)").length){
			//This element was selected, so mark it as such
			$("this").addClass('partSelected');
		}
		else{
			//This element was not selected so remove the class if it was there
			$("this").removeClass('partSelected');
		}
	});
});