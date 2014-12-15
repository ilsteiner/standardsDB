function disableFilters(){
	$("input").not("#partialPart").attr('disabled', 'disabled');
	$("#rangeSlider").slider('disable');	
}

function enableFilters(){
	$("input").not("#partialPart").removeAttr('disabled');
	$("#rangeSlider").slider('enable');	
}

//Update the list of selected elements (for searching)
$(".active").click(function() {
	$(this).toggleClass('selected');

	//Clear the part number field
	$("#partialPart").val("");

	//If the filters were disabled, enable them
	enableFilters();

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

function makeButtonsClickable(){
	//Update the list of products chosen for certification

	//Make the current list into an array of values
	var currParts = $("#certParts").val().split(',');

	//Put the count of selected parts in the div that displays that
	if((currParts.length - 1) < 1){
		$("#numberOfCertParts").text("None");	
	}
	else{
		$("#numberOfCertParts").text(currParts.length - 1);
	}

	//If any of the displayed products are in the list, mark them as such
	$(".certify").each(function(){
		//Get the part number
		var thePart = $(this).parent().parent().parent().closest('tr').children(".partNumVal").text();

		console.log(currParts.join(","));

		//If the part number is in our list of selected parts, mark it selected
		if($.inArray(thePart,currParts) > -1){
			$(this).addClass("selected");
		}
	});

	//When clicking a certify button, toggle it's part number's placement in the list
	$(".certify").click(function() {
		$(this).toggleClass('selected');

		//Get the part number
		var thePart = $(this).parent().parent().parent().closest('tr').children(".partNumVal").text();

		console.log($(this).parent().parent().parent().closest('tr').children(".partNumVal").text());

		//Make the current list into an array of values
		var currParts = $("#certParts").val().split(',');

		//If this is a newly chosen product
		if($(this).hasClass("selected")){
			//Add this part number to the array
			currParts.push(thePart);
		}
		else{
			//Remove this part number from the array
			currParts.splice($.inArray(thePart,currParts),1);
		}

		//Replace the list with the new list with the part number removed
		$("#certParts").val(currParts.join(','));

		//Put the count of selected parts in the div that displays that
		if((currParts.length - 1) < 1){
			$("#numberOfCertParts").text("None");	
		}
		else{
			$("#numberOfCertParts").text(currParts.length - 1);
		}
	});

	//Make the "Clear" button clear the selected standards
	$("#clearCertify").click(function() {
		$("#certParts").val("");
		$(".certify").removeClass("selected");
		$("#numberOfCertParts").text("None");
	});

	//Make the "Certify All" button show a confirmation popup
	$("#certifyAll").click(function() {
		if($("#numberOfCertParts").text() == "0"){
			$("#certConfirmation").text("No products selected for certification.");	
		}
		else if($("#numberOfCertParts").text() == "1"){
			$("#certConfirmation").html("<p>You are about to certify " + $("#numberOfCertParts").text() + " product</p>"
				+ $("#certParts").val().replace(/,/g, '<br>'));
		}
		else{
			$("#certConfirmation").html("<p>You are about to certify " + $("#numberOfCertParts").text() + " products</p>"
				+ $("#certParts").val().replace(/,/g, '<br>'));
		}
		$('#certConfirmation').dialog('open');
	});

	//Make the "Create New" button take the user to the page to create new stnadards
	$(".newStand").click(function(){
		//Get the part number
		var thePart = $(this).parent().parent().parent().closest('tr').children(".partNumVal").text();

		window.open('newStandard.cfm?partNumber=' + thePart, '_blank');
	});
}

//Make select inputs look better
$("select").selectmenu();

$("input").on('input change',function(){
	$("#sliderForm").submit();
});

$("#rangeSlider").on("slidestop", function(e){
    $("#sliderForm").submit();
});

//If you uncheck one checkbox and the other is already unchecked, check that one
$("#foil").on('change', function(e){
	if($("#plated").not(":checked")){
		$("#plated").prop('checked', true);
		$("#sliderForm").submit();
	}
});

$("#plated").on('change', function(e){
	if($("#foil").not(":checked")){
		$("#foil").prop('checked', true);
		$("#sliderForm").submit();
	}
});

//Make the cert confirmation dialog into a dialog
$(function() {
$("#certConfirmation").dialog({
	modal: true,
	title: "Confirm Certification",
	autoOpen: false,
	closeOnEscape: true,
	height: "auto",
	buttons: [
		{
			text: "Confirm",
			click: function() {
	        	$( this ).dialog("close");
	        	//Submit the form
	        	$("#newCertification").submit();
	        	$("#clearCertify").click();
	        	//Reload the inventory form
	        	$("#sliderForm").submit();
	      	},
	      	icons: {
	      		primary: "ui-icon-check"
	      	}
      	},
      {
      	text: "Cancel",
      	click: function() {
        	$( this ).dialog( "close" );
      	},
      	icons: {
	      		primary: "ui-icon-close"
	    }	
      }
    ]
	});
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

$(document).ready(function() {
	//Take over the submit function of the inventory form
	$("#sliderForm").submit(updateList);

	//Take over the submit function of the new certification form
	$("#newCertification").submit(addCert);
});

//Query the DB for the parts associated with the parameters selected
function updateList() {
	$("#loading").show();

	$.post('inventory.cfm', $('input').serialize(),function(data,status){
		//Remove the headers if no elements are selected
		if(($("#elements").val().length === 0) && $("#partialPart").val().length === 0){
			$("#formResults").html("");
		}
		//Otherwise, return the data
		else{
			$("#formResults").html(data);

			//Make the buttons clickable
			makeButtonsClickable()

			//Make the table sortable
			$("#resultTable").tablesorter({
				headers: {7: {sorter: false}}
			});
		}

		$("#loading").hide();
	});
	return false;
};

//Add the selected standards to a new certification
function addCert() {
	$.post("addToCert.cfm",$("#newCertification").serialize(),
		function(response){
			alert(response);
		},"html");
	return false;
};

//If one of the values goes to or from 1002 or greater, make it look infinite
$("#minThick,#maxThick").change(function(){
	checkInfinite();
});

//Add the appropriate class to make infinites appear infinite
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
	//Remove the 'selected' class from all of the elements, if they have it
	$(".selected").removeClass('selected');

	//Remove all of the elements from the "currently selected" list
	$("#elements").val("");

	//If the part number field has a value, deactivate the filters
	if($("#partialPart").val().length > 0){
		disableFilters();
	}
	//Otherwise activate them
	else{
		enableFilters();
	}

	//For each element we sell (or that was selected in some other way...that'd be an error)
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