$(document).ready(function() {
	$(".container").on("click", ".ex-non-ex-edit-btn", function() {
		var $card = $(this).parents(".card");
		var $cardText = $card.find(".card-text");
		var exNonExID = $cardText.data("ex-non-ex-id");
		$.getScript("/school/example_non_examples/" + exNonExID + "/edit");
	});
});
