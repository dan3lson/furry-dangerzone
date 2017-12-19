$(document).ready(function() {
	var $searchBtn = $("#search-form button");

	$(".container").on("input", "#input_search", function() {
		if (isEmpty($(this))) {
			updateBtnProp($searchBtn, true);
		} else {
			updateBtnProp($searchBtn, false);
		}
	});

	function isEmpty($field) {
		return $field.val().trim() == "";
	}

	function updateBtnProp($btn_selector, boolean) {
		$btn_selector.prop("disabled", boolean);
	}
});
