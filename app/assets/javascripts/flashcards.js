$(document).ready(function(){
	$("#card").flip();

	$("#flashcards-play-btn").click(function(){
		$tag_id = $("#tag-info").data("tag-id");

		$.ajax({
			type: "GET",
			url: "/flashcards?tag_id=" + $tag_id,
			dataType: "json",
			success: function (response) {
				var $word_names = response.word_names;
				var $word_defs = response.word_defs;
				var $max = $word_names.length - 1;
				var $i = 0;

				$("#current-flashcard-num").html(1);
				$("#flashcard-game").show();
				$("#tags-show-page-container").hide("fadeOut");
				$("#flashcard-front").html($word_names[$i]);
				$("#flashcard-back").html($word_defs[$i]);
				activate_controls($word_names, $word_defs, $max, $i);
				$("#flashcard-prev-btn").attr('disabled', true);
				$("#flashcard-next-btn").attr('disabled', false);
			}
		});
	});

	function activate_controls(word_names, word_defs, max, i) {
		$("#flashcard-next-btn").click(function(){
			if (i < max ) {
				i++;
				$("#flashcard-front").html(word_names[i]);
				$("#flashcard-back").html(word_defs[i]);
				$("#flashcard-prev-btn").attr('disabled', false);
				$("#current-flashcard-num").html(i + 1);
			}

			if (i == max) {
				$("#flashcard-next-btn").attr('disabled', true);
				$("#flashcard-prev-btn").attr('disabled', false);
			}
		});

		$("#flashcard-prev-btn").click(function(){
			if (i >= 1) {
				$("#current-flashcard-num").html(i);
				i--;
				$("#flashcard-front").html(word_names[i]);
				$("#flashcard-back").html(word_defs[i]);
				$("#flashcard-next-btn").attr('disabled', false);
			}

			if (i == 0) {
				$("#flashcard-next-btn").attr('disabled', false);
				$("#flashcard-prev-btn").attr('disabled', true);
			}
		});
	};

	$("#finish-studying-flashcards").click(function(){
		location.reload();
	});
});
