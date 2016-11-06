$(document).ready(function(){
	$(".sneak-peak-btn").click(function() {
		var $sneakPeakContainers = $(".sneak-peak-container");
		var $sneakPeakContainer = $(this).parent().parent();
		var $sneakPeakImgContainer = $("#sneak-peak-img-container");
		var game = $(this).data("game");
		var bgColor = $(this).data("color");

		$sneakPeakContainers.removeClass("bg-danger")
												.removeClass("bg-warning")
												.removeClass("bg-success");
		$sneakPeakContainer.addClass(bgColor);
		$sneakPeakImgContainer.attr("class", "col-sm-7 " + bgColor);
		$sneakPeakImgContainer.find("img").hide();
		$("#" + game).fadeIn("slow");
	});
});
