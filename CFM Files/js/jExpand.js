(function($){
    $.fn.jExpand = function(){
        var element = this;

        // $(element).find("tr:odd").addClass("odd");
        $(element).find("tr:not(.certRow)").hide();
        $(element).find("tr:first-child").show();

        $(element).find("tr.certRow").click(function() {
            $(this).next("tr").toggle();
            $(this).find('.expandIcon').toggleClass('expandedIcon');
        });
        
    }    
})(jQuery); 