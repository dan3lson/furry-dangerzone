$(document).ready(function() {
	$("#blog-leksi-name-snapshot-revealed").hide();

	$("#blog-leksi-name-snapshot").click(function() {
		$(this).remove();
		$("#blog-leksi-name-snapshot-revealed").fadeIn();
	});
});
