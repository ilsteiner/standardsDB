(function($){
    $.fn.jExpand = function(){
        var element = this;

        // $(element).find(".certRow:nth-child(4)").addClass("odd");
        $(element).find("tr:first-child").show();

        $(element).find("tr.certRow").click(function() {
            $(this).next("tr").toggle();
            toggleExpand($(this).next("td > img"));
            console.log($(this).next("img"));
        });
    }    
})(jQuery);

function toggleExpand(img){
	console.log("Function triggered.");
	console.log(img.src)
	if(img.src === "img/plus.png"){
		img.src = "img/minus.png";	
	}
	else{
		img.src = "img/plus.png";
	}
}