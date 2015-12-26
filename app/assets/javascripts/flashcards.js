$(document).ready(function() {
	$("#card").flip();

	$(".flashcards-btn").click(function() {
		var $tag_container = $(this).parent().parent().parent().find(".panel-body");
		var $tag_id = $tag_container.data("tag-id");
		var $tag_name = $tag_container.data("tag-name");
		var $flashcard_info_request = $.ajax({
			type: "GET",
			url: "/flashcards?tag_id=" + $tag_id,
			dataType: "json"
		});

		$flashcard_info_request.done(function(response) {
			var $words = response.words;
			var $num_words = $words.length;
			var $limit = $num_words - 1;

			initalize_header($words, $num_words, $tag_name);
			activate_controls($words, $limit);
		});
	});

	return_to_myTags_index_page();

	function initalize_header(words, num_words, tag_name) {
		$("#myTags-container").hide();
		$("#flashcard-game").fadeIn();
		$(".full-header").html(truncate(tag_name, 23));
		$(".full-header").prepend(
			"<i class='fa fa-chevron-left pull-left pointer'" +
			"id='flashcards-back-btn'></i>"
		);
		$("#current-flashcard-num").html(1);
		$("#total-flashcard-num").html(num_words);
		$("#flashcard-front").html(words[0].name);
		$("#flashcard-back").html(words[0].definition);
		$("#flashcard-prev-btn").attr('disabled', true);
		$("#flashcard-next-btn").attr('disabled', false);
	}

	function activate_controls(words, limit) {
		if (words.length == 1) {
			$("#flashcard-prev-btn").attr('disabled', true);
			$("#flashcard-next-btn").attr('disabled', true);
		}

		var $i = 0;

		$("#flashcard-next-btn").unbind("click").click(function() {
			if ($i < limit) {
				$i++;
				$("#current-flashcard-num").html($i + 1);
				$("#flashcard-front").html(words[$i].name);
				$("#flashcard-back").html(words[$i].definition);
				$("#flashcard-prev-btn").attr('disabled', false);
			}

			if ($i == limit) {
				$("#flashcard-next-btn").attr('disabled', true);
				$("#flashcard-prev-btn").attr('disabled', false);
			}
		});

		$("#flashcard-prev-btn").unbind("click").click(function() {
			if ($i >= 1) {
				$("#current-flashcard-num").html($i);
				$i--;

				$("#flashcard-front").html(words[$i].name);
				$("#flashcard-back").html(words[$i].definition);
				$("#flashcard-next-btn").attr('disabled', false);
			}

			if ($i == 0) {
				$("#flashcard-next-btn").attr('disabled', false);
				$("#flashcard-prev-btn").attr('disabled', true);
			}
		});
	};

	function return_to_myTags_index_page() {
		$(".container").on("click", "#flashcards-back-btn", function() {
			$("#flashcard-game").hide();
			$("#myTags-container").fadeIn();
			$(".full-header").html("Tags");
			$(".full-header").children(":first-child").remove();
		});
	}

	function truncate(str, length) {
		return str.length > length ? str.substring(0, length - 3) + '...' : str
	}
});
