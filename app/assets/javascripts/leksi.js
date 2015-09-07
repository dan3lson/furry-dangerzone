$(document).ready(function(){
	$(".my-stats-btn").click(function() {
		$(".achievements-btn").removeClass("active");
		$(this).addClass("active");
		$(".achievements-container").hide();
		$(".leaderboard-container").hide();
		$(".my-stats-container").fadeIn();
	});

	$(".achievements-btn").click(function() {
		$(".my-stats-btn").removeClass("active");
		$(this).addClass("active");
		$(".my-stats-container").hide();
		$(".leaderboard-container").hide();
		$(".achievements-container").fadeIn();
		$(".points-container").fadeIn();
	});

	$(".leaderboard-btn").click(function() {
		$(".my-stats-btn").removeClass("active");
		$(".achievements-btn").removeClass("active");
		$(".my-stats-container").hide();
		$(".achievements-container").hide();
		$(".leaderboard-container, .leaderboard-gold").fadeIn();
		$(".leaderboard-silver, .leaderboard-bronze").fadeIn();
		$(".leaderboard-last-seven").fadeIn();
	});

	$(".game-start").click(function() {
		window.location.assign($(this).data("url"));
	});
});
