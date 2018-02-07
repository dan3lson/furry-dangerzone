$(document).ready(function() {
	$(function() {
    FastClick.attach(document.body);
	});

	$(".container").on("click", ".fa-volume-up, .fa-volume-off", function() {
		const audio = $(this).parent().prev()[0];
		audio.play();
	});

	spinner();

	// TODO Make this loading icon be like a modal for the jeopardy activity
	// or place underneath the play button
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
		$("html, body").animate({ scrollTop: section.offset().top - 50 }, 2000);
	};
});
