$(document).ready(function() {
	$(".container").on("click", "#search-btn", function(e) {
		var $search = $("input[type='search']");
		var search = $search.val();
		var accountType = $(this).data("account-type");
		$(".alert").remove();

		getBadWords().done(function(response) {
			var badRegex = new RegExp("\\b(" + response.join("|") + ")\\b", "ig");

			if (hasBadWords(search, badRegex)) {
				var $alert = createElem("div", "alert alert-danger");
				var $icon = createElem("i", "fa fa-warning");
				$alert.append(
					$icon,
					" Don\'t use bad words; your Teacher may see what you just did."
				);
				$(".search-results-container").append($alert);
			} else {
				$.getScript(
					"/search_results?search=" + search +
					"&account_type=" + accountType
				);
			}
		});
	});

	function hasBadWords(text, regex) {
		var regexes = {};
		var types = [];
		regexes["bad-words"] = regex;

		for (var type in regexes) {
			if (regexes[type].test(text)) {
				return true;
			}
		}

		return false;
	}

	function getBadWords() {
		return $.getJSON('/bad-words/en.json');
	}

	function createElem(elem, _class, _id) {
		_class = _class || null;
		_id = _id || null;
		return $("<" + elem + ">", { class: _class, id: _id });
	}
});
