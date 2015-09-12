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

	$(".look-up-word-btn").click(function() {
			$(this).addClass("add-active");
			$(".choose-a-word-btn").removeClass("add-active");
			$(".add-categories-container").hide();
			$(".add-look-up-word-container").fadeIn();
			$(this).children(":first").remove();
			$(this).prepend("<div class='inline-block'><image src='/assets/search_white_32.png' />");
			$(".choose-a-word-btn").children(":first").remove();
			$(".choose-a-word-btn").prepend("<div class='inline-block'><image src='/assets/categories_bootstrap_blue_32.png' />");
	});

	$(".choose-a-word-btn").click(function() {
			$(this).addClass("add-active");
			$(".look-up-word-btn").removeClass("add-active");
			$(".add-look-up-word-container").hide();
			$(".add-categories-container").fadeIn();
			$(this).children(":first").remove();
			$(this).prepend("<div class='inline-block'><image src='/assets/categories_white_32.png' />");
			$(".look-up-word-btn").children(":first").remove();
			$(".look-up-word-btn").prepend("<div class='inline-block'><image src='/assets/search_bootstrap_blue_32.png' />");
	});

	$(".add-category-btn").click(function() {
		alert("Hello world");
		$(this).addClass("pointer");
		$(this).addClass("pointer");
	});
});
