$(document).ready(function() {
	$("#vks-main-container").on("click", ".vks-assess-word", function() {
		$("#vks-main-container").hide();
		$("#vks-chosen-word-id").html($(".vks-assess-word").data("word-id"));
		var $word_name = $(".panel-heading").find("h4").html();
		$(".vks-chosen-word-name").html($word_name);
		$("#vks-identify-knowledge").fadeIn();
	});

	$("#vks-identify-knowledge").on("click", ".vks-emojis div", function() {
		$("#vks-categories").fadeIn();
		var $selected_emoji = $(this).find("img");
		var $other_emojis = $(this).siblings().find("img");
		var $categories = $("#vks-categories p");
		var $category_num = $(".vks-emojis div").index(this);

		$other_emojis.css("border", "none");
		$other_emojis.css("opacity", ".3");
		$categories.hide();
		$selected_emoji.css("border", "4px double #5bc0de");
		$selected_emoji.css("opacity", "1");
		$categories.eq($category_num).fadeIn();

		if ([0, 1].indexOf($category_num) != -1) {
			$(".input-focus").val("");
		}

		if ([2, 3, 4].indexOf($category_num) != -1) {
			$("#vks-defs-or-syns-container").show();
			$(".input-focus").focus();
		} else {
			$("#vks-defs-or-syns-container").hide();
		}

		if ([4].indexOf($category_num) != -1) {
			$("#vks-example-sentence").show();
		} else {
			$("#vks-example-sentence").hide();
		}
	});
});
