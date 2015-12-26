$(document).ready(function() {
	$("#card").flip();

	$(".flashcards-btn").click(function() {
		var $tag_id = $(this).parent().parent().parent().find(
			".panel-body"
		).data("tag-id");

		var $flashcard_info_request = $.ajax({
			type: "GET",
			url: "/flashcards?tag_id=" + $tag_id,
			dataType: "json"
		});

		$flashcard_info_request.done(function(response) {
			var $words = response.words;
			var $num_words = $words.length;
			var $limit = $num_words - 1;

			initalize_header($words, $num_words);
			activate_controls($words, $limit);
		});
	});

	function initalize_header(words, num_words) {
		$("#myTags-container").hide();
		$("#flashcard-game").fadeIn();
		$("#current-flashcard-num").html(1);
		$("#total-flashcard-num").html(num_words);
		$("#flashcard-front").html(words[0].name);
		$("#flashcard-back").html(words[0].definition);
		$("#flashcard-prev-btn").attr('disabled', true);
		$("#flashcard-next-btn").attr('disabled', false);
	}

	function activate_controls(words, limit) {
		var $i = 0;

		$("#flashcard-next-btn").click(function() {
			if ($i < limit) {
				$i++;
				$("#current-flashcard-num").html($i + 1);
				$("#flashcard-front").html(words[$i].name);
				$("#flashcard-back").html(words[$i].definition);
				$("#flashcard-prev-btn").attr('disabled', false);
			}

			if ($("#current-flashcard-num").html() == $("#total-flashcard-num").html()) {
				$("#flashcard-next-btn").attr('disabled', true);
				$("#flashcard-prev-btn").attr('disabled', false);
			}
		});

		$("#flashcard-prev-btn").click(function() {
			if ($i >= 1) {
				$("#current-flashcard-num").html($i);
				$i--;

				$("#flashcard-front").html(words[$i].name);
				$("#flashcard-back").html(words[$i].definition);
				$("#flashcard-next-btn").attr('disabled', false);
			}

			if ($("#current-flashcard-num").html() == "1") {
				$("#flashcard-next-btn").attr('disabled', false);
				$("#flashcard-prev-btn").attr('disabled', true);
			}
		});
	};

	$("#finish-studying-flashcards").click(function() {
		$("#flashcard-game").hide();
		$("#myTags-container").fadeIn();
	});
});
