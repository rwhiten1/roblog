// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showLoginForm(){
	Effect.Appear("login_form", {duration: 0.5, from:0.5});
}

function hideLoginForm(){
	Effect.Fade("login_form", {duration: 0.5, from:0.5})
}

function cancelArticleForm(event){
	
}
