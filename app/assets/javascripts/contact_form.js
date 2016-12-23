$(document).ready(function() {
	$random_string_element = "form strong";
	$($random_string_element).html(create_random_string());

	var $random_string = $($random_string_element).html();

	validate_text_field_live("#cf-name");
	validate_text_field_live("#cf-email");
	validate_text_field_live("#cf-school-name");
	validate_text_field_live("#cf-comments");
	validate_submission_by_human("#prove-ur-human-field", $random_string);

	function create_random_string() {
		var $alphabet_lower_array = "abcdefghjkmnpqrstuvwxyz".split('');
		var $alphabet_upper_array = "ABCDEFGHJKLMNPQRSTUVXYZ".split('');
		var $merged_alphabet = $.merge($.merge([], $alphabet_lower_array),
      $alphabet_upper_array
    );

		var $numbers_array = "123456789".split('');
		var $random_characters = [];

		for (var i = 0; i < 2; i++) {
			var $random_letter = $merged_alphabet[randomRange(50,0)];
			var $random_number = $numbers_array[randomRange(9,0)];
			$random_characters.push($random_letter);
			$random_characters.push($random_number);
		}

		return $random_characters.join('');
	}

	function randomRange (x, y) {
		return Math.floor(Math.random() * (x-y) + y);
	};

	function validate_submission_by_human(input_selector, string) {
		var $word_being_spelled;

		$(input_selector).on('input', function() {
			$word_being_spelled = $.trim($(this).val());

			if ($word_being_spelled == string) {
				inputValidation(input_selector, "success");
				validate_form_fields("#cf-submit-btn");
			} else {
				inputValidation(input_selector, "danger");
				validate_form_fields("#cf-submit-btn");
			}
		});
	}

	function validate_text_field_live(field_input_selector) {
		var $regex = /^[a-zA-Z0-9 .';,?!()@-]+$/;

		$(field_input_selector).on('input', function() {
			$text = $.trim($(this).val());

			if ($text != "" && $regex.test($text)) {
				inputValidation(this, "success");
				validate_form_fields("#cf-submit-btn");
			} else {
				inputValidation(this, "danger");
				validate_form_fields("#cf-submit-btn");
			}
		});
	}

	function validate_form_fields(btn_selector) {
		if($(".has-success").length == 5) {
			$(btn_selector).attr("disabled", false);
		} else {
			$(btn_selector).attr("disabled", true);
		}
	}

	function inputValidation(field_selector, className) {
		$(field_selector).removeClass("form-control-danger")
										 .removeClass("form-control-warning")
										 .removeClass("form-control-success")
										 .addClass("form-control-" + className);
		$(field_selector).parent().removeClass("has-danger")
															.removeClass("has-warning")
															.removeClass("has-success")
															.addClass("has-" + className);
	}
});
