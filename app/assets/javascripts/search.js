$(document).ready(function() {
	$(".container").on("input", "#input_search", function() {
		$("#search-form").focus();
		if (empty($(this))) {
			$("#search-form button").prop("disabled", true);
		} else {
			$("#search-form button").prop("disabled", false);
		}
	});

	function empty($field) {
		return $field.val().trim() == "";
	}
});
