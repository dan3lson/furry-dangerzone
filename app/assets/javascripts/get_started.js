$(document).ready(function() {
	$("#gs-goal-cont-btn, #gs-goal-skip-btn").click(function() {
		$("#guest-weekly-goal-container").hide();
		$("#guest-select-words-container, #gs-finish-btn").fadeIn();
		scroll_to_top();
	});

	function scroll_to_top () {
		$("html, body").animate({ scrollTop: 0 }, "slow");
	};
});
