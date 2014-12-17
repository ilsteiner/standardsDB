(function($){
    $.fn.jExpand = function(){
        var element = this;

        //On click of a parent row, toggle its child row
        $(element).find("tr.certRow").click(function() {
            $(this).next("tr").slideToggle();
            toggleExpand($(this).find('img'));
        });
    }    
})(jQuery);

function toggleExpand(img){
	if(img.attr('src') === "img/plus.png"){
		img.attr('src','img/minus.png');	
	}
	else{
		img.attr('src','img/plus.png');
	}
}