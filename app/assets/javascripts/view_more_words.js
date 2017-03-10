// $(document).ready(function() {
// 	var NUM_WORDS = $("#myLeksi-words").data("total");
//
// 	$("#myLeksi-pagination").hide();
//
// 	if (NUM_WORDS > 9) {
// 		var url = $('.pagination .next a').attr('href');
// 		var $viewMoreLink = $("<a>", {
// 			role: "button",
// 			"data-remote": "true",
// 			id: "view-more-link",
// 			class: "btn btn-outline-primary btn-lg",
// 			href: url,
// 			text: "VIEW MORE WORDS"
// 		});
// 		$("#view-more-link-container").html($viewMoreLink);
// 	}
// 	$("#view-more-link-container").on(
// 		"click",
// 		"#view-more-link",
// 		loadMoreWords
// 	);
//
// 	function loadMoreWords() {
// 		var previous_url = $('#view-more-link').attr('href');
// 		var previous_page = parseInt(previous_url.split("=")[1]);
// 		var nextPage = previous_page + 1;
// 		var lastPage = $(".pagination li").length - 2;
// 		var new_url = "/myLeksi?page=" + nextPage;
//
// 		$("#view-more-link").attr("href", new_url);
// 		$("#view-more-link-container").html($viewMoreLink);
// 		if (nextPage > lastPage) $("#view-more-link").hide();
// 		spinner();
// 	}
//
// 	function spinner() {
// 		$(".spinner").hide();
//
// 		$(document).ajaxStart(function() {
// 			$("#view-more-link-container").hide();
// 			$(".spinner").fadeIn();
// 		});
//
// 		$(document).ajaxStop(function() {
// 			$("#view-more-link-container").fadeIn();
// 			$(".spinner").fadeOut();
// 		});
// 	};
// });
