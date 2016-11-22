$(document).ready(function(){
	$(".sneak-peak-btn").click(function() {
		var $sneakPeakContainers = $(".sneak-peak-container");
		var $sneakPeakContainer = $(this).parent().parent();
		var $sneakPeakImgContainer = $("#sneak-peak-img-container");
		var game = $(this).data("game");
		var gameName = $sneakPeakContainer.find("h4").text();
		var bgColor = "bg-primary";

		$sneakPeakImgContainer.siblings().html(gameName);
		$sneakPeakContainers.removeClass(bgColor).removeClass("text-white");
		$sneakPeakContainer.addClass(bgColor).addClass("text-white");
		$sneakPeakImgContainer.attr("class", "col-sm-7 " + bgColor);
		$sneakPeakImgContainer.find("img").hide();
		$("#" + game).fadeIn("slow");
	});
});
