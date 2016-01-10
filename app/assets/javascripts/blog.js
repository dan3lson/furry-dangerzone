$(document).ready(function() {
	$("#blog-leksi-name-snapshot").click(function() {
		$(this).empty().append(
			"<image src='/assets/leksi_name_revealed.png' />"
		);
		$(this).removeClass("pointer");
	});
});
