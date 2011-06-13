/**
 * Created by .
 * User: robwhitener
 * Date: 6/9/11
 * Time: 9:18 PM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $("form[name~='remove_tag_form']").bind("ajax:success", function(evt, data, status, xhr){
		var $form = $(this);
		//$form.find('input[type="text"]').val("");
		//$form.find('div.')

		//put the title in the XHR response
		//$('#comments').append(xhr.responseText);

	}).bind("ajax:complete", function(evt, xhr, status){
		//var $submitButton = $(this).find('input[name="commit"]');
		//$submitButton.text( $(this).data('origText'));
	});
});

$(function(){
    $("#tag_name").autocomplete({
        minLength: 1,
        source: function(request,response){
            var term = request.term;
            lastXhr = $.get("/tags.json",request,function(data,status,xhr){
                var names = [];
                $.each(data, function(key,val){
                    $.each(val, function(k,v){
                        names.push(v.tag_name)
                    });
                });
                response(names);
            });
        }
    })
});
