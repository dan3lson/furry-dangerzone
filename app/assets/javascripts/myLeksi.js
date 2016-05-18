$(document).ready(function() {
	var NUM_WORDS = $("#myLeksi-words").data("total");

	$("#myLeksi-pagination").hide();

	if (NUM_WORDS > 15) {
		var url = $('.pagination .next a').attr('href');
		var $view_more_link = $("<a>", {
			role: "button",
			"data-remote": "true",
			id: "view-more-link",
			class: "btn btn-info btn-block",
			href: url,
			text: "VIEW MORE WORDS"
		});
		$("#view-more-link-container").html($view_more_link);
	}

	$("#view-more-link-container").on(
		"click",
		"#view-more-link",
		load_more_words
	);

	function load_more_words() {
		var previous_url = $('#view-more-link').attr('href');
		var previous_page = parseInt(previous_url.split("=")[1]);
		var next_page = previous_page + 1;
		var last_page = $(".pagination li").length - 2;
		var new_url = "/myLeksi?page=" + next_page;

		$("#view-more-link").attr("href", new_url);
		$("#view-more-link-container").html($view_more_link);
		if (next_page == last_page) $("#view-more-link").hide();
		spinner();
	}

	function spinner() {
		$(".spinner").hide();

		$(document).ajaxStart(function() {
			$("#view-more-link-container").hide();
			$(".spinner").fadeIn();
		});

		$(document).ajaxStop(function() {
			$("#view-more-link-container").fadeIn();
			$(".spinner").fadeOut();
		});
	};
});
