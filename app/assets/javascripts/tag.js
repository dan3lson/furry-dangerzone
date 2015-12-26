$(document).ready(function() {
	$(".tag-rand-fund").click(function() {
		play_random_word($(this), "/fundamentals?word_id=");
	});
	$(".tag-rand-jeop").click(function() {
		play_random_word($(this), "/jeopardy_tag?tag_id=");
	});
	$(".tag-rand-free").click(function() {
		play_random_word($(this), "/freestyle?word_id=");
	});

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
