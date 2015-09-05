$(document).ready(function(){
	$(".my-stats-btn").click(function() {
		$(".leaderboard-btn").removeClass("active");
		$(this).addClass("active");
		$(".leaderboard-container").hide();
		$(".my-stats-container").fadeIn();
	});

	$(".leaderboard-btn").click(function() {
		$(".my-stats-btn").removeClass("active");
		$(this).addClass("active");
		$(".my-stats-container").hide();
		$(".leaderboard-container, .leaderboard-gold").fadeIn();
		$(".leaderboard-silver, .leaderboard-bronze").fadeIn();
		$(".leaderboard-last-seven").fadeIn();
	});
});
