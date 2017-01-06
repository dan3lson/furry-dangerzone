$(document).ready(function(){
	$(function() {
    FastClick.attach(document.body);
	});

	$(".data-url").click(function() {
		$(location).attr("href", $(this).data("url"));
	});

	$(".reload-page").click(function() {
		location.reload();
	});

	$(function () {
  	$("[data-toggle='popover']").popover();
	});

	$("#get-started-btn").click(function() {
		scrollToSection($("#get-started-now").find("h1"));
	});

	$(".container").on("click", ".fa-volume-up, .fa-volume-off", function() {
		const audio = $(this).parent().prev()[0];
		audio.play();
	});

	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		$('a[data-toggle="tab"]').removeClass("active");
	  $(e.target).addClass("active");
	})

	$("#search-form").focus();

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
		$("html, body").animate({ scrollTop: section.offset().top - 50 }, 2000);
	};
});
