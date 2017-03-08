$(document).ready(function() {
	$(function() {
    FastClick.attach(document.body);
	});

	$(".data-url").click(function() {
		$(location).attr("href", $(this).data("url"));
	});

	$(".reload-page").click(function() {
		location.reload();
	});

	$(".container").on("click", ".fa-volume-up, .fa-volume-off", function() {
		const audio = $(this).parent().prev()[0];
		audio.play();
	});
	// 
	// $(".filter-div").off().on("input", "#input_search", function() {
	// 	$("#search-form").focus();
	// 	if (empty($(this))) {
	// 		$("#search-form button").prop("disabled", true);
	// 	} else {
	// 		$("#search-form button").prop("disabled", false);
	// 	}
	// });

	$(".mean-alt-del-form").parents("form").css("display", "d-inline");
	spinner();

	function empty($field) {
    return $field.val().trim() == "";
  }

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
