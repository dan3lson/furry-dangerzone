$(document).ready(function() {
	$(".spe-bee-q-a").click(function() {
		$btn = $(this);
		$fa = $btn.find(".fa");
		if ($fa.hasClass("fa-plus")) {
			$fa.removeClass("fa-plus").addClass("fa-minus");
		} else {
			$fa.removeClass("fa-minus").addClass("fa-plus");
		}
	  $btn.next().slideToggle("fast");
	});
});
