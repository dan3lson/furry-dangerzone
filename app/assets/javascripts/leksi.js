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

	setTimeout(function(){
	  $(".alert-success").fadeOut()
	}, 2000);

	$(function () {
  	$('[data-toggle="popover"]').popover()
	});

	$("#try-for-free-btn").click(function() {
		scroll_to_section("#get-started-now");
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

	function scroll_to_section(section) {
		$('html, body').animate({
				scrollTop: $("#get-started-now").offset().top - 50
		}, 2000);
	};
});
