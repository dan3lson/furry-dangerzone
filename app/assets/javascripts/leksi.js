$(document).ready(function(){
	$(function() {
    FastClick.attach(document.body);
	});

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

	$(".data-url").click(function() {
		$(location).attr("href", $(this).data("url"));
	});

	$(".reload-page").click(function(){
		location.reload();
	});

	$(".look-up-word-btn").click(function() {
		$(".full-header").text("Add");
		$(this).addClass("add-active");
		$(".choose-a-word-btn").removeClass("add-active");
		$(".add-categories-container").hide();
		$(".category-words-container").hide();
		$(".add-look-up-word-container, .search-results").fadeIn();
		$(this).children(":first").remove();
		$(this).prepend("<div class='inline-block'><image src='/assets/search_white_32.png' />");
		$(".choose-a-word-btn").children(":first").remove();
		$(".choose-a-word-btn").prepend("<div class='inline-block'><image src='/assets/categories_bootstrap_blue_32.png' />");
	});

	$(".choose-a-word-btn").click(function() {
		$(".full-header").text("Add");
		$(this).addClass("add-active");
		$(".look-up-word-btn").removeClass("add-active");
		$(".add-look-up-word-container, .search-results").hide();
		$(".category-words-container").hide();
		$(".add-categories-container").fadeIn();
		$(this).children(":first").remove();
		$(this).prepend("<div class='inline-block'><image src='/assets/categories_white_32.png' />");
		$(".look-up-word-btn").children(":first").remove();
		$(".look-up-word-btn").prepend("<div class='inline-block'><image src='/assets/search_bootstrap_blue_32.png' />");
	});

	$(".add-category-btn").click(function() {
		var category_name = jQuery("span", this).html();

		$(".add-categories-container").hide();
		$(".full-header").html(category_name);

		$.ajax({
			type: "GET",
			url: "/search",
			dataType: "html",
			data: { "category_name": category_name }
		})
		.done(function(response) {
			console.log(response.errors)
		});

		$(".category-words-container").fadeIn();
	});

	$(function () {
  	$('[data-toggle="popover"]').popover()
	});

	spinner();

	function spinner() {
		$(".spinner").hide();

		$(document).ajaxStart(function(){
			$(".spinner").fadeIn();
		});

		$(document).ajaxStop(function(){
			$(".spinner").fadeOut();
		});
	};
});
