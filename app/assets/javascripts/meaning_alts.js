$(document).ready(function() {
	$(".container").on("click", ".mean-alt-edit-btn", function() {
		var $footer = $(this).parents(".card-footer");
		var $cardBlock = $footer.prev();
		var meaningAltID = $cardBlock.data("meaning-alt-id");
		$.getScript("/school/meaning_alts/" + meaningAltID + "/edit");
	});
});
