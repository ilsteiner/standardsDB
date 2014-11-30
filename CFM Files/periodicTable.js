$(".sold").click(function() {
	$(this).toggleClass('selected');

	//Clear the hidden input for the selected elements
	$("#elements").val("");

	//Put the text of the symbol for each selected element into an array
	var selElems = $(".selected > .symbol").map(function(){
						return $(this).text();
					}).get();
	
	//Convert that array to a comma delimited list and set it as the value of the hidden input
	$("#elements").val(selElems.join());
	
});

//Code for the jQueryUI slider
$(function() {
    $( "#rangeSlider" ).slider({
      range: true,
      min: 2,
      max: 1000,
      step: 2,
      values: [ 2, 500 ],
      slide: function( event, ui ) {
      	$("#minThick").val(Number(ui.values[ 0 ]));
      	$("#maxThick").val(Number(ui.values[ 1 ]));
      }
    });
    $( "#minThick" ).val( Number($( "#rangeSlider" ).slider( "values", 0 )));
    $( "#maxThick" ).val( Number($( "#rangeSlider" ).slider( "values", 1 )));

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