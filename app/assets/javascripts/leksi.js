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

	setTimeout(function(){
	  $(".alert-success").fadeOut()
	}, 2000);

	$(function () {
  	$('[data-toggle="popover"]').popover()
	});

	spinner();

	function spinner() {
		$(".spinner").hide();

		$(document).ajaxStart(function(){
			$(".spinner").fadeIn();
			$("#awfs-suc-war-err-container").hide();
		});

		$(document).ajaxStop(function(){
			$(".spinner").fadeOut();
			$("#awfs-suc-war-err-container").fadeIn();
		});
	};
});
