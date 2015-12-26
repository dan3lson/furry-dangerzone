$(document).ready(function() {
	play_activity(".tag-rand-fund", "/fundamentals?word_id=");
	play_activity(".tag-rand-jeop", "/jeopardy_tag?tag_id=");
	play_activity(".tag-rand-free", "/freestyle?word_id=");

	function play_activity(selector, url) {
		$(selector).click(function() {
			play_random_word($(this), url);
		});
	}

	function play_random_word(this_, url) {
		$tag_id = this_.parent().parent().prev().data("tag-id");
		$activity = this_.data("activity");

		if ($activity == "jeop") {
			window.location.href = url + $tag_id;
		} else {
			var $tag_activity_info_request = $.ajax({
				type: "GET",
				url: "/tag_rand_word?tag_id=" + $tag_id + ";activity=" + $activity,
				dataType: "json"
			});

			$tag_activity_info_request.done(function(response) {
				var $word_id = response.random_word.id;
				window.location.href = url + $word_id;
			});
		}
	}
});
