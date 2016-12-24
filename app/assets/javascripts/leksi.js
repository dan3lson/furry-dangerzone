$(document).ready(function(){
	$(function() {
    FastClick.attach(document.body);
	});

	$(".data-url").click(function() {
		$(location).attr("href", $(this).data("url"));
	});

	$(".reload-page").click(function(){
		location.reload();
	});

	$(function () {
  	$('[data-toggle="popover"]').popover()
	});

	$("#get-started-btn").click(function() {
		scrollToSection($("#get-started-now").find("h1"));
	});

	$(".card-title, .search-results-container, #adventurous-word").on(
		"click", ".fa-volume-up", function() {
		const audio = $(this).parent().prev()[0];

		audio.play();
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

	function scrollToSection(section) {
		$('html, body').animate({
				scrollTop: section.offset().top - 50
		}, 2000);
	};
});
