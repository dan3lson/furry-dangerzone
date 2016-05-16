$(document).ready(function() {
	var url = $('.pagination .next a').attr('href');
	var $view_more_link = $("<a>", {
		role: "button",
		"data-remote": "true",
		id: "view-more-link",
		class: "btn btn-info btn-block",
		href: url,
		text: "VIEW MORE WORDS"
	});

	$("#myLeksi-pagination").hide();
	$("#view-more-link-container").html($view_more_link);
	$("#view-more-link").click(load_more_words);

	function load_more_words() {
		var num_words = $("#myLeksi-words .panel-default").length;
		var next_page = num_words / 15 + 1;
		var last_page = $(".pagination li").length - 2;
		var new_url = "/myLeksi?page=" + next_page;

		$("#view-more-link-container").append($view_more_link);
		$("#view-more-link").attr("href", new_url);
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
