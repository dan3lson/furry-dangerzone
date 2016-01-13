$(document).ready(function() {
	$("#vks-main-container").on("click", ".vks-assess-word", function() {
		$("#vks-main-container").hide();
		$("#vks-chosen-word-id").html($(".vks-assess-word").data("word-id"));
		$("#vks-chosen-word-name").html(
			$(".panel-heading").find("h4").html()
		);
		$("#vks-category-one").fadeIn();
	});

	$("#vks-identify-knowledge").on("click", ".vks-emojis div", function() {
		$(this).siblings().css("border", "none");
		$("#vks-categories p").hide();
		$(this).css("border", "3px dotted antiquewhite");
		var $category_num = $(".vks-emojis div").index(this);
		$("#vks-categories p").eq($category_num).fadeIn();
	});
});
