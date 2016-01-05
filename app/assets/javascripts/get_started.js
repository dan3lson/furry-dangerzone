$(document).ready(function() {
	$("#get-started-goal-cont-btn").attr('disabled', true);

	$(".weekly-goal-form").click(function() {
		$("#get-started-goal-cont-btn").attr('disabled', false);
	});

	$("#get-started-goal-cont-btn, #get-started-goal-skip-btn").click(function() {
		$("#guest-weekly-goal-container").hide();
		$("#guest-select-words-container").fadeIn();
		scroll_to_top();
	});

	$("#get-started-finish-btn").click(function() {
		var $word_ids = $("#gs-rand-word-ids").html();
		$("#completed-fund-word-name").html($.trim($(
			"#chosen-word-header-container"
		).html()));
	});

	$("#get-started-save-my-progress-btn").click(function() {
		var $word_ids = $("#gs-rand-word-ids").html();
		var $completed_fund = $(".palabra-id").html();
		var $weekly_goal = $("input[name=weekly_goal]:checked").val()
		var $time_spent = $("#gs-time-spent").html();

		save_progress($word_ids, $completed_fund, $weekly_goal, "Fundamentals",
			$time_spent);
	});

	function scroll_to_top() {
		$("html, body").animate({ scrollTop: 0 }, "slow");
	};

	function save_progress(word_ids, completed_fund, weekly_goal, game_name,
		time_spent_in_min) {
		$url = "/signup?word_ids=" + word_ids + ";completed_fund=" +
		completed_fund + ";weekly_goal=" + weekly_goal + ";game_name=" + game_name
		+ ";time_spent_in_min=" + time_spent_in_min;
		$(location).attr("href", $url);
	};
});
